class Category
  include Mongoid::Document
  field :name, :type => String
  field :depth, :type => Integer
  field :path, :type => Array, :default => []
  field :property_ids, :type => Array, :default => []

  def as_json(options = {})
    {
        id: id,
        name: name,
        depth: depth,
        path: path,
        property_ids: property_ids
    }
  end
end
