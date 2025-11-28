import 'package:first_flutter/models/sandwich.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:first_flutter/main.dart';

void main() {
  testWidgets('renders OrderScreen as home', (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();
    expect(find.byType(OrderScreen), findsOneWidget);
    expect(find.text('Sandwich Counter'), findsOneWidget);
  });

  testWidgets('increments and decrements quantity via buttons',
      (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    // initial quantity is 1
    expect(find.textContaining('1'), findsOneWidget);

    // tap the + icon to increase
    await tester.tap(find.widgetWithIcon(IconButton, Icons.add).first);
    await tester.pumpAndSettle();
    expect(find.textContaining('2'), findsOneWidget);

    // tap the - icon to decrease
    await tester.tap(find.byIcon(Icons.remove).first);
    await tester.pumpAndSettle();
    expect(find.textContaining('1'), findsOneWidget);

    // decrease to zero and ensure it doesn't go negative
    await tester.tap(find.byIcon(Icons.remove).first);
    await tester.pumpAndSettle();
    expect(find.textContaining('0'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.remove).first);
    await tester.pumpAndSettle();
    expect(find.textContaining('0'), findsOneWidget);
  });

  testWidgets('select sandwich type and bread type via dropdowns',
      (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    // Open sandwich type dropdown and select 'Tuna Melt'
    await tester.tap(find.text('Sandwich Type').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Tuna Melt').last);
    await tester.pumpAndSettle();
    expect(find.text('Tuna Melt'), findsWidgets);

    // Open bread type dropdown and select 'wheat'
    await tester.tap(find.text('Bread Type').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('wheat').last);
    await tester.pumpAndSettle();
    expect(find.textContaining('wheat'), findsWidgets);
  });

  testWidgets('Add to Cart button is enabled when quantity > 0',
      (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    // Initially quantity is 1 so Add to Cart should be enabled (has text)
    expect(find.widgetWithText(StylisedButton, 'Add to Cart'), findsOneWidget);
    // Tap Add to Cart (no visible result, but should not throw)
    await tester.tap(find.widgetWithText(StylisedButton, 'Add to Cart'));
    await tester.pumpAndSettle();
    // if no exception, test passes for button interaction
    expect(find.widgetWithText(StylisedButton, 'Add to Cart'), findsOneWidget);
  });

  testWidgets('shows confirmation message after Add to Cart',
      (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    // Tap Add to Cart
    final addToCart = find.widgetWithText(StylisedButton, 'Add to Cart');
    expect(addToCart, findsOneWidget);
    await tester.tap(addToCart);
    await tester.pumpAndSettle();

    // Expect the confirmation message to appear in the UI (match substrings)
    expect(find.textContaining('Added 1'), findsOneWidget);
    expect(find.textContaining('Veggie Delight'), findsOneWidget);
    expect(find.textContaining('to cart'), findsOneWidget);

    // Persistent cart summary and items should reflect the addition
    expect(find.byKey(const Key('cart_summary')), findsOneWidget);
    expect(find.text('Items: 1'), findsOneWidget);
    expect(find.byKey(const Key('cart_items_container')), findsOneWidget);
    expect(find.textContaining('1x Veggie Delight'), findsOneWidget);
  });
}
