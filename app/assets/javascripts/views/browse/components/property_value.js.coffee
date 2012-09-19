class BackboneExample.Views.BrowsePropertyValue extends Backbone.View
  tagName: "li"
  template: JST['browse/components/property_value']
  checked: false
  events: 
    "click input": "handleToggle"
  handleToggle: (e)=>
    input = $(@el).find("input")
    message = {}
    message[@property.id] = @model.get("value")
    if input.attr('checked')
      BackboneExample.Events.trigger("constrain:add", message)
    else
      BackboneExample.Events.trigger("constrain:remove", message)
    true
  render: =>
    json = @model.toJSON()
    $(@el).html(this.template(json))
    if @checked
      input = $(@el).find("input")
      input.attr('checked', true)
    @
