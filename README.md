Separation / Encapsulation:- 
    Basket does not know how delivery or offers work — it delegates.
Small accurate interfaces:- 
    Each adapter has a single responsibility and a clean interface.
Dependency injection:- 
    Inject rules (offers, delivery, catalog) — don’t hardcode logic.
Strategy pattern / extensibility:- 
    Swap different strategies (e.g., new offer rules) easily.


Requirement: 
Ruby
Good separation / encapsulation of concerns
Small accurate interfaces / classes
Dependency injection
Strategy pattern / extensible code
Source control, conventional / meaningful commits and essential comments


A new product catalog from a remote API,

New delivery logic (e.g., free shipping for VIP customers),

More complex offers like “buy 3, get 1 free”...


In a large e-commerce app:

Products come from a database or API.

Offers change weekly and are stored in a CMS.

Delivery rules may depend on country, warehouse, or time of year.