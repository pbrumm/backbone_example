window.BackboneExample =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  data: {}
  Router: null
  Events: null
  db: (collection_name)=>
    window.BackboneExample.data[collection_name]
  init: (data)=>
    #$.ajaxPrefilter( ( options, originalOptions, jqXHR ) ->
    #  jqXHR.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
    #  #$('meta[name="csrf-token"]').remove()
    #)
    self = window.BackboneExample
    events_handler = {};
    _.extend(events_handler, Backbone.Events);
    self.Events = events_handler
    _.each(_.keys(data.collections), (key) =>
      collection_name = key.toCamel()
      collection = self.db(collection_name) if self.db(collection_name)
      if !collection && self.Collections[collection_name]
        collection = new self.Collections[collection_name]

      if collection
        collection.reset(data.collections[key])
        self.data[collection_name] ||= collection
      else
        console.log("Couldn't find collection: #{collection_name}")
    )
    self
