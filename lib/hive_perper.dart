import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ShopC {
  final shoppingBox = Hive.box('shopping_box');

  refreshItems() {
    final data = shoppingBox.keys.map((key) {
      final value = shoppingBox.get(key);
      return {
        "key": key,
        "id": value["id"],
        "name": value["name"],
        "quantity": value['quantity']
      };
    }).toList();
    return data.reversed.toList();
  }

// Create new item
  Future<void> createItem(Map<String, dynamic> newItem) async {
    await shoppingBox.add(newItem);
  }

// Retrieve a single item from the database by using its key
// Our app won't use this function but I put it here for your reference
  Map<String, dynamic> readItem(int key) {
    final item = shoppingBox.get(key);
    return item;
  }

// Update a single item
  Future<void> updateItem(int itemKey, Map<String, dynamic> item) async {
    await shoppingBox.put(itemKey, item);
    // refreshItems(); // Update the UI
  }

// Delete a single item
  Future<void> deleteItem(int itemKey) async {
    await shoppingBox.delete(itemKey);
    // refreshItems(); // update the UI

    // Display a snackbar
    // ScaffoldMessenger.of(context)
    //     .showSnackBar(const SnackBar(content: Text('An item has been deleted')));
  }
}
