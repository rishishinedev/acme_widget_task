require_relative 'catalog/static_product_catalog'
require_relative 'rules/tiered_delivery_rule'
require_relative 'offers/red_widget_half_price_offer'

class Basket
  attr_reader :items

  def initialize(catalog:, delivery_rule:, offers:)
    @catalog = catalog
    @delivery_rule = delivery_rule
    @offers = offers
    @items = []
  end

  def add(code)
    product = @catalog.find(code)
    raise "Product not found for code #{code}" unless product

    @items << BasketItem.new(product)
  end

  def total
    subtotal = @items.map(&:price).sum
    discount = @offers.map { |offer| offer.discount(@items) }.sum
    delivery = @delivery_rule.delivery_cost(subtotal - discount)
    format('%.2f', subtotal - discount + delivery)
  end
end

class BasketItem
  attr_reader :product
  attr_accessor :price

  def initialize(product)
    @product = product
    @price = product.price
  end

  def code
    product.code
  end
end
