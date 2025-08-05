import 'dart:math';

/// Extension for list
extension ListExtension<T> on List<T> {
  /// Return a random item in the list.
  T randomItem() {
    return this[Random().nextInt(length)];
  }
}
