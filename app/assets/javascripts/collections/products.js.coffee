class BackboneExample.Collections.Products extends Backbone.Collection
  model: BackboneExample.Models.Product
  comparator: (product)=>
    product.get("name")