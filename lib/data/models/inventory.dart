import 'dart:html';

import 'package:flutter/widgets.dart';

import 'inventory_item.dart';

class Inventory {
  Map<int, InventoryItem> _items = {};
  int _nextId = 0;

  int get length => _items.length;
  Iterable<int> get ids => _items.keys;
  Iterable<InventoryItem> get items => _items.values;
  Iterable<MapEntry<int, InventoryItem>> get entries => _items.entries;

  /// Returns the [InventoryItem] with [id] or null if not found
  InventoryItem? getItem(int id) => _items[id];

  /// Removes and returns the [InventoryItem] with [id] or null if not found
  InventoryItem? removeItem(int id) => _items.remove(id);

  /// Adds an item to the inventory and returns the auto-assigned ID
  int addItem(InventoryItem item) {
    _items[_nextId] = item;
    return _nextId++;
  }

  @override
  String toString() {
    return _items.toString();
  }
}
