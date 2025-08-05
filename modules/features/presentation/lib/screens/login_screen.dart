import 'package:flutter/material.dart';
import 'package:presentation/presentation.dart';

/// A screen widget representing the login screen.
class LoginScreen extends StatefulWidget {
  /// Constructs a [LoginScreen] widget.
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

/// The state for the [LoginScreen] widget.
class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: RoundedElevatedButton(
          onPressed: () {
            // Navigate to the home screen when the button is pressed.
            // Uncomment the code below to navigate to the home screen.
            // const extra = ExampleObject(text: 'example');
            // const HomeRoute($extra: extra).push(context);
          },
          child: const Text('Go to home'),
        ),
      ),
    );
  }
}
