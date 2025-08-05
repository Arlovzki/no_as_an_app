import 'dart:developer';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/domain.dart';

/// {@template UtilsServiceImpl}
/// Service Implementation of [UtilsService]
/// {@endtemplate}
class UtilsServiceImpl implements UtilsService {
  /// {@macro UtilsServiceImpl}
  UtilsServiceImpl({
    required Logger logger,
  }) : _logger = logger;

  final Logger _logger;

  @override
  Future<Either<Failure, Stream<DeeplinkData?>>> watchDeeplink() async {
    final messageLog = MessageLog(
      id: 'permission-management-service-request-microphone-permission-status',
    );

    return Right(serviceLocator<AppLinks>().uriLinkStream.map((uri) {
      _logger.info(messageLog
        ..message = 'Success'
        ..data.addAll({'uri': uri.toString()}));

      log(uri.toString());

      return DeeplinkData(uri);
    }));
  }
}
