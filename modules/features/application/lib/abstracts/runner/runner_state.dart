part of 'runner_cubit.dart';

/// {@template RunnerState}
/// A base abstract class representing the state of the runner cubit.
/// {@endtemplate}
abstract class RunnerState with EquatableMixin {
  /// {@macro RunnerState}
  const RunnerState();
}

/// {@template RunnerInitial}
/// Represents the initial state of the runner cubit.
/// {@endtemplate}
class RunnerInitial extends RunnerState {
  /// {@macro RunnerInitial}
  const RunnerInitial();

  @override
  List<Object?> get props => [];
}

/// {@template Running}
/// Emitted when the runner cubit is in the process of executing a task.
/// {@endtemplate}
class Running<Params> extends RunnerState {
  /// {@macro Running}
  const Running({required this.params});

  /// The parameters for the task being executed.
  final Params params;

  @override
  List<Object?> get props => [params];
}

/// {@template RunFailed}
/// Emitted when the execution of a task fails.
/// {@endtemplate}
class RunFailed<Params> extends RunnerState {
  /// {@macro RunFailed}
  const RunFailed({
    required this.params,
    required this.failure,
  });

  /// The failure that occurred during the execution of the task.
  final Failure failure;

  /// The parameters for the task that failed.
  final Params params;

  @override
  List<Object?> get props => [failure, params];
}

/// {@template RunSuccess}
/// Emitted when the execution of a task succeeds.
/// {@endtemplate}
class RunSuccess<ReturnType> extends RunnerState {
  /// {@macro RunSuccess}
  const RunSuccess({required this.runToken, required this.result});

  /// An identifier for the task execution.
  final int runToken;

  /// The result of the successful task execution.
  final ReturnType result;

  @override
  List<Object?> get props => [runToken, result];
}

/// {@template Reset}
/// Emitted when the runner cubit value has been reset to `null`.
/// {@endtemplate}
class Reset extends RunnerState {
  /// {@macro Reset}
  const Reset();

  @override
  List<Object?> get props => [];
}
