// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global_api_base_error_response_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GlobalAPIBaseErrorResponseBody _$GlobalAPIBaseErrorResponseBodyFromJson(
        Map<String, dynamic> json) =>
    GlobalAPIBaseErrorResponseBody(
      error_code: json['error_code'] as String,
      message: json['message'] as String,
      errors: json['errors'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$GlobalAPIBaseErrorResponseBodyToJson(
        GlobalAPIBaseErrorResponseBody instance) =>
    <String, dynamic>{
      'error_code': instance.error_code,
      'message': instance.message,
      'errors': instance.errors,
    };
