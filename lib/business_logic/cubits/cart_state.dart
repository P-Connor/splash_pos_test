part of 'cart_cubit.dart';

@immutable
abstract class CartState {
  final List<CartItem> items;
  final int discountId;

  const CartState({this.items = const [], this.discountId = 0});
}

class CartInitial extends CartState {
  CartInitial() : super();
}
