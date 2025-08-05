import 'package:dartz/dartz.dart';
import 'package:domain/domain.dart';

/// {@template UtilsService}
/// This services will managed dynamic utils function such as banner of the app,
/// location-related and deeplink
/// {@endtemplate}
// ignore: one_member_abstracts
abstract class UtilsService {
  /// {@macro UtilsService}
  const UtilsService();

  /// Watch the stream of deeplink
  ///
  /// A [Failure] may be returned:
  /// - [void]
  Future<Either<Failure, Stream<DeeplinkData?>>> watchDeeplink();
}
