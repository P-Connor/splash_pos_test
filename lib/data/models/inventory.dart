import 'dart:convert';
import 'package:currency/currency.dart';
import 'inventory_item.dart';

class Inventory {
  Map<int, InventoryItem> _items = {};
  int _nextId = 0;

  Inventory();
  Inventory.fromJSON(String json) {
    var read_items = jsonDecode(json);

    assert(read_items is List);
    Set<int> ids = {};

    for (Map item in read_items) {
      int? id = item['id'];

      assert(id != null);
      assert(item['name'] != null);
      assert(!ids.contains(id));

      if (id != null) {
        ids.add(id);

        _items[id] = InventoryItem(
          name: item['name'],
          displayName: item['displayName'] ?? item['name'],
          description: item['description'] ?? "",
          price: Currency(item['price'] ?? 0),
          nonTax: item['nonTax'] ?? false,
          archived: item['archived'] ?? false,
        );
      }
    }
  }

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
