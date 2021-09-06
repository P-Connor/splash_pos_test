import 'package:meta/meta.dart';
import 'package:currency/currency.dart';
import '../../data/models/inventory_item.dart';

@immutable
class CartItem {
  final int itemId;
  final String itemName;
  final Currency itemPrice, itemDiscount;
  final int quantity;
  final List<CartItem> children;

  const CartItem({
    required this.itemId,
    required this.itemName,
    required this.itemPrice,
    this.itemDiscount = const Currency(0),
    this.quantity = 1,
    this.children = const [],
  });

  CartItem copyWith({
    int? itemId,
    String? itemName,
    Currency? itemPrice,
    Currency? itemDiscount,
    int? quantity,
    List<CartItem>? children,
  }) {
    return CartItem(
      itemId: itemId ?? this.itemId,
      itemName: itemName ?? this.itemName,
      itemPrice: itemPrice ?? this.itemPrice,
      itemDiscount: itemDiscount ?? this.itemDiscount,
      quantity: quantity ?? this.quantity,
      children: children ?? this.children,
    );
  }
}
