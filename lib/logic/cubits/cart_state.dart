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
  final int selected;
  final bool undoable, redoable;

  Currency get subtotal {
    Currency subtotal = Currency(0);
    for (CartItem item in items) {
      subtotal += item.itemPrice * item.quantity.toDouble();
    }
    return subtotal;
  }

  const CartState({
    this.items = const [],
    this.discountId = 0,
    this.status = CartStatus.initial,
    this.selected = -1,
    this.undoable = false,
    this.redoable = false,
  });

  @override
  List<Object?> get props =>
      [items, discountId, status, selected, undoable, redoable];

  CartState copyWith({
    CartStatus? status,
    List<CartItem>? items,
    int? discountId,
    int? selected,
    bool? undoable,
    bool? redoable,
  }) {
    return CartState(
      status: status ?? this.status,
      items: items ?? this.items,
      discountId: discountId ?? this.discountId,
      selected: selected ?? this.selected,
      undoable: undoable ?? this.undoable,
      redoable: redoable ?? this.redoable,
    );
  }

  /// Similar to copyWith, but with undoable = true and redoable = false
  CartState getNewWith({
    CartStatus? status,
    List<CartItem>? items,
    int? discountId,
    int? selected,
  }) {
    return copyWith(
      status: status,
      items: items,
      discountId: discountId,
      selected: selected,
      undoable: true,
      redoable: false,
    );
  }
}
