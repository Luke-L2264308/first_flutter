class OrderRepository {
  int _quantity = 0;
  final int maxQuantity;

  OrderRepository({required this.maxQuantity});

  int get quantity => _quantity;

  bool get canIncrement => _quantity < maxQuantity;
  bool get canDecrement => _quantity > 0;

  void increment() {
    if (canIncrement) {
      _quantity++;
    }
  }

  void decrement() {
    if (canDecrement) {
      _quantity--;
    }
  }
}

class PricingRepository {
  final bool isFootlong;
  final int quantity;

  PricingRepository({required this.isFootlong, required this.quantity});
  double get totalPrice {
    double unitPrice = isFootlong ? 11.0 : 7.0;
    return unitPrice * quantity;
  }
}
