# spec/basket_spec.rb
require 'spec_helper'
require_relative '../lib/basket'
require_relative '../lib/adapters/product_catalog_adapter'
require_relative '../lib/adapters/delivery_rule_adapter'
require_relative '../lib/adapters/offer_adapter'

Product = Struct.new(:code, :name, :price)

RSpec.describe Basket do
  let(:product_r01) { Product.new('R01', 'Red Widget', 32.95) }
  let(:product_g01) { Product.new('G01', 'Green Widget', 24.95) }

  let(:catalog) do
    Class.new(ProductCatalogAdapter) do
      def find(code)
        {
          'R01' => Product.new('R01', 'Red Widget', 32.95),
          'G01' => Product.new('G01', 'Green Widget', 24.95)
        }[code]
      end
    end.new
  end

  let(:delivery_rule) do
    Class.new(DeliveryRuleAdapter) do
      def delivery_cost(subtotal)
        subtotal < 50 ? 4.95 : (subtotal < 90 ? 2.95 : 0)
      end
    end.new
  end

  let(:offer) do
    Class.new(OfferAdapter) do
      def discount(items)
        red_widgets = items.select { |item| item.code == 'R01' }
        (red_widgets.count / 2) * (red_widgets.first&.price.to_f / 2)
      end
    end.new
  end

  let(:basket) { Basket.new(catalog: catalog, delivery_rule: delivery_rule, offers: [offer]) }

  describe '#add' do
    it 'adds items to the basket' do
      basket.add('R01')
      expect(basket.items.count).to eq(1)
      expect(basket.items.first.code).to eq('R01')
    end

    it 'raises an error for unknown product code' do
      expect { basket.add('INVALID') }.to raise_error("Product not found for code INVALID")
    end
  end

  describe '#total' do
    it 'returns correct total without offers or delivery discount' do
      basket.add('G01') # $24.95 + $4.95 delivery
      expect(basket.total).to eq('29.90')
    end

    it 'applies red widget half-price offer and correct delivery' do
      basket.add('R01')
      basket.add('R01') # Offer applies
      expect(basket.total).to eq('54.38') # (32.95 + 16.475) + 4.95
    end

    it 'applies no delivery charge for high subtotal' do
      basket.add('R01')
      basket.add('R01')
      basket.add('G01')
      expect(basket.total).to eq('77.32') # subtotal = 84.375, delivery = 2.95
    end
  end
end
