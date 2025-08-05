import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:infrastructure/infrastructure.dart';

/// {@template DefaultExceptionConverter}
/// An exception converter that handles any exception by logging it as an unknown failure.
/// {@endtemplate}
class DefaultExceptionConverter<T>
    extends ExceptionConverter<T, Exception, Failure> {
  /// {@macro DefaultExceptionConverter}
  const DefaultExceptionConverter();

  @override
  Failure onException({
    required Logger logger,
    required MessageLog messageLog,
    required Exception exception,
    StackTrace? stackTrace,
  }) {
    logger.error(
      messageLog..message = 'Unknown failure occurred',
      error: exception,
      stackTrace: stackTrace,
    );

    return const Failure();
  }
}
