import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

/// {@template GoRouterTransition}
/// For the app global navigation transition
/// {@endtemplate}
class GoRouterTransition {
  /// {@macro HomeRoute}
  GoRouterTransition(
    this.context,
    this.state, {
    required this.routeName,
    required this.child,
  });

  /// A handle to the location of a widget in the widget tree.
  final BuildContext context;

  /// The Go Router state.
  final GoRouterState state;

  /// The identifier for the current screen
  final String routeName;

  /// The widget for the current screen
  final Widget child;

  /// The transition for shell routes
  CustomTransitionPage buildPageWithShellTransition<T>() {
    return CustomTransitionPage<T>(
      name: routeName,
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 200),
      reverseTransitionDuration: const Duration(milliseconds: 200),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  /// The transition for global routes
  CupertinoPage buildPageWithCupertinoTransition<T>() {
    return CupertinoPage(
      name: routeName,
      key: state.pageKey,
      arguments: state.uri.queryParameters,
      child: child,
    );
  }
}
