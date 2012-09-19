class Property
  include Mongoid::Document

  def as_json(options = {})
    {
      id: id,
      name: name,
      values: values
    }
  end
end
