import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../data/models/cart_item.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
}
