part of 'injection_container.dart';

/// Registers services to the [serviceLocator].
///
/// All services must be injected via the [GetIt.registerLazySingleton].
///
/// NOTE: Sort injectables alphabetically.
Future<void> injectInfrastructure(GetIt serviceLocator) async {
  // AAA

  // serviceLocator.registerLazySingleton<AnalyticsService>(
  //   () => AnalyticsServiceImpl(
  //     facebookAppEvents: serviceLocator(),
  //     firebaseAnalytics: serviceLocator(),
  //     logger: serviceLocator(),
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
  // UUU
  serviceLocator.registerLazySingleton<UtilsService>(
    () => UtilsServiceImpl(
      logger: serviceLocator(),
    ),
  );

  // VVV

  // WWW
  // XXX
  // YYY
  // ZZZ
}
