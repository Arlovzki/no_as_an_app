// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example_feature.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$ExampleFeature extends ExampleFeature {
  _$ExampleFeature([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = ExampleFeature;

  @override
  Future<Response<GlobalAPIBaseSuccessResponseBody>> example(
      {required ExampleRequestBody body}) {
    final Uri $url = Uri.parse('example/');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<GlobalAPIBaseSuccessResponseBody,
        GlobalAPIBaseSuccessResponseBody>($request);
  }
}
