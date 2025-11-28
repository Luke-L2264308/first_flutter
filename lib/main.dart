import 'package:flutter/material.dart';
import 'package:first_flutter/views/app_styles.dart';
import 'package:first_flutter/models/sandwich.dart';
import 'package:first_flutter/models/cart.dart';

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

class StylisedButton extends StatelessWidget {
  const StylisedButton({
    super.key,
    this.onPressed,
    this.text,
    this.icon,
    this.backgroundColor = Colors.red,
  });
  final VoidCallback? onPressed;
  final Widget? text;
  final Widget? icon;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: SizedBox(
        width: 20,
        height: 20,
        child: FittedBox(
          fit: BoxFit.contain,
          child: icon ?? const SizedBox.shrink(),
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
      ),
      label: text!,
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
  final Cart _cart = Cart();
  final TextEditingController _notesController = TextEditingController();

  SandwichType _selectedSandwichType = SandwichType.veggieDelight;
  bool _isFootlong = true;
  BreadType _selectedBreadType = BreadType.white;
  int _quantity = 1;
  String? _confirmationMessage;

  @override
  void initState() {
    super.initState();
    _notesController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _addToCart() {
    if (_quantity > 0) {
      final Sandwich sandwich = Sandwich(
        type: _selectedSandwichType,
        isFootlong: _isFootlong,
        breadType: _selectedBreadType,
      );
      String sizeText;
      if (_isFootlong) {
        sizeText = 'footlong';
      } else {
        sizeText = 'six-inch';
      }
      final String confirmationMessage =
          'Added $_quantity $sizeText ${sandwich.name} sandwich(es) on ${_selectedBreadType.name} bread to cart';

      setState(() {
        _cart.addItem(sandwich, quantity: _quantity);
        _confirmationMessage = confirmationMessage;
      });

      // Show a SnackBar so the user sees confirmation immediately
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(confirmationMessage)),
      );

      debugPrint(confirmationMessage);
    }
  }

  VoidCallback? _getAddToCartCallback() {
    if (_quantity > 0) {
      return _addToCart;
    }
    return null;
  }

  List<DropdownMenuEntry<SandwichType>> _buildSandwichTypeEntries() {
    List<DropdownMenuEntry<SandwichType>> entries = [];
    for (SandwichType type in SandwichType.values) {
      Sandwich sandwich =
          Sandwich(type: type, isFootlong: true, breadType: BreadType.white);
      DropdownMenuEntry<SandwichType> entry = DropdownMenuEntry<SandwichType>(
        value: type,
        label: sandwich.name,
      );
      entries.add(entry);
    }
    return entries;
  }

  List<DropdownMenuEntry<BreadType>> _buildBreadTypeEntries() {
    List<DropdownMenuEntry<BreadType>> entries = [];
    for (BreadType bread in BreadType.values) {
      DropdownMenuEntry<BreadType> entry = DropdownMenuEntry<BreadType>(
        value: bread,
        label: bread.name,
      );
      entries.add(entry);
    }
    return entries;
  }

  String _getCurrentImagePath() {
    final Sandwich sandwich = Sandwich(
      type: _selectedSandwichType,
      isFootlong: _isFootlong,
      breadType: _selectedBreadType,
    );
    return sandwich.image;
  }

  void _onSandwichTypeChanged(SandwichType? value) {
    if (value != null) {
      setState(() {
        _selectedSandwichType = value;
      });
    }
  }

  void _onSizeChanged(bool value) {
    setState(() {
      _isFootlong = value;
    });
  }

  void _onBreadTypeChanged(BreadType? value) {
    if (value != null) {
      setState(() {
        _selectedBreadType = value;
      });
    }
  }

  void _increaseQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decreaseQuantity() {
    if (_quantity > 0) {
      setState(() {
        _quantity--;
      });
    }
  }

  VoidCallback? _getDecreaseCallback() {
    if (_quantity > 0) {
      return _decreaseQuantity;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sandwich Counter',
          style: heading1,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 220,
                child: Image.asset(
                  _getCurrentImagePath(),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Text(
                        'Image not found',
                        style: normalText,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              DropdownMenu<SandwichType>(
                width: double.infinity,
                label: const Text('Sandwich Type'),
                textStyle: normalText,
                initialSelection: _selectedSandwichType,
                onSelected: _onSandwichTypeChanged,
                dropdownMenuEntries: _buildSandwichTypeEntries(),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Six-inch', style: normalText),
                  Switch(
                    value: _isFootlong,
                    onChanged: _onSizeChanged,
                  ),
                  const Text('Footlong', style: normalText),
                ],
              ),
              const SizedBox(height: 20),
              DropdownMenu<BreadType>(
                width: double.infinity,
                label: const Text('Bread Type'),
                textStyle: normalText,
                initialSelection: _selectedBreadType,
                onSelected: _onBreadTypeChanged,
                dropdownMenuEntries: _buildBreadTypeEntries(),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Quantity: ', style: normalText),
                  IconButton(
                    onPressed: _getDecreaseCallback(),
                    icon: const Icon(Icons.remove),
                  ),
                  Text('$_quantity'.toString(), style: heading1),
                  IconButton(
                    onPressed: _increaseQuantity,
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              StylisedButton(
                onPressed: _getAddToCartCallback(),
                icon: const Icon(Icons.add_shopping_cart),
                text: const Text('Add to Cart'),
                backgroundColor: Colors.green,
              ),
              const SizedBox(height: 12),
              if (_confirmationMessage != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    _confirmationMessage!,
                    style: normalText,
                  ),
                ),
              const SizedBox(height: 20),

              // Persistent cart summary
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  key: const Key('cart_summary'),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Items: ${_cart.itemCount}', style: normalText),
                      Text(
                          'Total: \$${_cart.calculateTotalPrice().toStringAsFixed(2)}',
                          style: heading1),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Persistent cart items list
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  key: const Key('cart_items_container'),
                  child: _cart.isEmpty
                      ? const Text('Cart is empty', style: normalText)
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: _cart.items.map((item) {
                            final sandwich = item.sandwich;
                            final sizeText =
                                sandwich.isFootlong ? 'footlong' : 'six-inch';
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 6.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                        '${item.quantity}x ${sandwich.name} (${sandwich.breadType.name}, $sizeText)',
                                        style: normalText),
                                  ),
                                  Text(
                                      '\$${item.totalPrice.toStringAsFixed(2)}',
                                      style: normalText),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
