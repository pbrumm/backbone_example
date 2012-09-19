class BackboneExample.Views.BrowseProperty extends Backbone.View
  tagName: "li"
  template: JST['browse/components/property']
  initialize: =>
    @propertyValues = new BackboneExample.Collections.Properties().reset(
      _.map(@model.get("values"), (value)=> {value: value})
    )
  addPropertyValues: =>
    ul = $(@el).find("ul.property_values")
    ul.html("")
    selected = @parent.state.property_values["#{@model.id}"] || []
    @propertyValues.each((property_value)=>
      view = new BackboneExample.Views.BrowsePropertyValue(model: property_value)
      view.property = @model
      view.parent = @
      if _.include(selected, property_value.get("value"))
        view.checked = true
      ul.append(view.render().el)
    )
  render: =>
    json = @model.toJSON()
    $(@el).html(this.template(json))
    @addPropertyValues()
    @
