import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'global_api_base_error_response_body.g.dart';

/// {@template GlobalAPIBaseErrorResponseBody}
/// The Standard Global API error response body.
/// {@endtemplate}
@JsonSerializable()
class GlobalAPIBaseErrorResponseBody with EquatableMixin {
  /// Constructs a [GlobalAPIBaseErrorResponseBody] with the given [error_code],
  /// [message], and [errors].
  const GlobalAPIBaseErrorResponseBody({
    required this.error_code,
    required this.message,
    required this.errors,
  });

  /// Constructs a [GlobalAPIBaseErrorResponseBody] instance from a JSON object.
  factory GlobalAPIBaseErrorResponseBody.fromJson(Map<String, dynamic> json) =>
      _$GlobalAPIBaseErrorResponseBodyFromJson(json);

  /// The error code associated with the error response.
  final String error_code;

  /// A human-readable error message describing the error.
  final String message;

  /// Additional error details.
  final Map<String, dynamic> errors;

  /// Converts this object to a JSON-compatible map.
  Map<String, dynamic> toJson() => _$GlobalAPIBaseErrorResponseBodyToJson(this);

  @override
  List<Object?> get props => [error_code, message, errors];
}
