import 'package:flutter_test/flutter_test.dart';
import 'package:first_flutter/repositories/order_repository.dart';

void main() {
  group('OrderRepository', () {
    test('initial quantity should be 0', () {
      final repository = OrderRepository(maxQuantity: 5);
      expect(repository.quantity, 0);
    });

    test('increment should increase quantity by 1', () {
      final repository = OrderRepository(maxQuantity: 5);
      repository.increment();
      expect(repository.quantity, 1);
    });

    test('decrement should decrease quantity by 1', () {
      final repository = OrderRepository(maxQuantity: 5);
      repository.increment(); // quantity is now 1
      repository.decrement(); // quantity is now 0
      expect(repository.quantity, 0);
    });

    test('quantity should not exceed maxQuantity', () {
      final repository = OrderRepository(maxQuantity: 2);
      repository.increment(); // quantity is 1
      repository.increment(); // quantity is 2
      repository.increment(); // should not change
      expect(repository.quantity, 2);
    });

    test('quantity should not go below 0', () {
      final repository = OrderRepository(maxQuantity: 5);
      repository.decrement(); // should not change
      expect(repository.quantity, 0);
    });
  group('PricingRepository', () {
    test('returns 0.0 when quantity is zero (footlong)', () {
      final repo = PricingRepository(isFootlong: true, quantity: 0);
      expect(repo.totalPrice, equals(0.0));
    });

    test('calculates total price for footlong sandwiches', () {
      final repo = PricingRepository(isFootlong: true, quantity: 2);
      // footlong unit price = 11.0
      expect(repo.totalPrice, equals(22.0));
    });

    test('calculates total price for non-footlong (six-inch) sandwiches', () {
      final repo = PricingRepository(isFootlong: false, quantity: 3);
      // six-inch unit price = 7.0
      expect(repo.totalPrice, equals(21.0));
    });
  });

  });
}