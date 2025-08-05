import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'paginator_state.dart';

/// {@template PaginatorCubit}
/// A generic bloc used for loading a list of search results in a paginated
/// manner.
///
/// If more than one method calls are running concurrently, the previous method
/// states are ignored in favor of the new method call states.
///
/// e.g.
/// @0:00: Paging event A started
/// @0:01: Paging state A emitted
/// @0:02: Paging event B started
/// @0:03: Paging state B emitted
/// @0:05: PageSuccess state B emitted
/// {@endtemplate}
abstract class PaginatorCubit<Params, ResultType>
    extends Cubit<PaginatorState> {
  /// Constructs a [PaginatorCubit] instance with an initial state of [PaginatorInitial].
  PaginatorCubit() : super(const PaginatorInitial());

  /// A collation of all loaded page items populating by calling [initialPage]
  /// and [nextPage].
  ///
  /// If [initialPage] is called, then all existing page items will be
  /// overwritten.
  List<ResultType> _pageItems = [];

  /// The last page loaded which may contain a page token for loading the next
  /// page.
  ///
  /// If [initialPage] is called, then this initially gets set to `null`.
  PageResult<ResultType>? _lastPageResult;

  /// References the current parameters for pagination.
  ///
  /// If this changes, then the paginator will start from scratch.
  Params? _currentParams;

  /// Returns all [ResultType] page items obtained from all succeeding page
  /// results.
  List<ResultType> pageItems() => _pageItems;

  /// Returns `true` if a next page is available. Otherwise, `false` is
  /// returned if the last page has been loaded.
  bool hasNextPage() => _lastPageResult?.pageToken != null;

  /// Retrieves the last page result.
  ///
  /// Returns the last [PageResult] object stored in the `_lastPageResult` field.
  /// If no result is available (i.e., `_lastPageResult` is null), it returns null.
  PageResult<ResultType>? lastPageResult() => _lastPageResult;

  /// Retrieves the current parameters.
  ///
  /// Returns the current [Params] object stored in the `_currentParams` field.
  /// If no parameters are available (i.e., `_currentParams` is null), it returns null.
  Params? currentParams() => _currentParams;

  /// Implementation of child paginators on how to load the next page.
  Future<Either<Failure, PageResult<ResultType>>> onLoad({
    required Params params,
    String? pageToken,
  });

  /// Serves as a token for each [initialPage] and [nextPage] call so that only
  /// the recent method call will be continued.
  int _runToken = 0;

  /// Assigns the paging arguments then loads the first page.
  Future<void> initialPage({required Params params}) async {
    await ensureAsync();

    if (isClosed) {
      return;
    }

    final runToken = ++_runToken;

    // Assign the new parameters
    _currentParams = params;

    // Reset the page items and page results
    _pageItems = [];
    _lastPageResult = null;

    emit(const InitialPaging());

    // Load first page

    final result = await onLoad(params: params);

    // If the run token has changed, then cancel this method call
    if (runToken != _runToken) {
      return;
    }

    if (isClosed) {
      return;
    }

    emit(
      result.fold(
        (l) => InitialPageFailed(failure: l),
        (r) {
          _lastPageResult = r;

          return InitialPageSuccess(
            hasNextPage: r.pageToken != null,
            pageItems: _pageItems..addAll(r.items),
          );
        },
      ),
    );
  }

  /// Loads the next page, if any.
  ///
  /// Note that [initialPage] must be called first to setup the page arguments.
  Future<void> nextPage() async {
    await ensureAsync();

    if (_currentParams == null || _lastPageResult == null) {
      return;
    }

    final runToken = ++_runToken;

    // If there is no last page result, then simply return because the initial
    //page has not been loaded yet

    emit(const NextPaging());

    // Load first page

    final result = await onLoad(
      // This is a false-positive lint error by Dart. _currentParams has been
      // checked if it is null before making this call.
      // ignore: null_check_on_nullable_type_parameter
      params: _currentParams!,
      pageToken: _lastPageResult!.pageToken,
    );

    // If the run token has changed, then cancel this method call
    if (runToken != _runToken) {
      return;
    }

    if (isClosed) {
      return;
    }

    emit(
      result.fold(
        (l) => NextPageFailed(
          hasNextPage: _lastPageResult!.pageToken != null,
          failure: l,
        ),
        (r) {
          _lastPageResult = r;

          return NextPageSuccess(
            hasNextPage: r.pageToken != null,
            pageItems: _pageItems..addAll(r.items),
          );
        },
      ),
    );
  }

  /// Clears the paginator by removing all loaded pages.
  Future<void> clear() async {
    await ensureAsync();

    /// Just increment the run token to cancel and preceding method calls.
    ++_runToken;

    emit(const Clearing());

    // Assign the new parameters
    _currentParams = null;

    // Reset the page items and page results
    _pageItems = [];
    _lastPageResult = null;

    emit(const ClearSuccess());
  }
}
