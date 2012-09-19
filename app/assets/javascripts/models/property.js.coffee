class BackboneExample.Models.Property extends Backbone.Model
  urlRoot: "/properties"
  defaults: 
    name: ""
    category_ids: []
    values: []