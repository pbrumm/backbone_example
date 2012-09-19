class BackboneExample.Views.BrowseCategory extends Backbone.View
  tagName: "li"
  template: JST['browse/components/category']
  
  render: =>
    $(@el).html(this.template(@model.toJSON()))
    @
