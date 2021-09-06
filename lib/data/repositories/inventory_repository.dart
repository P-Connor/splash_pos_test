import '../models/inventory.dart';

abstract class InventoryRepository {
  /// Returns the entire stored inventory, including both
  /// archived and unarchived items
  Future<Inventory> get allInventory;

  /// Returns an inventory with all stored unarchived items
  Future<Inventory> get activeInventory;

  /// Returns an inventory with all stored archived items
  Future<Inventory> get archivedInventory;
}
