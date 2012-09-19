class Product
  include Mongoid::Document
  field :name, :type => String
  field :category_ids, :type => Array, :default => []
  field :price, :type => Float
  field :currency, :type => String
  field :props, :type => Hash, :default => {}

  def as_json(options = {})
    {
      id: id,
      name: name,
      category_ids: category_ids || [],
      property_ids: property_ids || [],
      props: props,
      price: price
    }
  end
end
