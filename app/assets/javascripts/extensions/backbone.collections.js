(function(){
  _.extend(Backbone.Collection.prototype, Backbone.Events, {
    deleteIf: function(callback, options) {
      var matches = this.filter(callback)
      return this.remove(matches, options)
    },
    removeIf: function(filter, options) {
      var matches = this.where(filter)
      return this.remove(matches, options)
    },
    addIf: function(new_models, callback, options) {
      var matches = _.filter(new_models, _.bind(function(model){
      	return callback(this, model)
      },this))
      this.add(matches, options)
      return _.size(matches)
    },
    addIfNotExist: function(new_models, options) {
      var callback = function(models, model) {
        var match = models.get(model.id)
        return _.isUndefined(match) || match == null
      }
      return this.addIf(new_models, callback, options)
    },
    getAll: function(ids) {
      return this.select(function(o){
        return _.include(ids, o.id)
      })
    },
    toggle: function(model){
      if(this.get(model.id)) {
        this.remove([model])
      }else {
        this.add(model)
      }
    },
    find_obj: function(obj, field) {
      var parts = field.split(".")
      var match = obj.get(parts.shift())
      _.each(parts, function(part){
        if(match && !_.isUndefined(match) && !_.isUndefined(match[part])) {
          match = match[part]
        }
      })
      if(_.isUndefined(match)) {
        return null
      } else {
        return match
      }
    },
    item_match: function(r, filters) {
      var matched = true
      _.each(filters, _.bind(function(value, key){
        v = this.find_obj(r, key)
        if(matched) {
          switch(key){
            case "$and":
              sub_match = true
              _.each(value, _.bind(function(vh){
                if(sub_match && this.item_match(r, vh)) {
                  sub_match = true
                }else {
                  sub_match = false
                }
              },this))
              if(!sub_match){
                matched = false
              }
              break;
            case "$or":
              sub_match = false
              _.each(value, _.bind(function(vh){
                if(this.item_match(r, vh)) {
                  sub_match = true
                }
                
              },this))
              if(!sub_match){
                matched = false
              }
              break;
            default:
              if(_.isObject(value) && !_.isRegExp(value)) {
                _.each(value, function(hv, hk){
                  switch(hk){
                    case "$all":
                      if(!_.size(_.intersection(v, hv)) != _.size(hv)) {
                        matched = false
                      }
                      break;
                    case "$in":
                      if(_.isArray(v)) {
                        if(_.size(_.intersection(hv, v)) == 0) {
                          matched = false
                        }
                      }else {
                        if(!_.include(hv, v)) {
                          matched = false
                        }
                      }
                      break;
                    case "$nin":
                      if(_.include(hv, v)) {
                        matched = false
                      }
                      break;
                    case "$ne":
                      if(v == hv) {
                        matched = false
                      }
                      break;
                    case "$eq":
                      if(v != hv) {
                        matched = false
                      }
                      break;
                    case "$gt":
                      if(v <= hv) {
                        matched = false
                      }
                      break;
                    case "$gte":
                      if(v < hv) {
                        matched = false
                      }
                      break;
                    case "$lt":
                      if(v >= hv) {
                        matched = false
                      }
                      break;
                    case "$lte":
                      if(v > hv) {
                        matched = false
                      }
                      break;
                    default:
                      //need to still handle case where sub object matching.   probably need to recurse
                  }
                })
              }else {
                v = this.find_obj(r, key)
                if(_.isArray(v)){
                  if(_.isRegExp(value)){
                    var any_matched = false;
                    _.each(v, function(val){
                      if(!any_matched && v.match(val)) {
                        any_matched = true
                      }
                    })
                    if(!any_matched){
                      matched = false 
                    }
                  }else{
                    matched = _.include(v, value)
                  }
                }else{
                  if(_.isRegExp(value)){
                    if(v == null){
                      matched = false
                    }else if(v.match(value) == null){
                      matched = false
                    }
                  }else if(_.isArray(value)){
                    if(v.match(value) == null){
                      matched = false
                    }
                  }else{
                    if(this.find_obj(r, key) != value){
                      matched = false
                    }
                  }
                }
              }
          }
        }
      },this))
      return matched
    },
    where: function(filters){
      return this.select(_.bind(function(r){
        return this.item_match(r, filters)
      }, this))
    }
  });
  
}).call(this);