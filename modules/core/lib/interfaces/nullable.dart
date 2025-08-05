/// {@template Nullable}
/// Typically used on `copyWith` methods to enable assignment of null values.
///
/// See: https://github.com/brianegan/flutter_redux/issues/40#issuecomment-384287305
/// {@endtemplate}
class Nullable<T> {
  /// {@macro Nullable}
  Nullable(this._value);

  final T _value;

  /// Return T value
  T get value => _value;
}
