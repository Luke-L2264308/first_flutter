import 'package:flutter_test/flutter_test.dart';
import 'package:first_flutter/models/cart.dart';
import 'package:first_flutter/models/sandwich.dart';

void main() {
  
  group('Cart', () {
    test('addItem adds new item and merges identical sandwiches', () {
      final cart = Cart();
      final s1 = Sandwich(
          type: SandwichType.tunaMelt,
          isFootlong: true,
          breadType: BreadType.white);
      cart.addItem(s1);
      expect(cart.items.length, 1);
      expect(cart.itemCount, 1);

      // add same sandwich again -> should increase quantity instead of adding new item
      cart.addItem(s1, quantity: 2);
      expect(cart.items.length, 1);
      expect(cart.itemCount, 3);
    });

    test('removeOne decreases quantity and removes when it reaches zero', () {
      final cart = Cart();
      final s = Sandwich(
          type: SandwichType.chickenTeriyaki,
          isFootlong: false,
          breadType: BreadType.wheat);
      cart.addItem(s, quantity: 2);
      expect(cart.itemCount, 2);

      cart.removeOne(s);
      expect(cart.itemCount, 1);

      cart.removeOne(s);
      expect(cart.itemCount, 0);
      expect(cart.items, isEmpty);
    });

    test('removeItem removes the item regardless of quantity', () {
      final cart = Cart();
      final s = Sandwich(
          type: SandwichType.meatballMarinara,
          isFootlong: true,
          breadType: BreadType.wholemeal);
      cart.addItem(s, quantity: 5);
      expect(cart.itemCount, 5);

      cart.removeItem(s);
      expect(cart.itemCount, 0);
      expect(cart.items, isEmpty);
    });

    test('updateQuantity sets quantity and removes when set to zero', () {
      final cart = Cart();
      final s = Sandwich(
          type: SandwichType.veggieDelight,
          isFootlong: false,
          breadType: BreadType.white);
      cart.updateQuantity(s, 4);
      expect(cart.itemCount, 4);

      cart.updateQuantity(s, 2);
      expect(cart.itemCount, 2);

      cart.updateQuantity(s, 0);
      expect(cart.itemCount, 0);
      expect(cart.items, isEmpty);
    });

    test(
        'calculateTotalPrice sums item totals using unit prices (footlong=11, six-inch=7)',
        () {
      final cart = Cart();
      final footlong = Sandwich(
          type: SandwichType.tunaMelt,
          isFootlong: true,
          breadType: BreadType.white);
      final sixInch = Sandwich(
          type: SandwichType.veggieDelight,
          isFootlong: false,
          breadType: BreadType.wheat);

      cart.addItem(footlong, quantity: 2); // expected 2 * 11 = 22
      cart.addItem(sixInch, quantity: 3); // expected 3 * 7 = 21

      final total = cart.calculateTotalPrice();
      expect(total, closeTo(43.0, 0.0001));
    });

    test('clear empties the cart', () {
      final cart = Cart();
      final s = Sandwich(
          type: SandwichType.tunaMelt,
          isFootlong: true,
          breadType: BreadType.white);
      cart.addItem(s, quantity: 2);
      expect(cart.isEmpty, isFalse);
      cart.clear();
      expect(cart.isEmpty, isTrue);
    });
  });
}
