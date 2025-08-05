part of 'injection_container.dart';

/// Registers dependencies to the [serviceLocator].
///
/// All dependencies must be injected via the [GetIt.registerLazySingleton].
///
/// NOTE: Sort injectables alphabetically.
Future<void> injectDependencies(GetIt serviceLocator) async {
  // AAA
  serviceLocator
    ..registerLazySingleton<AppLinks>(AppLinks.new)
    // BBB
    // CCC
    // DDD
    // EEE
    // FFF
    // serviceLocator
    //     .registerLazySingleton<FacebookAppEvents>(() => FacebookAppEvents());
    // serviceLocator.registerLazySingleton<FirebaseAnalytics>(
    //   () => FirebaseAnalytics.instance,
    // );
    // serviceLocator.registerLazySingleton<FirebaseAnalyticsObserver>(
    //   () => FirebaseAnalyticsObserver(analytics: serviceLocator()),
    // );
    // serviceLocator.registerLazySingleton<FirebaseCrashlytics>(
    //   () => FirebaseCrashlytics.instance,
    // );
    // serviceLocator.registerLazySingleton<FirebaseDynamicLinks>(
    //   () => FirebaseDynamicLinks.instance,
    // );
    // serviceLocator.registerLazySingleton<FirebaseMessaging>(
    //   () => FirebaseMessaging.instance,
    // );
    // serviceLocator.registerLazySingleton<FlutterLocalNotificationsPlugin>(
    //   () => FlutterLocalNotificationsPlugin(),
    // );
    // GGG
    // HHH
    // III
    // serviceLocator.registerLazySingleton<InAppReview>(
    //   () => InAppReview.instance,
    // );
    // JJJ
    // KKK
    // LLL
    ..registerLazySingleton<LoadingManager>(LoadingManager.new)
    ..registerLazySingleton<LoadingDialogManager>(
      () => LoadingDialogManager(
        AppRouter.rootNavigatorKey,
        serviceLocator<LoadingManager>(),
      ),
    );
  // MMM
  // NNN
  // OOO
  // PPP
  // QQQ
  // RRR
  // serviceLocator.registerLazySingleton<FirebaseRemoteConfig>(
  //   () => FirebaseRemoteConfig.instance,
  // );
  // SSS
  // TTT
  // UUU
  // VVV
  // WWW
  // XXX
  // YYY
  // ZZZ
}
