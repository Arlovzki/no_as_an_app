import 'package:equatable/equatable.dart';

/// {@template GlobalAPISuccessResponseBody}
/// An abstract class representing the response body of a successful Global API request.
/// {@endtemplate}
abstract class GlobalAPISuccessResponseBody<T> with EquatableMixin {
  /// {@macro GlobalAPISuccessResponseBody}
  const GlobalAPISuccessResponseBody();

  /// The data associated with the successful response.
  T get data;

  @override
  List<Object?> get props => [data];
}
