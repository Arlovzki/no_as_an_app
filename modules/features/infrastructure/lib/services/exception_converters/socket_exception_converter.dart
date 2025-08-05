import 'dart:io';

import 'package:core/core.dart';
import 'package:domain/failures/network/network_failure.dart';
import 'package:infrastructure/infrastructure.dart';

/// {@template SocketExceptionConverter}
/// An exception converter that handles [SocketException] by returning a [NetworkFailure].
/// {@endtemplate}
class SocketExceptionConverter<T>
    extends ExceptionConverter<T, SocketException, NetworkFailure> {
  /// {@macro SocketExceptionConverter}
  const SocketExceptionConverter();

  @override
  NetworkFailure onException({
    required Logger logger,
    required MessageLog messageLog,
    required SocketException exception,
    StackTrace? stackTrace,
    Map<String, dynamic>? data,
  }) {
    logger.warn(
      messageLog..message = 'Network failure occurred',
      error: exception,
      stackTrace: stackTrace,
    );

    return const NetworkFailure();
  }
}
