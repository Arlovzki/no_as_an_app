import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:logging/logging.dart' as base_logger;
import 'package:no_as_an_app/injection_container/injection_container.dart'
    as sl;
import 'package:presentation/main_app.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // To preserve the splash screen while the app initializes.
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // NOTE: Put all first batch of splash screen initializers here

  await Future.wait([
    // Firebase.initializeApp(),
    sl.initialize(),
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]),
    // initializePackageInfo(),
    // initializeDeviceInfo(),
  ]);

  // NOTE: Put all second batch of splash screen initializers here

  // await Future.wait([
  //   _requestTrackingAuthorization(),
  //   serviceLocator<FirebaseAnalytics>().setAnalyticsCollectionEnabled(true),
  //   serviceLocator<GroceryListService>().initialize(),
  //   serviceLocator<NotificationService>().initialize(),
  // ]);

  // _initializeSegmentPlugin();
  _setupLogging();
  // _requestNotificationPermissions();

  // Place new code above

  runApp(Phoenix(child: const MainApp()));

  // Remove the splash screen
  FlutterNativeSplash.remove();

  // runZonedGuarded<Future<void>>(
  //   () async {
  //     FlutterError.onError =
  //         serviceLocator<FirebaseCrashlytics>().recordFlutterError;

  //     runApp(Phoenix(child: const MainApp()));
  //   },
  //   serviceLocator<FirebaseCrashlytics>().recordError,
  // );

  // Do not place new code below
}

/// Logger is a package from the Dart team.
/// While you can just simply use print()
/// to easily print to the debug console, using a fully-blown logger allows
/// you to easily set up multiple logging "levels" - e.g. INFO, WARNING, ERROR.
///
/// Chopper already uses the Logger package. Printing the logs to the console
/// requires the following setup.
void _setupLogging() {
  // Print long texts in the console
  void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => debugPrint(match.group(0)));
  }

  base_logger.Logger.root.onRecord.listen(
    (rec) => printWrapped('${rec.level.name}: ${rec.time}: ${rec.message}'),
  );
}

// /// Request tracking authorization on IOS devices. If already authorized or the
// /// device is Android, then enable advertiser tracking in [FacebookAppEvents].
// Future<void> _requestTrackingAuthorization() async {
//   final result = await AppTrackingTransparency.
// requestTrackingAuthorization();

//   if (result == TrackingStatus.authorized ||
//       result == TrackingStatus.notSupported) {
//     Future.wait(
//       [
//         serviceLocator<FacebookAppEvents>().setAutoLogAppEventsEnabled(true),
//         serviceLocator<FacebookAppEvents>()
//             .setAdvertiserTracking(enabled: true),
//       ],
//     );
//   }
// }

// /// Requests notification permissions on IOS.
// ///
// /// No need to await.
// void _requestNotificationPermissions() =>
//     serviceLocator<FirebaseMessaging>().requestPermission();

// void _initializeSegmentPlugin() {
//   late String writeKey;

//   if (Platform.isAndroid) {
//     writeKey = segmentAndroidWriteKey;
//   } else {
//     writeKey = segmentIOSWriteKey;
//   }

//   Segment.config(
//     options: SegmentConfig(
//       writeKey: writeKey,
//       trackApplicationLifecycleEvents: true,
//       // Change it to false when in PROD
//       debug: true,
//     ),
//   );
// }
