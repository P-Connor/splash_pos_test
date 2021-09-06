import 'dart:io';
import '../repositories/inventory_repository.dart';
import '../models/inventory.dart';
import 'package:flutter/services.dart' show rootBundle;

class MockInventoryApiFailure implements Exception {}

class MockInventoryApi implements InventoryRepository {
  @override
  Future<Inventory> get allInventory async {
    String json =
        await rootBundle.loadString('assets/mock_data/all_inventory.json');
    if (json == "") throw MockInventoryApiFailure();
    return Inventory.fromJSON(json);
  }

  @override
  Future<Inventory> get activeInventory async {
    String json =
        await rootBundle.loadString('assets/mock_data/active_inventory.json');
    if (json == "") throw MockInventoryApiFailure();
    await Future.delayed(Duration(seconds: 3));
    return Inventory.fromJSON(json);
  }

  @override
  Future<Inventory> get archivedInventory async {
    String json =
        await rootBundle.loadString('assets/mock_data/archived_inventory.json');
    if (json == "") throw MockInventoryApiFailure();
    return Inventory.fromJSON(json);
  }
}
