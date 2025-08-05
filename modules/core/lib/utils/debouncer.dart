import 'dart:async';

/// A utility class for debouncing function calls.
///
/// Debouncing is a technique used to limit the rate at which a function is
/// called. When an event that triggers the function occurs repeatedly and
/// rapidly, the debouncer ensures that the function is only called once after
/// a specified delay since the last occurrence of the event.
class Debouncer {
  /// Creates a new [Debouncer] instance with the specified delay.
  ///
  /// The [delay] parameter determines the duration to wait before invoking
  /// the debounced function after the last event occurrence.
  Debouncer({this.delay = const Duration(milliseconds: 200)});

  /// The duration to wait before invoking the debounced function.
  final Duration delay;

  Timer? _timer;

  /// Invokes the debounced function with the provided [callback].
  ///
  /// This method cancels any pending invocation of the function and schedules
  /// a new invocation after the specified [delay].
  void call(void Function() callback) {
    _timer?.cancel();
    _timer = Timer(delay, callback);
  }

  /// Cancels any pending invocation of the debounced function.
  ///
  /// This method should be called when the debouncer is no longer needed to
  /// release any allocated resources and prevent potential memory leaks.
  void dispose() {
    _timer?.cancel();
    _timer = null;
  }
}
