import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/domain.dart';
import 'package:infrastructure/infrastructure.dart';

/// Converts the possible [Exception] thrown by [action] into a [Failure].
///
/// If no error occurs, then value [T] is returned.
///
/// If the [Exception] does not have an exception converter, then it will be
/// converted to [Failure] by default.
///
/// If [exceptionConverters] is `null`, then all [Exception] will be converted
/// to [Failure].
///
/// NOTE: [DefaultExceptionConverter] is added to the [exceptionConverters] by
/// default.
Future<Either<Failure, T>> convertExceptionIfThrown<T>({
  required Future<Either<Failure, T>> Function() action,
  required Logger logger,
  required MessageLog messageLog,
  List<ExceptionConverter<T, Exception, Failure>>? exceptionConverters,
}) async {
  try {
    if (exceptionConverters == null) {
      return await DefaultExceptionConverter<T>()(
        action: action,
        logger: logger,
        messageLog: messageLog,
      );
    }

    final extendedExceptionConverters = [
      ...exceptionConverters,
      DefaultExceptionConverter<T>(),
    ];

    return await extendedExceptionConverters
        .fold<Future<Either<Failure, T>> Function()>(
          action,
          (previousValue, element) =>
              () => element.call(
                action: previousValue,
                logger: logger,
                messageLog: messageLog,
              ),
        )();
  } catch (exception, stackTrace) {
    logger.error(
      messageLog..message = 'Exception thrown is a non-exception data type',
      error: exception,
      stackTrace: stackTrace,
    );

    return const Left(Failure());
  }
}
