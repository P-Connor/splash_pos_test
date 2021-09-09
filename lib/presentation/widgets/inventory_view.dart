import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splash_test/data/models/inventory.dart';
import 'package:splash_test/data/models/inventory_item.dart';
import 'package:splash_test/logic/cubits/cart_cubit.dart';
import 'package:splash_test/data/repositories/inventory_repository.dart';

class InventoryView extends StatelessWidget {
  final int crossAxisCount = 10;
  final int padding = 10;
  /*child: GridView.builder(
        primary: false,
        padding: const EdgeInsets.all(20),
        itemCount: .length;
        children: <Widget>[
          InventoryButton(displayName: "Burger", itemId: 1),
          InventoryButton(displayName: "Chicken Strips", itemId: 3),
          InventoryButton(displayName: "Fries", itemId: 2),
          InventoryButton(displayName: "Fountain Drink (24oz)", itemId: 6),
          InventoryButton(displayName: "ICEE (24oz)", itemId: 8),
          InventoryButton(displayName: "Skittles (4oz)", itemId: 5),
        ],
      ),*/

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Inventory>(
        builder: (BuildContext context, AsyncSnapshot<Inventory> snapshot) {
          if (snapshot.data != null) {
            // TODO - clean up null saftey?
            Inventory inventory = snapshot.data!;
            List<InventoryItem> items = inventory.items.toList();
            List<int> ids = inventory.ids.toList();
            return GridView.builder(
                padding: const EdgeInsets.all(20),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 150,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemCount: inventory.length,
                itemBuilder: (BuildContext context, index) {
                  InventoryItem item = items[index];
                  return InventoryButton(
                      displayName: item.displayName, itemId: ids[index]);
                });
          } else if (snapshot.hasError) {
            return Center(child: Icon(Icons.alarm));
          } else {
            return Center(
                child: SizedBox(
                    child: CircularProgressIndicator(),
                    width: 100,
                    height: 100));
          }
        },
        future: RepositoryProvider.of<InventoryRepository>(context)
            .activeInventory);
  }
}

class InventoryButton extends StatelessWidget {
  final String displayName;
  final double maxSize = 10;
  final int itemId;

  InventoryButton({required this.displayName, this.itemId = 0});

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      child: Container(
          child: TextButton(
            style: TextButton.styleFrom(primary: Colors.grey.shade700),
            child: Text(displayName, textAlign: TextAlign.center),
            onPressed: () {
              BlocProvider.of<CartCubit>(context).addItem(itemId);
            },
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.circular(8),
          )),
      maxWidth: maxSize,
      maxHeight: maxSize,
    );
  }
}
