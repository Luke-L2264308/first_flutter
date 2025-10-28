import 'package:flutter/material.dart';

void main() {
  // runApp(const MyApp());
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    Container sandwichContainer = Container(
        margin: const EdgeInsets.all(10.0),
        width: 300.0,
        height: 100.0,
        color: Colors.red,
        alignment: Alignment.center,
        child: OrderItemDisplay(5, 'Footlong'));
    // List<Container> list = [];

    // for (int i = 0; i < 20; i++) {
    //   list.add(sandwichContainer);
    // }
    return MaterialApp(
        title: 'Sandwich Shop App',
        home: Scaffold(
            appBar: AppBar(title: const Text('Sandwich Counter')),
            // The bit that you need to update starts from here
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const OrderItemDisplay(5, 'Footlong'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => print('Add button pressed!'),
                        child: const Text('Add'),
                      ),
                      ElevatedButton(
                        onPressed: () => print('Remove button pressed!'),
                        child: const Text('Remove'),
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }
}

class OrderItemDisplay extends StatelessWidget {
  final String itemType;
  final int quantity;

  const OrderItemDisplay(this.quantity, this.itemType, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
        style: TextStyle(color: Colors.black, fontSize: 20),
        '$quantity $itemType sandwich(es): ${'🥪' * quantity}');
  }
}
