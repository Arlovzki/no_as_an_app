import 'package:flutter/material.dart';

/// A screen widget representing the home screen.
class HomeScreen extends StatefulWidget {
  /// Constructs a [HomeScreen] widget.
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

/// The state for the [HomeScreen] widget.
class _HomeScreenState extends State<HomeScreen> {
  /// The counter value.
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: _build(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _counter++;
          });
        },
        child: const Icon(Icons.plus_one),
      ),
    );
  }

  /// Builds the main content of the home screen.
  Widget _build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Home - Counter: $_counter',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Padding(padding: EdgeInsets.all(4)),
        ],
      ),
    );
  }
}
