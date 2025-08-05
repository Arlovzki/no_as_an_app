import 'package:chopper/chopper.dart';
import 'package:core/core.dart';
import 'package:infrastructure/infrastructure.dart';

part 'example_feature.chopper.dart';

@ChopperApi(baseUrl: 'example')
/// {@template ExampleFeature}
/// An abstract class representing an example feature service.
/// {@endtemplate}
abstract class ExampleFeature extends ChopperService {
  /// Example API endpoint.
  @POST(path: '/')
  Future<Response<GlobalAPIBaseSuccessResponseBody>> example({
    @Body() required ExampleRequestBody body,
  });

  /// Creates an instance of [ExampleFeature].
  static ExampleFeature create() {
    // Register response factories and error factories.
    const converter = GlobalAPIJsonConverter(
      factories: {
        GlobalAPIBaseSuccessResponseBody:
            GlobalAPIBaseSuccessResponseBody.fromJson,
      },
    );

    return _$ExampleFeature(
      GlobalChopperClient(
        baseUrl: Uri.parse(Env.globalAPIBaseURL),
        service: _$ExampleFeature(),
        converter: converter,
        errorConverter: converter,
      ).create(),
    );
  }
}
