import 'package:chopper/chopper.dart';

/// {@template GlobalChopperClient}
/// A client for making HTTP requests to the Global API using Chopper.
/// {@endtemplate}
class GlobalChopperClient {
  /// {@macro GlobalChopperClient}
  GlobalChopperClient({
    required ChopperService service,
    required JsonConverter converter,
    required JsonConverter errorConverter,
    required Uri baseUrl,
  })  : _service = service,
        _converter = converter,
        _errorConverter = errorConverter,
        _baseUrl = baseUrl;

  final ChopperService _service;
  final JsonConverter _converter;
  final JsonConverter _errorConverter;
  final Uri _baseUrl;

  /// Creates a Chopper client configured to communicate with the Global API.
  ChopperClient create() {
    return ChopperClient(
      baseUrl: _baseUrl,
      converter: _converter,
      errorConverter: _errorConverter,
      services: [_service],
      interceptors: [HttpLoggingInterceptor()],
    );
  }
}
