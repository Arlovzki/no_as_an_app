part of '../app_router.dart';

/// {@template LoginRoute}
/// A route that opens the [LoginScreen].
/// {@endtemplate}
@TypedGoRoute<LoginRoute>(
  name: LoginRoute.routeName,
  path: LoginRoute.routePath,
)
class LoginRoute extends GoRouteData {
  /// {@macro LoginRoute}
  const LoginRoute();

  /// The name of the route.
  static const routeName = 'login';

  /// The path of the route.
  static const routePath = '/login';

  @override
  Page buildPage(BuildContext context, GoRouterState state) {
    final goRouterTransition = GoRouterTransition(
      context,
      state,
      routeName: LoginRoute.routeName,
      child: const LoginScreen(),
    );

    return goRouterTransition.buildPageWithShellTransition();
  }
}
