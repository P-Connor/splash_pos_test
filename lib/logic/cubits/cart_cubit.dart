import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart' hide Stack;
import 'package:meta/meta.dart';
import 'package:currency/currency.dart';
import 'package:equatable/equatable.dart';
import 'package:stack/stack.dart';
import 'package:splash_test/data/data_providers/mock_inventory_api.dart';
import 'package:splash_test/data/models/inventory_item.dart';
import '../models/cart_item.dart';
import '../../data/repositories/inventory_repository.dart';
import '../../data/models/inventory.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(this._inventoryRepository) : super(CartState());

  final InventoryRepository _inventoryRepository;
  // TODO - Make private later
  Inventory? loadedInventory;

  Stack<CartState> _undoStack = Stack<CartState>();
  Stack<CartState> _redoStack = Stack<CartState>();

  void addItem(int id, {int quantity = 1}) async {
    if (loadedInventory == null) {
      try {
        loadedInventory = await _inventoryRepository.activeInventory;
        assert(loadedInventory != null);
      } catch (MockInventoryApiFailure) {
        _saveState();
        emit(state.getNewWith(status: CartStatus.modifyFailure));
        return;
      }
    }
    _saveState();

    InventoryItem? itemData = loadedInventory?.getItem(id);
    if (itemData == null) {
      emit(state.getNewWith(status: CartStatus.modifyFailure));
      return;
    }

    List<CartItem> newItems = List<CartItem>.from(state.items)
      ..add(CartItem(
        itemId: id,
        itemName: itemData.displayName,
        itemPrice: itemData.price,
        quantity: quantity,
      ));

    emit(state.getNewWith(
      items: newItems,
      status: CartStatus.modifySuccess,
    ));
  }

  void selectItemAtIndex(int index) {
    if (index >= state.items.length) {
      emit(state.copyWith(status: CartStatus.modifyFailure));
    } else if (index == state.selected) {
      // If we try to select something that's already selected,
      // deselect it instead
      emit(state.copyWith(selected: -1));
    } else {
      emit(state.copyWith(selected: index));
    }
  }

  void removeSelected() {
    _saveState();
    if (state.selected < 0 || state.selected >= state.items.length) {
      emit(state.getNewWith(status: CartStatus.modifyFailure));
    }
    List<CartItem> newItems = List<CartItem>.from(state.items);
    newItems.removeAt(state.selected);
    emit(state.getNewWith(items: newItems, selected: -1));
  }

  void incrementSelected() {
    _saveState();
    if (state.selected < 0 || state.selected >= state.items.length) {
      emit(state.getNewWith(status: CartStatus.modifyFailure));
    }
    List<CartItem> newItems = List<CartItem>.from(state.items);
    CartItem oldItem = newItems.removeAt(state.selected);

    // Skip over 0 if at -1
    int newQuantity = (oldItem.quantity == -1) ? 1 : oldItem.quantity + 1;

    newItems.insert(state.selected, oldItem.copyWith(quantity: newQuantity));
    emit(state.getNewWith(items: newItems));
  }

  void decrementSelected() {
    _saveState();
    if (state.selected < 0 || state.selected >= state.items.length) {
      emit(state.getNewWith(status: CartStatus.modifyFailure));
    }
    List<CartItem> newItems = List<CartItem>.from(state.items);
    CartItem oldItem = newItems.removeAt(state.selected);

    // Skip over 0 if at 1
    int newQuantity = (oldItem.quantity == 1) ? -1 : oldItem.quantity - 1;

    newItems.insert(state.selected, oldItem.copyWith(quantity: newQuantity));
    emit(state.getNewWith(items: newItems));
  }

  void setQuantityOfSelected(int newQuantity) {
    _saveState();
    if (state.selected < 0 || state.selected >= state.items.length) {
      emit(state.getNewWith(status: CartStatus.modifyFailure));
      return;
    }
    List<CartItem> newItems = List<CartItem>.from(state.items);
    CartItem oldItem = newItems.removeAt(state.selected);
    newItems.insert(state.selected, oldItem.copyWith(quantity: newQuantity));
    emit(state.getNewWith(items: newItems));
  }

  void clear() {
    _saveState();
    emit(CartState(status: CartStatus.modifySuccess, undoable: true));
  }

  void undo() {
    if (_undoStack.size() == 0) {
      emit(state.getNewWith(status: CartStatus.modifyFailure));
      return;
    }
    _redoStack.push(state.copyWith(selected: -1));
    emit(_undoStack.pop());
  }

  void redo() {
    if (_redoStack.size() == 0) {
      emit(state.getNewWith(status: CartStatus.modifyFailure));
      return;
    }
    assert(state.redoable == true);
    _undoStack.push(state.copyWith(selected: -1));
    emit(_redoStack.pop());
  }

  // Pushes the current state onto the undo stack and clears the redo stack
  // Should be called any time a new state is about to override a current
  // state that we wish to save to the undo stack.
  void _saveState() {
    // All states in undo stack should be redoable and have no selection
    _undoStack.push(state.copyWith(redoable: true, selected: -1));
    if (_redoStack.size() != 0) {
      _redoStack = Stack();
    }
  }
}
