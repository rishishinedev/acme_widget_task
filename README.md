# 🧰 Acme Widget Co – Basket Pricing System

## Overview

This Ruby CLI project is a proof of concept for a sales system at **Acme Widget Co**. It implements a dynamic shopping basket with support for:

- A product catalog
- Tiered delivery rules
- Extensible promotional offers

It showcases clean design principles such as:

- Encapsulation
- Dependency Injection
- Strategy Pattern for offers and delivery rules
- Adapter Pattern for extensibility

---

## 🛍️ Business Requirements

### Products

| Product       | Code | Price  |
|---------------|------|--------|
| Red Widget    | R01  | $32.95 |
| Green Widget  | G01  | $24.95 |
| Blue Widget   | B01  | $7.95  |

### Delivery Charges

- Orders < $50 → $4.95  
- Orders < $90 → $2.95  
- Orders ≥ $90 → Free

### Offers

- **"Buy one Red Widget (R01), get the second half price"**

---

## ✅ Features Implemented

- `Basket` class that takes a catalog, delivery rule, and offers
- `add(code)` method to add products
- `total` method that returns the final price, after applying:
  - Discounts
  - Delivery rules
- Display of:
  - Selected products
  - Subtotal
  - Discount applied
  - Delivery charge
  - Final total

---

## 🏗️ Code Structure & Design

```
acme_widget_task/
├── bin/
│   └── run.rb                      # Entry point to run the basket system
├── config/
│   └── products.yml                # YAML config for product catalog
├── lib/
│   ├── basket.rb                   # Main Basket logic and BasketItem
│   ├── adapters/
│   │   ├── delivery_rule_adapter.rb
│   │   ├── offer_adapter.rb
│   │   └── product_catalog_adapter.rb
│   ├── catalog/
│   │   └── static_product_catalog.rb
│   ├── offers/
│   │   └── red_widget_half_price_offer.rb
│   └── rules/
│       └── tiered_delivery_rule.rb
```

---

## 🧠 Key Design Principles

| Principle             | Implementation Example                                          |
|-----------------------|-----------------------------------------------------------------|
| Encapsulation         | `Basket` class handles pricing logic internally                 |
| Dependency Injection  | `Basket` accepts catalog, delivery_rule, and offers as injected dependencies |
| Strategy Pattern      | Delivery and Offer behaviors can be swapped dynamically         |
| Open/Closed Principle | Easily add new offers or delivery rules without changing existing code |
| Single Responsibility | Each class has one job: pricing, product lookup, or rule evaluation |

---

## 🚀 Running the Project

```bash
ruby bin/run.rb
```

### Sample Output:

```
🛒 Selected Products:
- Red Widget (R01) - $32.95
- Green Widget (G01) - $24.95

Subtotal: $57.90
Discount: -$0.00
Delivery: $2.95
✅ Total: $60.85
```

---

## 📦 Adding New Features

**To add a new product:**
- Add it to `config/products.yml`

**To add a new offer:**
- Create a new class in `lib/offers/` that inherits from `OfferAdapter`
- Implement the `discount(items)` method

**To change delivery rules:**
- Create a new class in `lib/rules/` that inherits from `DeliveryRuleAdapter`
- Implement the `delivery_cost(subtotal)` method

---

## 🧪 Future Improvements

- Support promotion stacking / priority
- Add CLI interactivity
- Validate product codes gracefully
- Persist basket state (optional)
