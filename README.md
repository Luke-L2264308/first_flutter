# Sandwich Shop App

A small Flutter demo app for ordering sandwiches. The app demonstrates common Flutter concepts: stateful widgets, forms, dropdowns, custom buttons, text input, basic repository logic, and widget tests.

Built with:
- Flutter (see SDK constraints in `pubspec.yaml`)
- Dart
- `flutter_lints` for linting

## Features
- Order screen with quantity controls (increment / decrement)
- Sandwich type toggle (footlong / other)
- Bread type selection (enum-backed dropdown)
- Order notes (text input)
- Reusable stylised button widget
- Order item display widget (used by tests)
- Widget tests covering UI text and behavior

## Project structure (important files)
- `lib/main.dart` — main app, `OrderScreen`, `OrderItemDisplay`, `StylisedButton`
- `lib/repositories/order_repository.dart` — order quantity business logic
- `lib/views/app_styles.dart` — UI styling utilities
- `test/views/widget_test.dart` — widget tests for display and controls
- `pubspec.yaml` — assets, dependencies (`flutter_lints`)
- `pubspec.lock` — resolved dependency versions
- `assets/images/` — image assets referenced by the app

## Quickstart (Windows)
1. Ensure Flutter is installed and on PATH. Recommended: Flutter 3.18+ and matching Dart SDK.
2. Open a terminal and run:
   ```
   cd d:\flutter\first_flutter
   flutter pub get
   ```
3. Run the app on an emulator or device:
   ```
   flutter run
   ```
4. Run the analyzer:
   ```
   flutter analyze
   ```
5. Run tests:
   ```
   flutter test
   ```

## Running and debugging in VS Code
- Open the project folder in VS Code.
- Install the Dart & Flutter extensions.
- Press F5 to run in debug mode.
- Use the Flutter Inspector / DevTools for widget tree inspection.
  - From VS Code: Ctrl+Shift+P → "Flutter: Open DevTools" → choose Inspector → open the "Layout Explorer" tab.
  - Layout Explorer requires the app to be running in debug/profile mode.

## Tests
- Widget tests live under `test/`.
- Example:
  ```
  flutter test test/views/widget_test.dart
  ```
- Tests expect specific text strings from `OrderItemDisplay`. String matching is exact — adjust either the widget or tests if you change the text formatting.

## Linting & Formatting
- Lints: `flutter_lints` is listed in `pubspec.yaml`. Consider adding `analysis_options.yaml` with:
  ```yaml
  include: package:flutter_lints/flutter.yaml
  ```
- Format on save:
  - Enable in VS Code: Ctrl+, → search "Format On Save" → enable.
  - Workspace setting example (`.vscode/settings.json`):
    ```json
    {
      "editor.formatOnSave": true,
      "editor.defaultFormatter": "dart-code.dart-code"
    }
    ```

## Notes & tips
- `StatefulWidget` vs `State`: the widget is immutable configuration; the `State` object holds mutable state and lifecycle methods (initState, dispose, setState).
- If tests fail due to exact-text mismatch, either make the widget produce the expected exact strings or relax tests using `find.textContaining` or RegExp.
- If the analyzer shows blue/gray hints (info), hover the code or press `Ctrl+.` in VS Code to see Quick Fix suggestions.

## Contributing
- Bug reports and improvements are welcome. Keep changes focused and add/update tests where applicable.

## License
MIT License — see `LICENSE` (if you add one).
