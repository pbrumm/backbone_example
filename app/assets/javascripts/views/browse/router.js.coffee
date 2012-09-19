class BackboneExample.Routers.Browse extends Backbone.Router
  initialize: ()=>
    BackboneExample.Router = @
    #Backbone.history.start()
  routes:
    "":            "index"
    "detail/:id":  "detail"
   # "*action":      "index"
  index: (actions)=>
    @browse_index ||= new BackboneExample.Views.BrowseIndex({el: $("#app")})
    @browse_index.render()
  detail: (id)=>
    console.log("detail page #{id}")
    product = BackboneExample.db("Products").get(id)
    @detail_view ||= new BackboneExample.Views.BrowseDetail({el: $("#app")})
    @detail_view.model = product
    @detail_view.render()