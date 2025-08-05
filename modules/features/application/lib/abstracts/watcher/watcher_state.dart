part of 'watcher_cubit.dart';

/// {@template WatcherState}
/// A base abstract class representing the state of the watcher cubit.
/// {@endtemplate}
abstract class WatcherState with EquatableMixin {
  /// {@macro WatcherState}
  const WatcherState();
}

/// {@template WatcherInitial}
/// Represents the initial state of the watcher cubit.
/// {@endtemplate}
class WatcherInitial extends WatcherState {
  @override
  List<Object?> get props => [];
}

/// {@template WatchFailed}
/// A state emitted when starting the stream fails.
/// {@endtemplate}
class WatchFailed extends WatcherState {
  /// {@macro WatchFailed}
  const WatchFailed({required this.failure});

  /// The failure that occurred while starting the stream.
  final Failure failure;

  @override
  List<Object?> get props => [failure];
}

/// {@template WatchValueChanged}
/// Emitted when a new value is returned by the stream.
/// {@endtemplate}
class WatchValueChanged<ReturnType> extends WatcherState {
  /// {@macro WatchValueChanged}
  const WatchValueChanged({required this.value});

  /// The new value returned by the stream.
  final ReturnType value;

  @override
  List<Object?> get props => [value];
}
