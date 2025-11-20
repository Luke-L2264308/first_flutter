class OrderRepository {
  final int maxQuantity;
  int quantity;

  OrderRepository({this.maxQuantity = 10}) : quantity = 0;

  bool get canIncrement => quantity < maxQuantity;
  bool get canDecrement => quantity > 0;

  void increment() {
    if (canIncrement) quantity += 1;
  }

  void decrement() {
    if (canDecrement) quantity -= 1;
  }
}
