class BackboneExample.Views.BrowseIndex extends Backbone.View

  template: JST['browse/index']
  state: {}
  initialize: =>
    if _.isEmpty(@state)
      @state.category = BackboneExample.db("Categories").first()
      @state.property_ids = @state.category.get("property_ids")
      @state.property_values = {}
    BackboneExample.Events.on("constrain:add", @addConstraints)
    BackboneExample.Events.on("constrain:remove", @removeConstraints)
    BackboneExample.Events.on("constrain:switch_category", @switchCategory)
  addConstraints: (message)=>
    console.log(['add', message])
    _.each(_.keys(message), (property_id)=>
      @state.property_values["#{property_id}"] ||= []
      if !_.include(@state.property_values["#{property_id}"], message[property_id])
        @state.property_values["#{property_id}"].push(message[property_id])
    )
    @reconstrain()
  removeConstraints: (message)=>
    console.log(['remove', message])
    _.each(_.keys(message), (property_id)=>
      @state.property_values["#{property_id}"] ||= []
      if _.include(@state.property_values["#{property_id}"], message[property_id]) 
        @state.property_values["#{property_id}"] = _.without(@state.property_values["#{property_id}"], message[property_id])
    )
    @reconstrain()
  switchCategory: (message)=>
    @constrain()
  relayout: ()=>
    $(@el).find(".browse-index").layout({resize: false});
  addLayout: =>
    $(@el).find(".browse-index").layout({vgap: 0, type: "border", resize: false})
    @relayout()
    $(window).resize(@relayout)
  getCategoryPropertyIds: =>
    @state.category.get("property_ids")
  getRequiredPropertyIds: =>
    BackboneExample.db("Properties").where(id: {$in: @state.property_ids})
  addCategories: =>
    ul = $(@el).find(".categories > ul")
    ul.html("")
    BackboneExample.db("Categories").each((category)=>
      view = new BackboneExample.Views.BrowseCategory(model: category)
      ul.append(view.render().el)
    )
  addProperties: =>
    property_ids = @getCategoryPropertyIds()
    ul = $(@el).find(".properties > ul")
    ul.html("")
    _.each(BackboneExample.db("Properties").where(id: {$in: property_ids}), (property)=>
      view = new BackboneExample.Views.BrowseProperty(model: property)
      view.parent = @
      ul.append(view.render().el)
    )
  addProducts: =>
    required_property_ids = @getRequiredPropertyIds()

    ul = $(@el).find(".products > ul")
    ul.html("")
    path = _.union(@state.category.get("path"),[@state.category.id])
    console.log(path)
    query = {
      category_ids: {$in: path}
    }

    _.each(@state.property_values, (value, property_id)=>
      if _.size(value) > 0
        query["props.#{property_id}"] = {$in: value}
    )
    console.log(query)
    _.each(BackboneExample.db("Products").where(query), (product)=>
      view = new BackboneExample.Views.BrowseProduct(model: product)
      ul.append(view.render().el)
    )
  reconstrain: =>
    BackboneExample.Events.trigger("constrain:refresh", @state)
    @constrain()
  constrain: =>
    @addCategories()
    @addProperties()
    @addProducts()
  render: =>
    $(@el).html(this.template({}))
    $(@el).addClass()
    @addLayout()
    @constrain()
    @
