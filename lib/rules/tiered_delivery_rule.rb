require_relative '../adapters/delivery_rule_adapter'

class TieredDeliveryRule < DeliveryRuleAdapter
  def delivery_cost(subtotal)
    return 0     if subtotal >= 90
    return 2.95  if subtotal >= 50
    4.95
  end
end
