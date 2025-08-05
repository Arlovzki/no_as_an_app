part of '../../app_router.dart';

/// {@template HomeRoute}
/// A route that opens the [HomeScreen].
/// {@endtemplate}
class HomeRoute extends GoRouteData {
  /// {@macro HomeRoute}
  const HomeRoute();

  /// The name of the route.
  static const routeName = 'home';

  /// The path of the route.
  static const routePath = '/home';

  @override
  Page buildPage(BuildContext context, GoRouterState state) {
    final goRouterTransition = GoRouterTransition(
      context,
      state,
      routeName: HomeRoute.routeName,
      child: const HomeScreen(),
    );

    return goRouterTransition.buildPageWithShellTransition();
  }
}
