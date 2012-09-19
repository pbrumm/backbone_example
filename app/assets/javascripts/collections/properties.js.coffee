class BackboneExample.Collections.Properties extends Backbone.Collection
  model: BackboneExample.Models.Property
  comparator: (prop)=>
    prop.get("name")