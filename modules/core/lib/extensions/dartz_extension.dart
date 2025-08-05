import 'package:dartz/dartz.dart';

/// Extension for easily unfolding the monads.
extension DartzExtension<L, R> on Either<L, R> {
  /// The success monad.
  R right() => fold((l) => throw StateError(l.toString()), (r) => r);

  /// The failure monad.
  L left() => fold((l) => l, (r) => throw StateError(r.toString()));
}
