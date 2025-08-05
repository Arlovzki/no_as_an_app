import 'package:domain/entities/pagination/search_in_category.dart';
import 'package:domain/entities/pagination/total_page_items.dart';
import 'package:equatable/equatable.dart';

/// {@template PageResult}
/// The resulting page result where [T] is the page item type.
/// {@endtemplate}
class PageResult<T> with EquatableMixin {
  /// {@macro PageResult}
  const PageResult({
    required this.items,
    this.totalPageItems,
    this.pageToken,
    this.subcategoryIds,
    this.types,
    this.tags,
    this.searchInCategory,
  });

  /// List of items returned by the page result.
  final List<T> items;

  /// The total number of items across all pages.
  final TotalPageItems? totalPageItems;

  /// The next page cursor.
  ///
  /// This is `null` if the page result points to the last page.
  final String? pageToken;

  /// The list of subcategory IDs associated with the page result.
  final List<String>? subcategoryIds;

  /// The list of types associated with the page result.
  final List<String>? types;

  /// The list of tags associated with the page result.
  final List<String>? tags;

  /// The list of categories to search within.
  final List<SearchInCategory>? searchInCategory;

  @override
  List<Object?> get props => [
        ...items,
        totalPageItems,
        pageToken,
        subcategoryIds,
        types,
        tags,
        searchInCategory,
      ];

  /// Creates a copy of this [PageResult] with the given fields replaced by
  /// the new values.
  PageResult<T> copyWith({
    List<T>? items,
    TotalPageItems? totalPageItems,
    String? pageToken,
    List<String>? subcategoryIds,
    List<String>? types,
    List<String>? tags,
    List<SearchInCategory>? searchInCategory,
  }) {
    return PageResult<T>(
      items: items ?? this.items,
      totalPageItems: totalPageItems ?? this.totalPageItems,
      pageToken: pageToken ?? this.pageToken,
      subcategoryIds: subcategoryIds ?? this.subcategoryIds,
      types: types ?? this.types,
      tags: tags ?? this.tags,
      searchInCategory: searchInCategory ?? this.searchInCategory,
    );
  }
}
