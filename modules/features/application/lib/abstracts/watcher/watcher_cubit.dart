import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'watcher_state.dart';

/// {@template WatcherCubit}
/// Runs a stream of [ReturnType].
///
/// To start the watcher, make a [watch].
///
/// If a [Failure] occurs while attempting to run the stream, then
/// [WatchFailed] is emitted.
/// {@endtemplate}
abstract class WatcherCubit<ReturnType> extends Cubit<WatcherState> {
  /// {@macro WatcherCubit}
  WatcherCubit() : super(WatcherInitial());

  /// The last result emitted by these method.
  ReturnType? _value;

  StreamSubscription<ReturnType>? _streamSubscription;

  /// Executes the asynchronous task and returns either a [Failure] or a [Stream<ReturnType>].
  ///
  /// This method should be implemented in subclasses to define the asynchronous task to be executed.
  Future<Either<Failure, Stream<ReturnType>>> onWatch();

  /// Returns the last emitted value.
  ReturnType? get value => _value;

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }

  /// Starts watching the stream.
  Future<void> watch() async {
    final result = await onWatch();

    if (isClosed) {
      return;
    }

    if (result.isLeft()) {
      emit(WatchFailed(failure: result.left()));
    }

    _streamSubscription = result.right().listen(
          (event) => emit(WatchValueChanged<ReturnType>(value: _value = event)),
        );
  }
}
