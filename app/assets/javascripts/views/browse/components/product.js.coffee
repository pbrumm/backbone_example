class BackboneExample.Views.BrowseProduct extends Backbone.View
  tagName: "li"
  template: JST['browse/components/product']
  render: =>
    json = @model.toJSON()
    $(@el).html(this.template(json))
    @
