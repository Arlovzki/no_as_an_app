import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// {@template ShellScreen}
/// This screen will serves as a "shell" for the app by building a Scaffold with a
/// BottomNavigationBar, where [navigator] is placed in the body of the Scaffold.
/// {@endtemplate}
class ShellScreen extends StatelessWidget {
  /// {@macro ShellScreen}
  const ShellScreen({
    required this.state,
    required this.navigator,
    required this.shellRoutes,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  /// The state of GoRouter
  final GoRouterState state;

  /// The current selected screen
  final StatefulNavigationShell navigator;

  /// List of the available shell routes
  final List<TypedStatefulShellBranch<StatefulShellBranchData>> shellRoutes;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: AnimatedScale(
          scale: 1,
          duration: const Duration(milliseconds: 100),
          child: navigator,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Profile'),
          ],
          currentIndex: navigator.currentIndex,
          onTap: (int index) => _onTap(context, index),
        ),
      ),
    );
  }

  /// Navigate to the current location of the branch at the provided index when
  /// tapping an item in the BottomNavigationBar.
  void _onTap(BuildContext context, int index) {
    // When navigating to a new branch, it's recommended to use the goBranch
    // method, as doing so makes sure the last navigation state of the
    // Navigator for the branch is restored.
    navigator.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigator.currentIndex,
    );
  }
}
