class CartItem {
  final int itemId;
  int quantity;
  int price;
  List<CartItem> children = [];

  CartItem({
    required this.itemId,
    this.quantity = 1,
    this.price = 0,
  });
}
