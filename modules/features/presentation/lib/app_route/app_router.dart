// ignore_for_file: sort_constructors_first

import 'dart:async';

import 'package:application/application.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/presentation.dart';

part 'app_router.g.dart';
part 'routes/shell_routes/shell_route.dart';
part 'routes/shell_routes/home_route.dart';
part 'routes/shell_routes/profile_route.dart';
part 'routes/login_route.dart';

/// {@template AppRouter}
/// A class responsible for managing the navigator keys used in the application.
/// {@endtemplate}
class AppRouter {
  /// {@macro AppRouter}
  AppRouter();

  /// GlobalKey for the root navigator.
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'RootNavigatorKey');

  /// GlobalKey for the shell navigator.
  static final GlobalKey<NavigatorState> shellNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'ShellNavigatorKey');
}

/// The instance of the main [RouterCubit].
final routerCubit = RouterCubit();

/// The router configuration for the application.
final router = GoRouter(
  navigatorKey: AppRouter.rootNavigatorKey,
  debugLogDiagnostics: kDebugMode,
  observers: [
    FlutterSmartDialog.observer,
    GoRouterObserver(),
  ],
  initialLocation: '/home',
  redirectLimit: 100,
  refreshListenable: GoRouterRefreshStream(routerCubit.stream),
  // errorBuilder: (context, state) =>
  //     const PageNotFoundErrorRoute().build(context, state),
  // redirect: (context, state) async {
  //   for (final redirectGuard in redirectGuards) {
  //     // ignore: use_build_context_synchronously
  //     if (await redirectGuard.shouldRedirect(context, state)) {
  //       if (context.mounted) {
  //         return redirectGuard.redirectLocation(context, state);
  //       }

  //       return null;
  //     }

  //     // ignore: use_build_context_synchronously
  //     if (!context.mounted) {
  //       return null;
  //     }
  //   }

  //   return state.uri.toString();
  // },
  routes: $appRoutes,
);

/// {@template GoRouterRefreshStream}
/// Converts a stream into a [ChangeNotifier] as required by Go Router to
/// reactively handle redirection based on the stream's current state.
///
/// See also:
/// - https://stackoverflow.com/a/71532680/4772301
/// {@endtemplate}
class GoRouterRefreshStream extends ChangeNotifier {
  /// {@macro GoRouterRefreshStream}
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

/// {@template GoRouterObserver}
/// A navigator observer that tracks route transitions for analytics purposes.
/// {@endtemplate}
class GoRouterObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route.settings.name != null) {
      /// Set the current screen in the analytics service
      // serviceLocator<AnalyticsService>().setCurrentScreen(
      //   screenName: route.settings.name ?? '',
      // );
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (newRoute?.settings.name != null) {
      /// Set the current screen in the analytics service
      // serviceLocator<AnalyticsService>().setCurrentScreen(
      //   screenName: newRoute?.settings.name ?? '',
      // );
    }
  }
}
