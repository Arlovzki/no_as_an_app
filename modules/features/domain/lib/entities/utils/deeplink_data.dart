import 'package:equatable/equatable.dart';

/// This class is designed to represent the data associated with a deep link.
/// It uses [EquatableMixin] to simplify equality comparison, allowing you to
/// compare instances of this class based on their properties rather than by
/// reference. This is particularly useful when you want to ensure that two
/// instances of [DeeplinkData] are considered equal if they hold the same URI.
class DeeplinkData with EquatableMixin {
  /// Constructs an instance of [DeeplinkData].
  ///
  /// The constructor accepts a [Uri] object, which represents the deep link
  /// URI associated with this instance. The [uri] parameter can be `null`.
  const DeeplinkData(this.uri);

  /// The URI associated with the deep link.
  ///
  /// This URI typically represents the path or URL that the app should navigate
  /// to when a deep link is triggered. It can be `null` if no URI is provided.
  final Uri? uri;

  /// Overrides the equality comparison logic provided by [EquatableMixin].
  ///
  /// The [props] list contains the properties that should be used to determine
  /// whether two instances of [DeeplinkData] are equal. In this case, equality
  /// is determined by comparing the [uri] property.
  @override
  List<Object?> get props => [uri];
}
