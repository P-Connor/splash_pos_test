import 'inventory_item.dart';

class CartItem {
  final InventoryItem itemData;
  int quantity;
  List<CartItem> children = [];

  CartItem({
    required this.itemData,
    this.quantity = 1,
  });
}
