part of 'cart_cubit.dart';

enum CartStatus {
  initial,
  modifySuccess,
  modifyFailure,
}

@immutable
class CartState extends Equatable {
  final List<CartItem> items;
  final int discountId;
  final CartStatus status;

  Currency get subtotal {
    Currency subtotal = Currency(0);
    for (CartItem item in items) {
      subtotal += item.itemData.price * item.quantity.toDouble();
    }
    return subtotal;
  }

  const CartState({
    this.items = const [],
    this.discountId = 0,
    this.status = CartStatus.initial,
  });

  @override
  List<Object?> get props => [items, discountId, status];

  CartState copyWith({
    CartStatus? status,
    List<CartItem>? items,
    int? discountId,
  }) {
    return CartState(
      status: status ?? this.status,
      items: items ?? this.items,
      discountId: discountId ?? this.discountId,
    );
  }
}
