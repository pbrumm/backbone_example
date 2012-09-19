class BrowseController < ApplicationController

	def index
		@data = {
			collections: {
				categories: Category.all.asc(:depth),
				properties: Property.all.asc(:name),
				products: Product.all.asc(:name)
			}
		}
	end
end
