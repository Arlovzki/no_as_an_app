// ignore_for_file: unnecessary_overrides

import 'package:codenic_logger/codenic_logger.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';

export 'package:codenic_logger/codenic_logger.dart';

/// {@template Logger}
/// A class for logging.
/// {@endtemplate}
class Logger extends CodenicLogger {
  /// {@macro Logger}
  Logger();

  @override
  set userId(String? userId) {
    super.userId = userId;
    // _firebaseCrashlytics.setUserIdentifier(userId ?? '');
  }

  @override
  void error(
    MessageLog messageLog, {
    dynamic error,
    StackTrace? stackTrace,
  }) {
    super.error(messageLog, error: error, stackTrace: stackTrace);

    // _firebaseCrashlytics.recordError(
    //   error,
    //   stackTrace,
    //   reason: messageLog,
    // );
  }
}
