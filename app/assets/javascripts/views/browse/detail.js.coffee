class BackboneExample.Views.BrowseDetail extends Backbone.View
  template: JST['browse/detail']
  relayout: ()=>
    $(@el).find(".browse-detail").layout({resize: false});
  addLayout: =>
    $(@el).find(".browse-detail").layout({vgap: 0, type: "border", resize: false})
    @relayout()
    $(window).resize(@relayout)
  addProperties: =>
    table = $(@el).find(".properties > table")
    table.html("")
    _.each(BackboneExample.db("Properties").where(id: {$in: @model.get("property_ids")}), (property)=>
      view = new BackboneExample.Views.BrowsePropertySummary(model: property)
      view.product_value = @model.get("props")["#{property.id}"]
      table.append(view.render().el)
    )
    table.find("tr:odd").addClass("odd")
  render: =>
    $(@el).html(this.template(@model.toJSON()))
    @addProperties()
    @addLayout()
    @
