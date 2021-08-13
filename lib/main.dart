import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:currency/currency.dart';
import 'package:splash_test/data/data_providers/inventory_api.dart';
import 'package:splash_test/data/repositories/inventory_repository.dart';
import 'package:splash_test/logic/cubits/cart_cubit.dart';
import 'package:splash_test/logic/models/cart_item.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  // TODO - Fix this positioning later
  final InventoryRepository inventoryRepository = InventoryRepository();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'SplashPOS Test',
        theme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Color(0xff01497c),
            accentColor: Color(0xff61a5c2),
            backgroundColor: Color(0xff012a4a),
            fontFamily: 'Georgia',
            textTheme: TextTheme(
              headline1: GoogleFonts.roboto(
                  fontSize: 97,
                  fontWeight: FontWeight.w300,
                  letterSpacing: -1.5),
              headline2: GoogleFonts.roboto(
                  fontSize: 61,
                  fontWeight: FontWeight.w300,
                  letterSpacing: -0.5),
              headline3:
                  GoogleFonts.roboto(fontSize: 48, fontWeight: FontWeight.w400),
              headline4: GoogleFonts.roboto(
                  fontSize: 34,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.25),
              headline5:
                  GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.w400),
              headline6: GoogleFonts.roboto(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.15),
              subtitle1: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.15),
              subtitle2: GoogleFonts.roboto(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.1),
              bodyText1: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.5),
              bodyText2: GoogleFonts.roboto(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.25),
              button: GoogleFonts.roboto(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.25),
              caption: GoogleFonts.roboto(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.4),
              overline: GoogleFonts.roboto(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1.5),
            )),
        home: BlocProvider(
          create: (_) => CartCubit(inventoryRepository),
          child: HomePage(),
        ));
  }
}

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

class InventoryView extends StatelessWidget {
  final int crossAxisCount = 10;
  final int padding = 10;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 10,
      children: <Widget>[
        InventoryButton(displayName: "Burger", itemId: 1),
        InventoryButton(displayName: "Chicken Strips", itemId: 3),
        InventoryButton(displayName: "Fries", itemId: 2),
        InventoryButton(displayName: "Fountain Drink (24oz)", itemId: 6),
        InventoryButton(displayName: "ICEE (24oz)", itemId: 8),
        InventoryButton(displayName: "Skittles (4oz)", itemId: 5),
      ],
    );
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
          child: Text(displayName, textAlign: TextAlign.center),
          onPressed: () {
            BlocProvider.of<CartCubit>(context).addItem(itemId);
          },
        ),
        color: Theme.of(context).primaryColor,
      ),
      maxWidth: maxSize,
      maxHeight: maxSize,
    );
  }
}

class CartEditor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: CartView(),
          ),
          SizedBox(height: 10),
          CartTotalView(),
          SizedBox(height: 10),
          SizedBox(
            child: ElevatedButton(
              child: Text("Complete Sale",
                  style: Theme.of(context).textTheme.headline5),
              onPressed: () {},
            ),
            height: 50,
          ),
        ],
      ),
    );
  }
}

class CartView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state.status == CartStatus.modifyFailure)
            return Text("Failed to modify");

          return ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: state.items.length,
              itemBuilder: (BuildContext context, int index) {
                return CartItemBox(
                  name: state.items[index].itemData.displayName,
                  quantity: state.items[index].quantity,
                  price: state.items[index].itemData.price,
                );
              });
        },
      ),
    );
  }
}

class CartItemBox extends StatelessWidget {
  final String name;
  final int quantity;
  final Currency price;

  CartItemBox(
      {this.name = "", this.quantity = 0, this.price = const Currency(0)});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      child: Row(
        children: [
          Text(quantity.toString() + ": "),
          Text(name),
          Expanded(child: SizedBox()),
          Text(price.toString()),
        ],
      ),
    );
  }
}

class CartTotalView extends StatelessWidget {
  static const double taxRate = 0.075; //TODO - Pull tax

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        Currency subtotal = state.subtotal;
        Currency discount = Currency(0); //TODO - Pull discount
        Currency tax = subtotal * taxRate;
        Currency total = subtotal + tax;

        return Column(children: [
          Row(
            children: [
              Text("Subtotal:"),
              Expanded(child: SizedBox()),
              Text(subtotal.toString()),
            ],
          ),
          Row(
            children: [
              Text("Discounts:"),
              Expanded(child: SizedBox()),
              Text(discount.toString()),
            ],
          ),
          Row(
            children: [
              Text("Tax:"),
              Expanded(child: SizedBox()),
              Text(tax.toString()),
            ],
          ),
          Row(
            children: [
              Text("Total:"),
              Expanded(child: SizedBox()),
              Text(total.toString()),
            ],
          ),
        ]);
      },
    );
  }
}
