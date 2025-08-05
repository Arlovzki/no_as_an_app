import 'package:domain/failures/base/failure.dart';

/// {@template NetworkFailure}
/// A [Failure] thrown when a network issue has been detected.
/// {@endtemplate}
class NetworkFailure extends Failure {
  /// Constructs a [NetworkFailure] with an optional [message].
  const NetworkFailure({
    super.message = 'There is limited or no internet connection',
  });
}
