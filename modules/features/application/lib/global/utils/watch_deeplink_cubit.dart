import 'package:application/application.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/domain.dart';

/// Returns a [DeeplinkData] stream.
///
/// This returns the latest [DeeplinkData] value upon streaming.
class WatchDeeplinkCubit extends WatcherCubit<DeeplinkData?> {
  /// {@macro WatchDeeplinkCubit}
  WatchDeeplinkCubit({required UtilsService utilsService})
      : _utilsService = utilsService;

  final UtilsService _utilsService;

  @override
  Future<Either<Failure, Stream<DeeplinkData?>>> onWatch() =>
      _utilsService.watchDeeplink();
}
