part of 'paginator_cubit.dart';

/// {@template PaginatorState}
/// A base abstract class representing the state of a paginator.
///
/// This class is intended to be extended by specific paginator state classes.
/// {@endtemplate}
abstract class PaginatorState with EquatableMixin {
  /// {@macro PaginatorState}
  const PaginatorState();
}

/// {@template PaginatorInitial}
/// Represents the initial state of the paginator.
/// {@endtemplate}
class PaginatorInitial extends PaginatorState {
  /// {@macro PaginatorInitial}
  const PaginatorInitial();

  @override
  List<Object?> get props => [];
}

/// {@template InitialPaging}
/// Emitted when the initial page is being loaded.
/// {@endtemplate}
class InitialPaging extends PaginatorState {
  /// {@macro InitialPaging}
  const InitialPaging();

  @override
  List<Object?> get props => [];
}

/// {@template InitialPageFailed}
/// Emitted when the initial page fails to load.
/// {@endtemplate}
class InitialPageFailed extends PaginatorState {
  /// {@macro InitialPageFailed}
  const InitialPageFailed({required this.failure});

  /// The failure that occurred while loading the initial page.
  final Failure failure;

  @override
  List<Object?> get props => [failure];
}

/// {@template InitialPageSuccess}
/// Emitted when the initial page is successfully loaded.
/// {@endtemplate}
class InitialPageSuccess<ResultType> extends PaginatorState {
  /// Constructs an [InitialPageSuccess] instance.
  ///
  /// [hasNextPage] indicates whether there are more pages available after the initial page.
  ///
  /// [pageItems] contains the items loaded on the initial page.
  const InitialPageSuccess({
    required this.hasNextPage,
    required this.pageItems,
  });

  /// Indicates whether there are more pages available after the initial page.
  final bool hasNextPage;

  /// The items loaded on the initial page.
  final List<ResultType> pageItems;

  @override
  List<Object?> get props => [hasNextPage, ...pageItems];
}

/// {@template NextPaging}
/// Emitted when the next page is loading.
/// {@endtemplate}
class NextPaging extends PaginatorState {
  /// Constructs a [NextPaging] instance.
  const NextPaging();

  @override
  List<Object?> get props => [];
}

/// {@template NextPageFailed}
/// Emitted when the next page fails to load.
/// {@endtemplate}
class NextPageFailed extends PaginatorState {
  /// Constructs a [NextPageFailed] instance.
  ///
  /// [hasNextPage] indicates whether there are more pages available after the failed page.
  ///
  /// [failure] represents the failure that occurred while loading the next page.
  const NextPageFailed({required this.hasNextPage, required this.failure});

  /// Indicates whether there are more pages available after the failed page.
  final bool hasNextPage;

  /// The failure that occurred while loading the next page.
  final Failure failure;

  @override
  List<Object?> get props => [hasNextPage, failure];
}

/// {@template NextPageSuccess}
/// Emitted when the next page successfully loads.
/// {@endtemplate}
class NextPageSuccess<ResultType> extends PaginatorState {
  /// Constructs a [NextPageSuccess] instance.
  ///
  /// [hasNextPage] indicates whether there are more pages available after the loaded page.
  ///
  /// [pageItems] contains the items loaded on the next page.
  const NextPageSuccess({
    required this.hasNextPage,
    required this.pageItems,
  });

  /// Indicates whether there are more pages available after the loaded page.
  final bool hasNextPage;

  /// The items loaded on the next page.
  final List<ResultType> pageItems;

  @override
  List<Object?> get props => [hasNextPage, ...pageItems];
}

/// {@template Clearing}
/// Emitted when the paginator is being cleared.
/// {@endtemplate}
class Clearing extends PaginatorState {
  /// Constructs a [Clearing] instance.
  const Clearing();

  @override
  List<Object?> get props => [];
}

/// {@template ClearSuccess}
/// Emitted when the paginator clearing is complete.
/// {@endtemplate}
class ClearSuccess extends PaginatorState {
  /// {@macro ClearSuccess}
  const ClearSuccess();

  @override
  List<Object?> get props => [];
}
