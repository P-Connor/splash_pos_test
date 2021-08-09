class CartItem {
  final int? itemId;
  int? quantity;
  List<CartItem> children = [];

  CartItem(this.itemId, this.quantity) {
    print("Created new CartObject with ID " +
        itemId.toString() +
        " and quantity " +
        quantity.toString());
  }
}
