#http://documentcloud.github.com/backbone/#Collection

#assets/javascripts/collections/properties.js.coffee
class window.Properties extends Backbone.Collection
  model: Property
  # handles sorting of elements as they are added
  comparator: (prop) =>
    prop.get("name")

properties = new Properties()
properties.on("add", (property)=>
  console.log("property added")
)

properties.create({name: "Weight", values: ["15", "16", "17"]})
properties.create({name: "Color", values: ["red", "white", "blue"]})

properties.reset([
  {name: "Weight", values: ["15", "16", "17"]},
  {name: "Color", values: ["red", "white", "blue"]}
])

properties.select((property)=>
  property.get("name") == "Color"
)
properties.select((property)=>
  _.include(property.get("values"), "16")
)

properties.pluck("name")
# returns ["Color", "Weight"]