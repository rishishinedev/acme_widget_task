# spec/catalog/static_product_catalog_spec.rb
require 'spec_helper'
require_relative '../../../lib/catalog/static_product_catalog'
require 'yaml'

RSpec.describe StaticProductCatalog do
  let(:file_path) { 'spec/fixtures/products.yml' }
  let(:catalog) { StaticProductCatalog.new(file_path) }

  before do
    File.write(file_path, <<~YAML)
      R01:
        name: Red Widget
        price: 32.95
      G01:
        name: Green Widget
        price: 24.95
      B01:
        name: Blue Widget
        price: 7.95
    YAML
  end

  after do
    File.delete(file_path) if File.exist?(file_path)
  end

  describe '#find' do
    it 'returns the correct product struct for known product code' do
      product = catalog.find('R01')
      expect(product.code).to eq('R01')
      expect(product.name).to eq('Red Widget')
      expect(product.price).to eq(32.95)
    end

    it 'returns nil for unknown product code' do
      expect(catalog.find('UNKNOWN')).to be_nil
    end
  end
end
