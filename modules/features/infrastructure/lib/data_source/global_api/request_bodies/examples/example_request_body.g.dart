// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExampleRequestBody _$ExampleRequestBodyFromJson(Map<String, dynamic> json) =>
    ExampleRequestBody(
      device_id: (json['device_id'] as num).toInt(),
    );

Map<String, dynamic> _$ExampleRequestBodyToJson(ExampleRequestBody instance) =>
    <String, dynamic>{
      'device_id': instance.device_id,
    };
