import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/domain.dart';

/// {@template ExceptionConverter}
/// An abstract class that converts exception [E] to failure [F] if exception
/// [E] occurs while running [call].
///
/// If no error occurs, then value [T] is returned.
/// {@endtemplate}
abstract class ExceptionConverter<T, E extends Exception, F extends Failure> {
  /// {@macro ExceptionConverter}
  const ExceptionConverter();

  /// Executes the provided [action] function and handles any occurring exceptions.
  ///
  /// If no error occurs during the execution of the [action] function, the result
  /// is returned as `Either<Failure, T>`. If an error occurs, the exception is
  /// converted to a failure using the [onException] method.
  ///
  /// The [action] function is expected to return a `Future<Either<Failure, T>>`.
  /// The [logger] and [messageLog] are required to handle logging and messaging
  /// related to the exception.
  Future<Either<Failure, T>> call({
    required Future<Either<Failure, T>> Function() action,
    required Logger logger,
    required MessageLog messageLog,
  }) async {
    try {
      return await action();
    } on E catch (exception, stackTrace) {
      return Left(
        onException(
          logger: logger,
          messageLog: messageLog,
          exception: exception,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  /// Handles the conversion of the exception [E] to a failure [F].
  ///
  /// This method is called when an exception occurs during the execution of the
  /// [call] method. It should handle any necessary logging or messaging related
  /// to the exception and return an instance of failure [F].
  F onException({
    required Logger logger,
    required MessageLog messageLog,
    required E exception,
    StackTrace? stackTrace,
  });
}
