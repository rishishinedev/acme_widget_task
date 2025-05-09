require_relative '../adapters/offer_adapter'

class RedWidgetHalfPriceOffer < OfferAdapter
  def discount(items)
    red_widgets = items.select { |item| item.code == "R01" }
    return 0 if red_widgets.empty?

    eligible_pairs = red_widgets.count / 2
    eligible_pairs * (red_widgets.first.price / 2.0)
  end
end
