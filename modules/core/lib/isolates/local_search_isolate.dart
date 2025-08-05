import 'dart:core';

import 'package:flutter/foundation.dart';

/// Runs a local search by filtering the items that starts with the given
/// keyword.
///
/// This functions runs on an isolate for better efficiency.
Future<List<String>> computeLocalSearch(ComputeLocalSearchParams params) =>
    compute(_localSearch, params);

List<String> _localSearch(ComputeLocalSearchParams params) {
  return params.items
      .toSet()
      .where((element) => element.startsWith(params.keyword))
      .toList();
}

/// {@template ComputeLocalSearchParams}
/// Parameters for local search computing.
/// {@endtemplate}
class ComputeLocalSearchParams {
  /// {@macro ComputeLocalSearchParams}
  const ComputeLocalSearchParams({required this.items, required this.keyword});

  /// List of string items.
  final List<String> items;

  /// Identifies the search query.
  final String keyword;
}
