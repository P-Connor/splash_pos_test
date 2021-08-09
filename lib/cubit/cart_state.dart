part of 'cart_cubit.dart';

@immutable
abstract class CartState {
  final List<CartItem>? items;
  final int? discountId;

  CartState(this.items, this.discountId);
}

class CartInitial extends CartState {
  CartInitial() : super([], 0);
}
