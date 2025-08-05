import 'package:equatable/equatable.dart';

/// An enumeration representing the relationship between the total
/// page items count and a specific value.
enum TotalPageItemRelation {
  /// Indicates that the total page items count is equal to a specific value.
  equal,

  /// Indicates that the total page items count is more than a specific value.
  moreThan,
}

/// A class representing the total page items count and its relation.
class TotalPageItems with EquatableMixin {
  /// Constructs a [TotalPageItems] object with the
  /// given [count] and [relation].
  const TotalPageItems({required this.count, required this.relation});

  /// The total count of page items.
  final int count;

  /// The relationship between the total page items count and a specific value.
  final TotalPageItemRelation relation;

  @override
  List<Object?> get props => [count, relation];
}
