import 'package:flutter/material.dart';
import 'package:splash_test/presentation/widgets/cart_editor.dart';
import 'package:splash_test/presentation/widgets/inventory_view.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          children: [
            Expanded(
              child: InventoryView(),
            ),
            SizedBox(
              child: CartEditor(),
              width: 350,
            )
          ],
        ),
        color: Theme.of(context).backgroundColor,
      ),
    );
  }
}
