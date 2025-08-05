import 'package:equatable/equatable.dart';

/// A class representing a category to search within.
// ignore: must_be_immutable
class SearchInCategory with EquatableMixin {
  /// Constructs a [SearchInCategory] with the given [id] and [title].
  SearchInCategory({required this.id, required this.title});

  /// The unique identifier of the category.
  String id;

  /// The title of the category.
  String title;

  @override
  List<Object?> get props => [id, title];
}
