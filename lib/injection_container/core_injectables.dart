part of 'injection_container.dart';

/// Registers core features to the [serviceLocator].
///
/// All core features must be injected via the [GetIt.registerLazySingleton].
///
/// NOTE: Sort injectables alphabetically.
Future<void> injectCore(GetIt serviceLocator) async {
  // AAA
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

  // serviceLocator.registerLazySingleton<Logger>(
  //   () => Logger(firebaseCrashlytics: serviceLocator()),
  // );

  serviceLocator.registerLazySingleton<Logger>(
    Logger.new,
  );

  // MMM
  // NNN
  // OOO
  // PPP
  // QQQ
  // RRR
  // SSS
  // TTT
  // UUU
  // VVV
  // WWW
  // XXX
  // YYY
  // ZZZ
}
