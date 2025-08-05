import 'package:infrastructure/infrastructure.dart';
import 'package:json_annotation/json_annotation.dart';

part 'global_api_base_success_response_body.g.dart';

/// {@template GlobalAPIBaseSuccessResponseBody}
/// The basic response inherited by all Global API success responses.
/// {@endtemplate}
@JsonSerializable()
class GlobalAPIBaseSuccessResponseBody
    extends GlobalAPISuccessResponseBody<void> {
  /// {@macro GlobalAPIBaseSuccessResponseBody}
  const GlobalAPIBaseSuccessResponseBody({this.message});

  /// Constructs a [GlobalAPIBaseSuccessResponseBody] instance from a JSON object.
  factory GlobalAPIBaseSuccessResponseBody.fromJson(
    Map<String, dynamic> json,
  ) => _$GlobalAPIBaseSuccessResponseBodyFromJson(json);

  /// An optional message associated with the success response.
  final String? message;

  /// Converts this object to a JSON-compatible map.
  Map<String, dynamic> toJson() =>
      _$GlobalAPIBaseSuccessResponseBodyToJson(this);

  @override
  void get data {
    return;
  }
}
