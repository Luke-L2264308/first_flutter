import 'package:flutter/material.dart';

void main() {
  // runApp(const MyApp());
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Sandwich Shop App',
      home: OrderScreen(maxQuantity: 5),
    );
  }
}

class StylisedButton extends StatelessWidget{
  const StylisedButton({super.key, this.onPressed, this.child});
  final VoidCallback? onPressed;
  final Widget? child;
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      )
      ,child: child,
    );
  }
}

class OrderScreen extends StatefulWidget {
  final int maxQuantity;

  const OrderScreen({super.key, this.maxQuantity = 10});

  @override
  State<OrderScreen> createState() {
    return _OrderScreenState();
    
  }
}

class _OrderScreenState extends State<OrderScreen> {
  int _quantity = 0;
  void _increaseQuantity() {
    if (_quantity < widget.maxQuantity) { // Methods are typically private (_increaseQuantity, _decreaseQuantity) in Flutter to manage internal state.
      setState(() => _quantity++);
    }
  }

  void _decreaseQuantity() {
    if (_quantity > 0) { // To access them outside the class, you would need to make them public (remove the leading underscore).
      setState(() => _quantity--);
    } // However, a more idiomatic Flutter approach is to expose callbacks or use state management solutions for interaction between widgets.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sandwich Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OrderItemDisplay(
              _quantity,
              'Footlong',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StylisedButton(
                    onPressed: _quantity < widget.maxQuantity ? _increaseQuantity : null,
                    child: const Text('Add'),
                  ),
                ),
                StylisedButton(
                  onPressed: _quantity>0 ? _decreaseQuantity : null,
                  child: const Text('Remove'),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Order notes',
                ),
              ),
            )
          ],
        ),
      ),
    );
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
