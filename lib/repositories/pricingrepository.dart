class PricingRepository {
  final bool isFootlong;
  final int quantity;

  PricingRepository({required this.isFootlong, required this.quantity});
  double get totalPrice {
    double unitPrice = isFootlong ? 11.0 : 7.0;
    return unitPrice * quantity;
  }
}
