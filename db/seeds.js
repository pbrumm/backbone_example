
db.dropDatabase();
db.users.save(
{
  "_id": 5,
  "email": "pete@petebrumm.com",
  "address": {"addr1": "Test Address", "addr2": "", "city": "", "state": "", "zip": ""}
});

db.categories.save(
{
  "_id": 1,
  "name": "Root",
  "depth": 0,
  "path": [],
});
db.categories.save(
{
  "_id": 7,
  "name": "Health",
  "depth": 1,
  "path": [1],
});
db.categories.save(
{
  "_id": 12,
  "name": "Science",
  "depth": 1,
  "path": [1],
});
db.properties.save(
{
  "_id": 2,
  "name": "Color",
  "searchable": true,
  "values": [],
  "category_ids": [],
  "val_products": {}
});
db.properties.save(
{
  "_id": 9,
  "name": "Weight",
  "searchable": true,
  "values": [],
  "category_ids": [],
  "val_products": {}
});
db.properties.save(
{
  "_id": 10,
  "name": "Height",
  "searchable": true,
  "values": [],
  "category_ids": [],
  "val_products": {}
});
// helper function 
save_prod_and_update_attrs = function(prod){
    // save product
    prod.property_ids = _.map(_.keys(prod.props), function(id) {return parseInt(id)})
    category_ids = db.categories.distinct("path", {"_id": {$in: prod.category_ids}})
    path = _.union(category_ids, prod.category_ids)
    prod.category_ids = path
    db.products.save(prod)
    // update other models
    _.each(_.keys(prod.props), function(prop_id) {
      attr = prod.props[prop_id]
      set_changes = { "category_ids": {"$each" : prod.category_ids}}
      set_changes['val_products.' + prod.props[prop_id]] = prod["_id"]
      set_changes['values'] = prod.props[prop_id]
      set_changes['product_ids'] = parseInt(prod['_id'])
      db.properties.update({_id:  parseInt(prop_id)}, 
                           {
                             $addToSet: set_changes
                           })
    })
    
    db.categories.update(
      {"_id": {$in: path}}, 
      {
        $addToSet: {
          product_ids: prod['_id'], 
          property_ids: { $each: _.map(_.keys(prod.props), function(id) {return parseInt(id)})}
        }
      },
      false,true
    )

}

save_prod_and_update_attrs({
  "_id": 3,
  "name": "Test Product",
  "category_ids": [12],
  "price": 19.95,
  "currency": "usd",
  'props': {
    "2": "white",
    "10": "50",
  }
});

save_prod_and_update_attrs({
  "_id": 6,
  "name": "Test Product2",
  "category_ids": [7],
  "price": 29.95,
  "currency": "usd",
  'props': {
    "2": "red",
    "9": "15",
    "10": "45"
  }
})
save_prod_and_update_attrs({
  "_id": 8,
  "name": "Test Product3",
  "category_ids": [7],
  "price": 39.95,
  "currency": "usd",
  'props': {
    "2": "red",
    "9": "16",
    "10": "35"
  }
})
save_prod_and_update_attrs({
  "_id": 11,
  "name": "Test Product4",
  "category_ids": [12],
  "price": 49.95,
  "currency": "usd",
  'props': {
    "2": "green",
    "9": "14",
    "10": "35"
  }
})

//db.carts.save(
//{
//  "user_id": 5,
//  "status": "open",
//  "items": [
//    {"product_id": 3, "qty": 1, "name": "Test Product", "price": 19.95, "currency": "usd"}
//  ]
//});
db.users.ensureIndex({"email": 1});
db.categories.ensureIndex({"path": 1});
db.categories.ensureIndex({"depth": 1});
db.properties.ensureIndex({"category_ids": 1});
db.products.ensureIndex({"category_ids": 1, "price": 1});
db.products.ensureIndex({"category_ids": 1, "price": -1});
db.carts.ensureIndex({"user_id": 1});
db.carts.ensureIndex({"status": 1});
db.carts.ensureIndex({"items.product_id": 1});
/// Problems with this data model.
/// 1. value's are placed as hash key's.   can't contain periods or spaces.   Need some other mapping from striped version to full
/// 2. for a lot of products, category and attribute could have lots of product ids.  may need better location

