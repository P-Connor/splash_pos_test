import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'SplashPOS Test',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocProvider(
          create: (_) => CounterCubit(),
          child: HomePage(),
        ));
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: Row(
        children: [
          Expanded(
            child: InventoryView(),
          ),
          SizedBox(
            child: CartEditor(),
            width: 200,
          )
        ],
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
        InventoryButton("Burger"),
        InventoryButton("Cheese Fries"),
        InventoryButton("Hot Dog"),
        InventoryButton("Fetus"),
        InventoryButton("One Toasty Chicken Strip"),
        InventoryButton("Drink"),
        InventoryButton("Candy"),
      ],
    );
  }
}

class InventoryButton extends StatelessWidget {
  final String displayName;
  final double maxSize = 10;

  InventoryButton(this.displayName);

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      child: Container(
        child: Center(child: Text(displayName, textAlign: TextAlign.center)),
        color: Colors.teal[100],
      ),
      maxWidth: maxSize,
      maxHeight: maxSize,
    );
  }
}

class CartEditor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CartView(),
        ),
        SizedBox(
          child: ElevatedButton(
            child: Text("Complete Sale"),
            onPressed: () {},
          ),
          height: 50,
        ),
      ],
    );
  }
}

class CartView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          child: const Text("Burger"),
          color: Colors.teal[100],
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: const Text("Cheese Fries"),
          color: Colors.teal[100],
        ),
      ],
    );
  }
}

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
}

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: BlocBuilder<CounterCubit, int>(
        builder: (context, count) => Center(child: Text('$count')),
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () => context.read<CounterCubit>().increment(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              child: const Icon(Icons.remove),
              onPressed: () => context.read<CounterCubit>().decrement(),
            ),
          ),
        ],
      ),
    );
  }
}
