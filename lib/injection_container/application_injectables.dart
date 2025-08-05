// ignore_for_file: cascade_invocations

part of 'injection_container.dart';

/// Registers Blocs to the [serviceLocator].
///
/// All blocs must be injected via the [GetIt.registerFactory].
///
/// NOTE: Sort injectables alphabetically.
Future<void> injectionApplications(GetIt serviceLocator) async {
  // AAA

  // serviceLocator.registerFactory<AppInitializerCubit>(
  //   () => AppInitializerCubit(
  //     analyticsService: serviceLocator(),
  //     authUserService: serviceLocator(),
  //     authenticationService: serviceLocator(),
  //     cartService: serviceLocator(),
  //     checkoutService: serviceLocator(),
  //     feedbackService: serviceLocator(),
  //     guestUserService: serviceLocator(),
  //     orderService: serviceLocator(),
  //     storeService: serviceLocator(),
  //     voucherService: serviceLocator(),
  //     notificationService: serviceLocator(),
  //     remoteConfigService: serviceLocator(),
  //     stampCardService: serviceLocator(),
  //     dynamicLinkService: serviceLocator(),
  //     membershipService: serviceLocator(),
  //     sharedPreferencesService: serviceLocator(),
  //     personalizationService: serviceLocator(),
  //     rewardsService: serviceLocator(),
  //   ),
  // );

  // BBB

  // CCC

  // DDD

  // EEE

  // FFF

  // GGG
  // HHH
  // III

  // JJJ
  // KKK
  // LLL
  // MMM
  // NNN
  // OOO
  // PPP

  // QQQ
  // RRR

  // SSS

  // TTT

  serviceLocator.registerFactory<ThemeCubit>(ThemeCubit.new);

  // UUU

  // VVV

  // WWW

  serviceLocator.registerFactory<WatchDeeplinkCubit>(
    () => WatchDeeplinkCubit(utilsService: serviceLocator()),
  );

  // xxx
  // YYY
  // ZZZ
}
