import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:currency/currency.dart';
import 'package:equatable/equatable.dart';
import '../models/cart_item.dart';
import '../../data/repositories/inventory_repository.dart';
import '../../data/models/inventory_item.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(this._inventoryRepository) : super(CartState());

  final InventoryRepository _inventoryRepository;

  void addItem(int id, {int quantity = 1}) {
    InventoryItem? itemData = _inventoryRepository.inventory?.getItem(id);
    if (itemData == null) {
      emit(state.copyWith(status: CartStatus.modifyFailure));
      return;
    }

    List<CartItem> newItems = List<CartItem>.from(state.items)
      ..add(CartItem(
        itemData: itemData,
        quantity: quantity,
      ));

    emit(state.copyWith(items: newItems, status: CartStatus.modifySuccess));
  }
}
