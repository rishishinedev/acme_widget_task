# spec/offers/red_widget_half_price_offer_spec.rb
require 'spec_helper'
require_relative '../../lib/offers/red_widget_half_price_offer'


RSpec.describe RedWidgetHalfPriceOffer do
  let(:offer) { RedWidgetHalfPriceOffer.new }

  let(:product_r01) { double('Product', code: 'R01', name: 'Red Widget', price: 32.95) }
  let(:product_g01) { double('Product', code: 'G01', name: 'Green Widget', price: 24.95) }

  let(:item_r01) { double('BasketItem', code: 'R01', price: 32.95) }
  let(:item_g01) { double('BasketItem', code: 'G01', price: 24.95) }

  context 'when there are no red widgets' do
    it 'returns 0 discount' do
      expect(offer.discount([item_g01])).to eq(0)
    end
  end

  context 'when there is 1 red widget' do
    it 'returns 0 discount' do
      expect(offer.discount([item_r01])).to eq(0)
    end
  end

  context 'when there are 2 red widgets' do
    it 'returns half price of one as discount' do
      discount = offer.discount([item_r01, item_r01])
      expect(discount).to eq(32.95 / 2)
    end
  end

  context 'when there are 3 red widgets' do
    it 'still applies discount to only 1 pair' do
      discount = offer.discount([item_r01, item_r01, item_r01])
      expect(discount).to eq(32.95 / 2)
    end
  end

  context 'when there are 4 red widgets' do
    it 'applies discount to 2 pairs' do
      discount = offer.discount([item_r01, item_r01, item_r01, item_r01])
      expect(discount).to eq(2 * (32.95 / 2))
    end
  end
end
