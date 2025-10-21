import 'package:flutter/material.dart';

// Here are the most commonly used Material widgets and a short explanation of what each does:

// MaterialApp — top-level app container: routing, theme, localization, home widget.
// Scaffold — basic visual layout structure: appBar, body, floatingActionButton, drawer, bottomBar.
// AppBar — toolbar at top of Scaffold (title, actions, leading).
// Center — centers a single child in its parent.
// Column / Row — vertical / horizontal layout of multiple children.
// Container — convenience widget for size, padding, margin, color, decoration.
// Padding — applies inner spacing around a child.
// SizedBox — fixed-size spacer or constrains a child’s size.
// Expanded / Flexible — lets a child grow (flex) inside Row/Column.
// Stack — overlap children; use Positioned for absolute placement.
// Align — positions a child within itself using alignment.
// Text — displays a string with styling.
// Icon / IconButton — shows an icon; IconButton is tappable.
// Image — displays images (asset, network, file, memory).
// ElevatedButton / TextButton / OutlinedButton — common button styles for actions.
// FloatingActionButton — circular primary action button, usually in Scaffold.floatingActionButton.
// TextField / TextFormField — single-line/multi-line text input and form support.
// ListView — scrollable linear list of children (builder for large lists).
// ListTile — common row layout for lists (leading, title, subtitle, trailing).
// Card — material-styled surface with elevation and rounded corners.
// SnackBar — transient message shown by ScaffoldMessenger.
// Dialog / AlertDialog — modal dialogs for confirmation/input.
// InkWell / GestureDetector — detect taps/gestures; InkWell adds ripple effect.
// BottomNavigationBar — bottom tab navigation control.
// TabBar / TabBarView — top tabs with swipable content.
void main() {
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sandwich Shop App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const MyHomePage(title: 'My Sandwich Shop'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Colors.amber,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: const Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Welcome to my shop!',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.brown,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
