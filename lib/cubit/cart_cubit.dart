import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../models/cart_item.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  int get subtotal {
    int ret = 0;

    return ret;
  }

  void clear() {}
  void add(int itemId, int quantity) {}
}
