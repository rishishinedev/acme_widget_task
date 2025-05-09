#!/usr/bin/env ruby

$LOAD_PATH.unshift(File.expand_path('../lib', __dir__))

require 'basket'
require 'catalog/static_product_catalog'
require 'rules/tiered_delivery_rule'
require 'offers/red_widget_half_price_offer'

catalog = StaticProductCatalog.new
delivery_rule = TieredDeliveryRule.new
offers = [RedWidgetHalfPriceOffer.new]

basket = Basket.new(catalog: catalog, delivery_rule: delivery_rule, offers: offers)

# Add products
basket.add('B01')
basket.add('B01')
basket.add('R01')
basket.add('R01')
basket.add('R01')

puts "\n🛒 Selected Products:"
basket.items.each do |item|
  puts "- #{item.product.name} (#{item.code}) - $#{'%.2f' % item.price}"
end

subtotal = basket.items.map(&:price).sum
discount = offers.map { |offer| offer.discount(basket.items) }.sum
delivery = delivery_rule.delivery_cost(subtotal - discount)
total = subtotal - discount + delivery

puts "\nSubtotal: $#{'%.2f' % subtotal}"
puts "Discount: -$#{'%.2f' % discount}"
puts "Delivery: $#{'%.2f' % delivery}"
puts "✅ Total: $#{'%.2f' % total}"
