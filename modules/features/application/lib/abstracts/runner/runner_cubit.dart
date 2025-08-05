import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'runner_state.dart';

/// A generic cubit for executing tasks that load asynchronously, then either
/// return a [Failure] or a specified [ReturnType].
///
/// If two [run] calls are running concurrently, the previous method
/// states are ignored in favor of the new method call states.
///
/// e.g.
/// @0:00: Paging event A started
/// @0:01: Paging state A emitted
/// @0:02: Paging event B started
/// @0:03: Paging state B emitted
/// @0:05: PageSuccess state B emitted
abstract class RunnerCubit<Params, ReturnType> extends Cubit<RunnerState> {
  /// Constructs a [RunnerCubit] instance with an initial state of [RunnerInitial].
  RunnerCubit() : super(const RunnerInitial());

  /// The last result emitted.
  ReturnType? _value;

  /// Executes the asynchronous task and returns either a [Failure] or a [ReturnType].
  ///
  /// This method should be implemented in subclasses to define the asynchronous task to be executed.
  Future<Either<Failure, ReturnType>> onRun({required Params params});

  /// Serves as an identifier for each [run] call.
  ///
  /// Every time [run] is called, this gets incremented.
  ///
  /// This prevents emitting a [RunFailed] or [RunSuccess] when a new method
  /// call is running in the process.
  int _runToken = 0;

  /// Returns the last emitted value.
  ReturnType? get value => _value;

  /// Executes the asynchronous task specified by [onRun].
  ///
  /// If the [RunnerCubit] is closed, this method returns without executing the task.
  ///
  /// The [params] parameter represents the parameters required for the task execution.
  Future<void> run({required Params params}) async {
    await ensureAsync();

    if (isClosed) {
      return;
    }

    final runToken = ++_runToken;

    emit(Running<Params>(params: params));

    final result = await onRun(params: params);

    /// If the run token has changed, then simply return
    if (runToken != _runToken) {
      return;
    }

    if (isClosed) {
      return;
    }

    emit(
      result.fold(
        (l) => RunFailed<Params>(params: params, failure: l),
        (r) => RunSuccess<ReturnType>(runToken: runToken, result: _value = r),
      ),
    );
  }

  /// Resets the [RunnerCubit]'s value to `null`.
  ///
  /// If the [RunnerCubit] is closed, this method returns without resetting the value.
  Future<void> reset() async {
    await ensureAsync();

    if (isClosed) {
      return;
    }

    ++_runToken;
    _value = null;

    emit(const Reset());
  }
}
