import 'package:currency/currency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splash_test/logic/cubits/cart_cubit.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CartEditor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: Theme.of(context).dividerColor),
          right: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              return Row(
                children: [
                  OutlinedButton(
                      child: Text("Undo"),
                      onPressed: state.undoable
                          ? () {
                              BlocProvider.of<CartCubit>(context).undo();
                            }
                          : null),
                  OutlinedButton(
                      child: Text("Redo"),
                      onPressed: state.redoable
                          ? () {
                              BlocProvider.of<CartCubit>(context).redo();
                            }
                          : null),
                  Expanded(child: SizedBox()),
                  OutlinedButton(
                      child: Text("Clear"),
                      onPressed: () {
                        BlocProvider.of<CartCubit>(context).clear();
                      }),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              );
            },
          ),
          Expanded(child: CartListView()),
          SizedBox(height: 10),
          CartTotalView(),
          SizedBox(height: 10),
          SizedBox(
            height: 50,
            child: ElevatedButton(
                child: Text(
                  "Complete Sale",
                ),
                onPressed: () {},
              ),
          ),
        ],
      ),
    );
  }
}

class CartListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScrollController _sc = ScrollController(initialScrollOffset: 1);

    return TextButtonTheme(
      data: TextButtonThemeData(
          style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.caption)),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).dividerColor)),
        clipBehavior: Clip.hardEdge,
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state.status == CartStatus.modifyFailure)
              return Text("Failed to modify");

            WidgetsBinding.instance?.addPostFrameCallback(
                (_) => {_sc.jumpTo(_sc.position.maxScrollExtent)});

            return ListView.builder(
                itemCount: state.items.length,
                controller: _sc,
                itemBuilder: (BuildContext context, int index) {
                  var thisItem = state.items[index];
                  return CartListItem(
                    index: index,
                    name: thisItem.itemName,
                    quantity: thisItem.quantity,
                    price: thisItem.itemPrice,
                    selected: index == state.selected,
                  );
                });
          },
        ),
      ),
    );
  }
}

class CartListItem extends StatelessWidget {
  final int index;
  final String name;
  final int quantity;
  final Currency price;
  final bool selected;

  CartListItem({
    required this.index,
    this.name = "",
    this.quantity = 0,
    this.price = const Currency(0),
    this.selected = false,
  });

  Widget _buildItemInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          fit: FlexFit.tight,
          child: Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.clip,
            softWrap: false,
          ),
        ),
        Text(quantity.toString().padLeft(4), overflow: TextOverflow.fade),
        Text(price.toString().padLeft(10), overflow: TextOverflow.fade),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    if (!selected) {
      content = _buildItemInfo();
    } else {
      content = Column(
        children: [
          _buildItemInfo(),
          SizedBox(height: 5),
          TextButtonTheme(
            data: TextButtonThemeData(
                style: TextButton.styleFrom(primary: Colors.grey.shade800)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // TODO - extract icon buttons into separate widget class
                SizedBox(
                  width: Theme.of(context).iconTheme.size! * 2,
                  child: Tooltip(
                    message: "Increase quantity",
                    waitDuration: Duration(seconds: 1),
                    child: TextButton(
                        child: Icon(Icons.add),
                        onPressed: () {
                          BlocProvider.of<CartCubit>(context)
                              .incrementSelected();
                        }),
                  ),
                ),
                SizedBox(
                  width: Theme.of(context).iconTheme.size! * 2,
                  child: Tooltip(
                    message: "Decrease quantity",
                    waitDuration: Duration(seconds: 1),
                    child: TextButton(
                        child: Icon(Icons.remove),
                        onPressed: () {
                          BlocProvider.of<CartCubit>(context)
                              .decrementSelected();
                        }),
                  ),
                ),
                SizedBox(
                  width: Theme.of(context).iconTheme.size! * 2,
                  child: Tooltip(
                    message: "Remove",
                    waitDuration: Duration(seconds: 1),
                    child: TextButton(
                        child: Icon(Icons.delete),
                        onPressed: () {
                          BlocProvider.of<CartCubit>(context).removeSelected();
                        }),
                  ),
                ),
              ],
            ),
          )
        ],
      );
    }

    return TextButton(
      style: TextButton.styleFrom(primary: Colors.black),
      child: Container(
        padding: const EdgeInsets.all(5),
        color: selected ? Theme.of(context).selectedRowColor : null,
        child: content,
      ),
      onPressed: () {
        BlocProvider.of<CartCubit>(context).selectItemAtIndex(index);
      },
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
        //TODO - Move logic to bloc
        Currency discount = Currency(0);
        Currency tax = subtotal * taxRate;
        Currency total = subtotal + tax;

        return DefaultTextStyle(
          style: Theme.of(context).textTheme.bodyText2 ?? TextStyle(),
          child: Column(children: [
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
                Text(
                  total.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ]),
        );
      },
    );
  }
}
