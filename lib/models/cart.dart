import 'package:first_flutter/repositories/pricingrepository.dart';
import 'package:first_flutter/models/sandwich.dart';

/// Simple shopping-cart implementation for Sandwich items.
///
/// - Add/remove/update items
/// - Calculate total price via `calculateTotalPrice()`

class CartItem {
  final Sandwich sandwich;
  int quantity;

  CartItem({
    required this.sandwich,
    this.quantity = 1,
  }) : assert(quantity >= 0);

  double get unitPrice =>
      PricingRepository(isFootlong: sandwich.isFootlong, quantity: 1)
          .totalPrice;

  double get totalPrice => unitPrice * quantity;

  // Two CartItems are considered the same product if their sandwich
  // configuration (type, size, bread) matches.
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CartItem &&
            other.sandwich.type == sandwich.type &&
            other.sandwich.isFootlong == sandwich.isFootlong &&
            other.sandwich.breadType == sandwich.breadType);
  }

  @override
  int get hashCode =>
      sandwich.type.hashCode ^
      sandwich.isFootlong.hashCode ^
      sandwich.breadType.hashCode;
}

class Cart {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  bool get isEmpty => _items.isEmpty;
  int get itemCount => _items.fold<int>(0, (p, e) => p + e.quantity);

  void addItem(Sandwich sandwich, {int quantity = 1}) {
    if (quantity <= 0) return;
    final existing = _items.indexWhere((it) =>
        it.sandwich.type == sandwich.type &&
        it.sandwich.isFootlong == sandwich.isFootlong &&
        it.sandwich.breadType == sandwich.breadType);
    if (existing >= 0) {
      _items[existing].quantity += quantity;
    } else {
      _items.add(CartItem(sandwich: sandwich, quantity: quantity));
    }
  }

  void removeOne(Sandwich sandwich) {
    final existing = _items.indexWhere((it) =>
        it.sandwich.type == sandwich.type &&
        it.sandwich.isFootlong == sandwich.isFootlong &&
        it.sandwich.breadType == sandwich.breadType);
    if (existing < 0) return;
    final item = _items[existing];
    if (item.quantity > 1) {
      item.quantity -= 1;
    } else {
      _items.removeAt(existing);
    }
  }

  void removeItem(Sandwich sandwich) {
    _items.removeWhere((it) =>
        it.sandwich.type == sandwich.type &&
        it.sandwich.isFootlong == sandwich.isFootlong &&
        it.sandwich.breadType == sandwich.breadType);
  }

  void updateQuantity(Sandwich sandwich, int quantity) {
    if (quantity <= 0) {
      removeItem(sandwich);
      return;
    }
    final existing = _items.indexWhere((it) =>
        it.sandwich.type == sandwich.type &&
        it.sandwich.isFootlong == sandwich.isFootlong &&
        it.sandwich.breadType == sandwich.breadType);
    if (existing >= 0) {
      _items[existing].quantity = quantity;
    } else {
      _items.add(CartItem(sandwich: sandwich, quantity: quantity));
    }
  }

  void clear() => _items.clear();

  double calculateTotalPrice() {
    return _items.fold<double>(0.0, (sum, item) => sum + item.totalPrice);
  }

  @override
  String toString() {
    if (_items.isEmpty) return 'Cart(empty)';
    final parts = _items.map((i) =>
        '${i.quantity}x ${i.sandwich.name} (${i.sandwich.breadType.name}, ${i.sandwich.isFootlong ? 'footlong' : 'six-inch'}) - \$${i.totalPrice.toStringAsFixed(2)}');
    return 'Cart(${parts.join('; ')}) Total: \$${calculateTotalPrice().toStringAsFixed(2)}';
  }
}
