part of '../../app_router.dart';

/// {@template ProfileRoute}
/// A route that opens the [ProfileScreen].
/// {@endtemplate}
class ProfileRoute extends GoRouteData {
  /// {@macro ProfileRoute}
  const ProfileRoute();

  /// The name of the route.
  static const routeName = 'profile';

  /// The path of the route.
  static const routePath = '/profile';

  @override
  Page buildPage(BuildContext context, GoRouterState state) {
    final goRouterTransition = GoRouterTransition(
      context,
      state,
      routeName: ProfileRoute.routeName,
      child: const ProfileScreen(),
    );

    return goRouterTransition.buildPageWithShellTransition();
  }
}
