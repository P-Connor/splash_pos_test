class InventoryApiClient {
  /// Returns the entire stored inventory as a JSON string
  String getAll() {
    // TODO - Implement
    throw UnimplementedError();
  }

  /// Returns all active inventory as a JSON string
  String getAllActive() {
    // TODO - Implement
    return tempInventory;
  }

  /// Returns all inactive inventory as a JSON string
  String getAllArchived() {
    // TODO - Implement
    throw UnimplementedError();
  }
}

const String tempInventory = '''
    [
      { 
        "id" : 1, 
        "name" : "hamburger", 
        "displayName" : "Burger",
        "description" : "Quarter pound hamburger with lettuce, tomato, and pickle", 
        "price" : 899,
        "nonTax" : false,
        "archived" : false
      },
      { 
        "id" : 2, 
        "name" : "fries", 
        "displayName" : "Fries",
        "description" : "Crispy fries with seasoning", 
        "price" : 299,
        "nonTax" : false,
        "archived" : false
      },
      { 
        "id" : 3, 
        "name" : "chicken_strip", 
        "displayName" : "Chicken Strips",
        "description" : "Three chicken strips in a basket", 
        "price" : 699,
        "nonTax" : false,
        "archived" : false
      },
      { 
        "id" : 5, 
        "name" : "skittles_4oz", 
        "displayName" : "Skittles (4oz)",
        "description" : "4oz bag of Skittles", 
        "price" : 199,
        "nonTax" : false,
        "archived" : false
      },
      { 
        "id" : 6, 
        "name" : "fountain_drink_24oz", 
        "displayName" : "Fountain Drink (24oz)",
        "description" : "24oz cup of any fountain drink", 
        "price" : 350,
        "nonTax" : false,
        "archived" : false
      },
      { 
        "id" : 8, 
        "name" : "icee_24oz", 
        "displayName" : "ICEE (24oz)",
        "description" : "24oz cup of any ICEE flavor", 
        "price" : 399,
        "nonTax" : false,
        "archived" : false
      }
    ]
  ''';
