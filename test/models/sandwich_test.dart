import 'package:flutter_test/flutter_test.dart';
import 'package:first_flutter/models/sandwich.dart';

void main() {
  group('Sandwich model', () {
    
    test('name getter returns correct display string for each SandwichType',
        () {
      final mapping = {
        SandwichType.veggieDelight: 'Veggie Delight',
        SandwichType.chickenTeriyaki: 'Chicken Teriyaki',
        SandwichType.tunaMelt: 'Tuna Melt',
        SandwichType.meatballMarinara: 'Meatball Marinara',
      };

      for (final entry in mapping.entries) {
        final sandwich = Sandwich(
            type: entry.key, isFootlong: true, breadType: BreadType.white);
        expect(sandwich.name, equals(entry.value),
            reason: 'Name for ${entry.key} should match');
      }
    });

    test('image getter builds correct asset path for footlong and six-inch',
        () {
      final s1 = Sandwich(
          type: SandwichType.tunaMelt,
          isFootlong: true,
          breadType: BreadType.wheat);
      expect(s1.image, contains('tunaMelt'));
      expect(s1.image, contains('footlong'));
      expect(s1.image, startsWith('assets/images/'));

      final s2 = Sandwich(
          type: SandwichType.tunaMelt,
          isFootlong: false,
          breadType: BreadType.wheat);
      expect(s2.image, contains('tunaMelt'));
      expect(s2.image, contains('six_inch'));
    });

    test('image uses the enum name exactly (no enum prefix) and varies by type',
        () {
      final sVeg = Sandwich(
          type: SandwichType.veggieDelight,
          isFootlong: false,
          breadType: BreadType.white);
      final sMeat = Sandwich(
          type: SandwichType.meatballMarinara,
          isFootlong: false,
          breadType: BreadType.white);

      expect(sVeg.image, contains('veggieDelight'));
      expect(sMeat.image, contains('meatballMarinara'));
      expect(sVeg.image, isNot(equals(sMeat.image)));
    });
  });
}
