import 'currency.dart';

class InventoryItem {
  String name, displayName, description;
  Currency price;
  bool nonTax;

  InventoryItem({
    required this.name,
    this.displayName = "",
    this.description = "",
    this.price = const Currency(0),
    this.nonTax = false,
  });

  @override
  String toString() {
    return displayName +
        " - Price: " +
        price.toString() +
        (nonTax ? " (NonTaxable)" : "");
  }
}
