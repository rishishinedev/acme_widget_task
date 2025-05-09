require_relative '../../lib/rules/tiered_delivery_rule'

RSpec.describe TieredDeliveryRule do
  subject(:rule) { described_class.new }

  describe '#delivery_cost' do
    it 'returns 0 when subtotal is 90 or more' do
      expect(rule.delivery_cost(90)).to eq(0)
      expect(rule.delivery_cost(100)).to eq(0)
    end

    it 'returns 2.95 when subtotal is between 50 and 89.99' do
      expect(rule.delivery_cost(50)).to eq(2.95)
      expect(rule.delivery_cost(89.99)).to eq(2.95)
    end

    it 'returns 4.95 when subtotal is less than 50' do
      expect(rule.delivery_cost(0)).to eq(4.95)
      expect(rule.delivery_cost(49.99)).to eq(4.95)
    end
  end
end
