import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:core/core.dart';

/// {@template BaseJsonConverter}
/// Maps the API responses into dart objects.
///
/// For more information on this class,
/// see: https://github.com/lejard-h/chopper/tree/develop/example
/// {@endtemplate}
class BaseJsonConverter extends JsonConverter {
  /// {@macro BaseJsonConverter}
  const BaseJsonConverter({
    this.factories,
    this.errorFactories,
    this.defaultFactory,
    this.defaultErrorFactory,
  });

  /// List of factories for responses with status code equal to 2XX.
  ///
  /// If the response is not found in this list, then [defaultFactory]
  /// will be used.

  final Map<Type, JsonFactory>? factories;

  /// List of factories for responses with status code not equal to 2XX.
  ///
  /// If the response is not found in this list, then a [defaultErrorFactory]
  /// will be used.
  final Map<Type, JsonFactory>? errorFactories;

  /// The default factory used if no matching factory is found in [factories].
  final JsonFactory? defaultFactory;

  /// The default error factory used if no matching factory is found in
  /// [errorFactories].
  final JsonFactory? defaultErrorFactory;

  U? _decodeMap<T, U>(Map<String, dynamic> values, {bool toError = false}) {
    // Get jsonFactory using Type parameters

    final jsonFactory = toError
        ? (errorFactories?.containsKey(T) ?? false)
            ? errorFactories![T]!
            : defaultErrorFactory!
        : (factories?.containsKey(T) ?? false)
            ? factories![T]!
            : defaultFactory!;

    return jsonFactory(values) as U;
  }

  List<U> _decodeList<T, U>(List values, {bool toError = false}) {
    return values
        .where((v) => v != null)
        .map<U>((v) => _decode<T, U>(v, toError: toError) as U)
        .toList();
  }

  dynamic _decode<T, U>(dynamic entity, {bool toError = false}) {
    if (entity is Iterable) {
      return _decodeList<T, U>(entity as List, toError: toError);
    }

    if (entity is Map) {
      return _decodeMap<T, U>(entity as Map<String, dynamic>, toError: toError);
    }

    return entity;
  }

  /// The converter function called when the status code of the response is 2XX.
  @override
  FutureOr<Response<ResultType>> convertResponse<ResultType, Item>(
    Response<dynamic> response,
  ) async {
    final jsonRes = await super.convertResponse(response);

    return jsonRes.copyWith<ResultType>(
      body: _decode<Item, Item>(jsonRes.body) as ResultType?,
    );
  }

  /// The converter function called when the status code of the response is not
  /// 2XX.
  @override
  FutureOr<Response<dynamic>> convertError<ResultType, Item>(
    Response<dynamic> response,
  ) async {
    final jsonRes = await super.convertError(response);

    return jsonRes.copyWith(
      body: _decode<Item, dynamic>(jsonRes.body, toError: true),
    );
  }
}
