import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

// A class to model our sandwich data
class Sandwich {
  final String id;
  final String notes;

  Sandwich({required this.id, required this.notes});
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Sandwich Shop App',
      home: OrderScreen(maxQuantity: 10), // Set max sandwiches
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

  // Manage a list of Sandwich objects instead of a single quantity
  final List<Sandwich> _sandwiches = [];

  void _addSandwich() {
    if (_sandwiches.length < widget.maxQuantity) {
      setState(() {
        // Create a new sandwich with a unique ID and the current notes
        final newSandwich = Sandwich(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          notes: _notesController.text.isNotEmpty ? _notesController.text : 'No notes',
        );
        _sandwiches.add(newSandwich);
      });
      // Clear the text field for the next sandwich
      _notesController.clear();

      // Show a confirmation message
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sandwich added to your order!')),
      );
    } else {
      // Show a message if the maximum quantity is reached
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'You have reached the maximum of ${widget.maxQuantity} sandwiches.')),
      );
    }
  }

  // Method to remove a specific sandwich by its ID
  void _removeSandwich(String id) {
    setState(() {
      _sandwiches.removeWhere((sandwich) => sandwich.id == id);
    });
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
        // The title now shows the number of sandwiches in the list
        title: Text('Your Order (${_sandwiches.length})'),
      ),
      body: Column(
        children: <Widget>[
          // Use an Expanded ListView to show the list of sandwiches
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
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _removeSandwich(sandwich.id),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          // Controls for adding a new sandwich
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
