require 'yaml'
require_relative '../adapters/product_catalog_adapter'


Product = Struct.new(:code, :name, :price)

class StaticProductCatalog < ProductCatalogAdapter
  def initialize(file_path = 'config/products.yml')
    @products = load_products(file_path)
  end

  def find(code)
    @products[code]
  end

  private

  def load_products(file_path)
    yaml_data = YAML.load_file(file_path)
    yaml_data.each_with_object({}) do |(code, details), hash|
      hash[code] = Product.new(code, details['name'], details['price'])
    end
  end
end
