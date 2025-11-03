import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

// The Sandwich class now tracks quantity
class Sandwich {
  String notes;
  int quantity;

  Sandwich({required this.notes, this.quantity = 1});
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Sandwich Shop App',
      home: OrderScreen(maxQuantity: 10), // Set max total sandwiches
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
  final _notesController = TextEditingController();

  // Manage a list of grouped Sandwich objects
  final List<Sandwich> _sandwiches = [];

  // Helper to calculate the total number of all sandwiches
  int get _totalSandwichCount {
    return _sandwiches.fold<int>(0, (sum, item) => sum + item.quantity);
  }

  // Adds a sandwich or increments the quantity if the notes match an existing item
  void _addSandwich() {
    if (_totalSandwichCount >= widget.maxQuantity) {
      _showMaxQuantityReached();
      return;
    }

    final notes = _notesController.text.isNotEmpty ? _notesController.text : 'No notes';

    setState(() {
      final index = _sandwiches.indexWhere((sandwich) => sandwich.notes == notes);

      if (index != -1) {
        // A sandwich with these notes already exists, so just increase its quantity.
        _sandwiches[index].quantity++;
      } else {
        // This is a new type of sandwich, add it to the list.
        _sandwiches.add(Sandwich(notes: notes, quantity: 1));
      }
    });

    _notesController.clear();
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Sandwich added to your order!')),
    );
  }

  // Increments the quantity of an item directly from the list
  void _incrementItem(String notes) {
    if (_totalSandwichCount >= widget.maxQuantity) {
      _showMaxQuantityReached();
      return;
    }
    setState(() {
      final index = _sandwiches.indexWhere((s) => s.notes == notes);
      if (index != -1) {
        _sandwiches[index].quantity++;
      }
    });
  }

  // Decrements the quantity of an item or removes it if the quantity is 1
  void _decrementItem(String notes) {
    setState(() {
      final index = _sandwiches.indexWhere((s) => s.notes == notes);
      if (index != -1) {
        if (_sandwiches[index].quantity > 1) {
          _sandwiches[index].quantity--;
        } else {
          // If quantity is 1, remove the item completely.
          _sandwiches.removeAt(index);
        }
      }
    });
  }

  void _showMaxQuantityReached() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
              'You have reached the maximum of ${widget.maxQuantity} sandwiches.')),
    );
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // The title now shows the total number of sandwiches
        title: Text('Your Order ($_totalSandwichCount)'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: _sandwiches.isEmpty
                ? const Center(child: Text('Add a sandwich to get started! 🥪'))
                : ListView.builder(
                    itemCount: _sandwiches.length,
                    itemBuilder: (context, index) {
                      final sandwich = _sandwiches[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                        child: ListTile(
                          leading: const Text('🥪', style: TextStyle(fontSize: 24)),
                          title: const Text('Footlong Sandwich'),
                          subtitle: Text('Notes: ${sandwich.notes}'),
                          // New controls to increment/decrement quantity
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove_circle_outline),
                                onPressed: () => _decrementItem(sandwich.notes),
                              ),
                              Text('${sandwich.quantity}', style: Theme.of(context).textTheme.titleMedium),
                              IconButton(
                                icon: const Icon(Icons.add_circle_outline),
                                onPressed: () => _incrementItem(sandwich.notes),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                TextField(
                  controller: _notesController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Add notes for your sandwich...',
                  ),
                  onSubmitted: (_) => _addSandwich(), // Allow submitting with enter key
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.add),
                    onPressed: _addSandwich,
                    label: const Text('Add Sandwich'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
