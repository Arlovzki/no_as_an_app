part of '../../app_router.dart';

/// {@template ShellRoute}
/// A route that opens the [ShellScreen].
/// {@endtemplate}
@TypedStatefulShellRoute<ShellRoute>(branches: shellBranches)
class ShellRoute extends StatefulShellRouteData {
  /// {@macro ShellRoute}
  const ShellRoute();

  /// The navigator key that is needed to navigate through the shell screen.
  static final GlobalKey<NavigatorState> $navigatorKey =
      AppRouter.shellNavigatorKey;

  /// The restoration scope ID for the shell route.
  static const String $restorationScopeId = 'ShellRoute';

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return ShellScreen(
      state: state,
      navigator: navigationShell,
      shellRoutes: shellBranches,
    );
  }
}

/// {@template BranchHomeData}
/// Data for the Home branch in the shell navigation.
/// {@endtemplate}
class BranchHomeData extends StatefulShellBranchData {
  /// {@macro BranchHomeData}
  const BranchHomeData();

  /// The restoration scope ID for the home branch.
  static const String $restorationScopeId = 'BranchHomeData';
}

/// {@template BranchProfileData}
/// Data for the Profile branch in the shell navigation.
/// {@endtemplate}
class BranchProfileData extends StatefulShellBranchData {
  /// {@macro BranchProfileData}
  const BranchProfileData();

  /// The restoration scope ID for the profile branch.
  static const String $restorationScopeId = 'BranchProfileData';
}

/// Shell branches for the [ShellRoute].
const List<TypedStatefulShellBranch<StatefulShellBranchData>> shellBranches = [
  TypedStatefulShellBranch<BranchHomeData>(
    routes: <TypedRoute<RouteData>>[
      TypedGoRoute<HomeRoute>(
        path: HomeRoute.routePath,
        name: HomeRoute.routeName,
      ),
    ],
  ),
  TypedStatefulShellBranch<BranchProfileData>(
    routes: <TypedRoute<RouteData>>[
      TypedGoRoute<ProfileRoute>(
        path: ProfileRoute.routePath,
        name: ProfileRoute.routeName,
      ),
    ],
  ),
];
