import 'package:flutter/material.dart';
import 'package:splash_test/presentation/widgets/cart_editor.dart';
import 'package:splash_test/presentation/widgets/inventory_view.dart';
import 'package:splash_test/presentation/widgets/status_bar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: InventoryView()),
                  StatusBar(),
                ],
              ),
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
