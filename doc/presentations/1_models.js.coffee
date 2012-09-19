#http://documentcloud.github.com/backbone/#Model

#assets/javascripts/models/property.js.coffee
class window.Property extends Backbone.Model
  urlRoot: "/properties"
  defaults:
    name: ""
    category_ids: []
    values: []

# create new class
color = new Property({name: "color", values: ["red", "yellow", "blue"]})
# you can update by setting values in a hash,  there is a success callback
color.set(name: "Color")

color.save()
# sends an async post to backend

color.get("name")
# returns "Colors"
color.on("change", (model)=>
  if model.hasChanged("name")
    console.log("name changed from #{model.previous('name')} to #{model.get('name')}")
)
# same thing but only fires on name changes
color.on("change:name", (model)=>
  console.log("name changed from #{model.previous('name')} to #{model.get('name')}")
)

color.save({category_ids: [1,2,3]},
  success: (data)=>
    console.log("success")
  error: (data)=>
    console.log("errors")
)
# if server returns additional json attributes they will be set on model.
# does a post on new and put's on updates.   works great with rails