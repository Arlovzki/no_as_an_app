import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'example_request_body.g.dart';

/// {@template ExampleRequestBody}
/// A class representing the request body for an example API endpoint.
/// {@endtemplate}
@JsonSerializable()
class ExampleRequestBody with EquatableMixin {
  /// Constructs an [ExampleRequestBody] with the given [device_id].
  const ExampleRequestBody({
    required this.device_id,
  });

  /// Constructs an [ExampleRequestBody] instance from a JSON object.
  factory ExampleRequestBody.fromJson(Map<String, dynamic> json) =>
      _$ExampleRequestBodyFromJson(json);

  /// The device ID associated with the request.
  final int device_id;

  /// Converts this object to a JSON-compatible map.
  Map<String, dynamic> toJson() => _$ExampleRequestBodyToJson(this);

  @override
  List<Object?> get props => [device_id];
}
