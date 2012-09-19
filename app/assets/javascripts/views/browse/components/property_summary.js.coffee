class BackboneExample.Views.BrowsePropertySummary extends Backbone.View
  tagName: "tr"
  template: JST['browse/components/property_summary']
  product_value: null
  render: =>
    json = @model.toJSON()
    json.product_value = @product_value
    $(@el).html(this.template(json))
    @
