import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../data/models/cart_item.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  int get subtotal {
    int subtotal = 0;
    for (CartItem item in state.items) {
      subtotal += item.price * item.quantity;
    }
    return subtotal;
  }

  void clear() {}
  void add(int itemId, int quantity) {}
}
