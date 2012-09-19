class BackboneExample.Collections.PropertyValues extends Backbone.Collection
  model: BackboneExample.Models.PropertyValue
  comparator: (prop_value)=>
    prop_value.get("value")