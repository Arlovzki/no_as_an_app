// {@template RedirectGuard}
// ignore_for_file: unused_element

import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/presentation.dart';

// /// Indicates whether the app version has been checked.
// ///
// /// This is used to ensure that the app version is checked only at the start of
// /// the app.
// bool isAppVersionChecked = false;

/// The list of guards that are used to redirect the user to the correct
/// location.
///
/// The guards are executed in the order they are defined in this list.
List<RedirectGuard> get redirectGuards => [
      /// Ensure if the path is null, always redirect to [HomeRoute]
      RedirectGuard(
        shouldRedirect: (context, routeState) =>
            routeState.matchedLocation == '/',
        redirectLocation: (context, state) => const HomeRoute().location,
      ),

      // /// Redirect to no network page if there's a network error.
      // RedirectGuard(
      //   shouldRedirect: (context, routerState) =>
      //       context.read<RouterCubit>().state.hasNetworkError,
      //   redirectLocation: (context, routerState) =>
      //       const NoNetworkErrorRoute().location,
      // ),

      // /// Redirect to no something went wrong page if there's an unhandled error.
      // RedirectGuard(
      //   shouldRedirect: (context, routerState) =>
      //       context.read<RouterCubit>().state.hasUnhandledError,
      //   redirectLocation: (context, routerState) =>
      //       const SomethingWentWrongErrorRoute().location,
      // ),

      // /// Redirect to the loading page if initializing is `true`
      // RedirectGuard(
      //   shouldRedirect: (context, routerState) =>
      //       context.read<RouterCubit>().state.isInitializing,
      //   redirectLocation: (context, routerState) =>
      //       _redirectWithFrom(routerState, const LoadingRoute().location),
      // ),

      // /// Redirect to the sign up page if the user has incomplete profile
      // RedirectGuard(
      //   shouldRedirect: (context, routerState) =>
      //       context.read<RouterCubit>().state.isIncompleteProfile &&
      //       !context.read<RouterCubit>().state.isCompletingProfile &&
      //       routerState.matchedLocation !=
      //           const AllowPermissionRoute(
      //             permissionType: PermissionType.gallery,
      //           ).location,
      //   redirectLocation: (context, routerState) => _redirectWithFrom(
      //     routerState,
      //     const SignUpInfoFormRoute().location,
      //   ),
      // ),

      // /// Redirect to the verify top page if the user has unverified profile
      // RedirectGuard(
      //   shouldRedirect: (context, routerState) =>
      //       context.read<RouterCubit>().state.isAccountUnverified &&
      //       context.read<RouterCubit>().state.isLoggedIn,
      //   redirectLocation: (context, routerState) => _redirectWithFrom(
      //     routerState,
      //     const VerifyAccountOtpRoute().location,
      //   ),
      // ),

      // // Redirect to the auth page if the user is not logged in
      // RedirectGuard(
      //   shouldRedirect: (context, routerState) =>
      //       !context.read<RouterCubit>().state.isLoggedIn &&
      //       !context.read<RouterCubit>().state.isRegistering &&
      //       !context.read<RouterCubit>().state.isLoggingIn,
      //   redirectLocation: (context, routerState) =>
      //       _redirectWithFrom(routerState, const AuthRoute().location),
      // ),

      // // The user should not be in the auth page or signup set password page unless
      // // dictated by the router cubit properties. They should contain a `from`
      // // parameter. If not, then redirect to the home page.
      // RedirectGuard(
      //   shouldRedirect: (context, routerState) =>
      //       routerState.matchedLocation == const AuthRoute().location ||
      //       routerState.matchedLocation == const LoadingRoute().location ||
      //       routerState.matchedLocation ==
      //           const VerifyAccountOtpRoute().location ||
      //       (routerState.matchedLocation ==
      //               const SignUpInfoFormRoute().location &&
      //           !context.read<RouterCubit>().state.isRegistering),
      //   redirectLocation: (context, routerState) => _fromOrDefaultLocation(
      //     routerState: routerState,
      //     fromLocationBlocklist: {const ProfileRoute().location},
      //     defaultLocation: const HomeRoute().location,
      //   ),
      // ),
    ];

/// {@template RedirectGuard}
/// A guard that redirects the user to a different location if a condition is
/// met.
/// {@endtemplate}
class RedirectGuard {
  /// {@macro RedirectGuard}
  const RedirectGuard({
    required this.shouldRedirect,
    required this.redirectLocation,
  });

  /// The condition that determines whether the user should be redirected.
  final FutureOr<bool> Function(BuildContext, GoRouterState) shouldRedirect;

  /// The location that the user should be redirected to.
  final String Function(BuildContext, GoRouterState) redirectLocation;
}

/// Creates a redirect URL path with the `from` parameter so that when the
/// redirect URL has been completed, the user can be forwarded to the `from`
/// location.
///
/// If a `from` parameter exists in [state] uri query params, then it will be used.
/// Otherwise, the current location will be used.
///
/// If the `from` parameter is the same as the [redirect] location, then the
/// `from` parameter will not be added.
///
/// e.g.
/// - Returns `/auth?from=/home` if the current location is `/home` obtained
///   from [state] and the [redirect] location is `/auth`
/// - Returns `/auth?from=/home` if the `from` parameter exists and its value
///   set to home `/home` in the query parameters and the [redirect] location
///   is `/auth`
///
///  if ginamit siya while meron ng laman si from, gagamiting niya yung oldest.
///  For example:
///  page a redirects to page b (b?from=a)
///  page b redirects to page c (c?from=a, not c?from=b)

String _redirectWithFrom(GoRouterState state, String redirect) {
  late final String from;

  final existingFromParams = state.uri.queryParameters['from'];

  if (existingFromParams != null) {
    from = redirect == existingFromParams ? '' : existingFromParams;
  } else {
    from = redirect == state.matchedLocation ? '' : state.matchedLocation;
  }

  return '$redirect${from.isNotEmpty ? '?from=$from' : ''}';
}

/// Returns the `from` location from [routerState] uri query params if it exists.
/// Otherwise, the [defaultLocation] will be returned.
///
///
/// For example, `/auth?from=/home` will return `/home`.
///
/// The [defaultLocation] will be returned instead if any of the conditions
/// below are met:
/// - The `from` location is `null`.
/// - The `from` location is the same as the [routerState] matchedLocation.
/// - The `from` location is in the [fromLocationBlocklist].
///
/// Note: The `from` location cannot be the same as the [defaultLocation].
String _fromOrDefaultLocation({
  required GoRouterState routerState,
  required String defaultLocation,
  Set<String>? fromLocationBlocklist,
}) {
  assert(
    routerState.matchedLocation != defaultLocation,
    'The `from` location cannot be the same as the default location.',
  );

  final from = routerState.uri.queryParameters['from'];

  if (from != null &&
      from != routerState.matchedLocation &&
      !(fromLocationBlocklist?.contains(from) ?? false)) {
    return from;
  }

  return defaultLocation;
}
