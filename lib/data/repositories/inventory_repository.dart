import '../data_providers/inventory_api.dart';
import '../models/inventory.dart';
import '../models/inventory_item.dart';

class InventoryRepository {
  Inventory? _loadedInventory;
  final InventoryApiClient inventoryApiClient = InventoryApiClient();

  // TODO - Fix up
  InventoryRepository() {
    _loadedInventory = Inventory.fromJSON(inventoryApiClient.getAllActive());
  }

  Inventory? get inventory => _loadedInventory;
}
