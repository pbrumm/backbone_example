properties = new Properties()
#standard
properties.where(id: 1)

# my extension which is mongodb like queries
#app/assets/javascripts/extensions/backbone.collections.js
properties.where(id: {$in: [1,2,3]})

properties.where(category_ids: {$all: [1,2,3]})

products.where(
	"prop.1": "True",
	"prop.2": "15")