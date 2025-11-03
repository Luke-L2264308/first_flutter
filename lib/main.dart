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

class OrderScreen extends StatefulWidget {
  final int maxQuantity;

  const OrderScreen({super.key, this.maxQuantity = 10});

  @override
  State<OrderScreen> createState() {
    return _OrderScreenState();
  }
}

class _OrderScreenState extends State<OrderScreen> {
  // 1. Create a TextEditingController to get the text from the TextField.
  final _notesController = TextEditingController();

  // 2. Create a variable to hold the saved text.
  String _savedSandwichContents = '';

  int _quantity = 0;

  void _increaseQuantity() {
    if (_quantity < widget.maxQuantity) {
      setState(() {
        _quantity++;
        // 3. When the "Add" button is pressed, save the text from the controller.
        _savedSandwichContents = _notesController.text;
      });

      // You can also show a quick message to confirm it was saved.
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Added sandwich. Notes saved: "$_savedSandwichContents"'),
        ),
      );
    }
  }

  void _decreaseQuantity() {
    if (_quantity > 0) {
      setState(() => _quantity--);
    }
  }

  // 4. Remember to dispose of the controller when it's no longer needed.
  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
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
            // Optional: Display the saved contents to see it working.
            if (_savedSandwichContents.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Current Notes: $_savedSandwichContents'),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _increaseQuantity, // This now also saves the notes
                  child: const Text('Add'),
                ),
                ElevatedButton(
                  onPressed: _decreaseQuantity,
                  child: const Text('Remove'),
                ),
              ],
            ),
            Padding( // 5. Remove 'const' from Padding
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                // 6. Assign the controller to the TextField.
                controller: _notesController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Order notes (e.g., no onions)',
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
        style: const TextStyle(color: Colors.black, fontSize: 20),
        '$quantity $itemType sandwich(es): ${'🥪' * quantity}');
  }
}
