import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

/// {@template LoadingManager}
/// Manages the application loading state
///
/// The actual ui will be shown/hidden in [LoadingDialogManager]
/// {@endtemplate}
class LoadingManager {
  /// {@macro LoadingManager}
  LoadingManager({this.initialMessage = 'Loading'});

  /// The initial message of the loading.
  String initialMessage;

  /// Getter of the message of the loading.
  String get message => initialMessage;

  final _loadingStreamController = StreamController<bool>();

  /// Stream of the loading status.
  Stream<bool> get loadingStream => _loadingStreamController.stream;

  /// Status of the loading dialog if open/close.
  bool isOpen = false;

  /// function that displays the loading dialog
  ///
  /// Updates the [loadingStream] and broadcast it changes.
  void show({String message = 'Loading'}) {
    initialMessage = message;

    _setLoading(true);
  }

  /// function that hides the loading dialog.
  ///
  /// Updates the [loadingStream] and broadcast it changes.
  void close() {
    _setLoading(false);
  }

  void _setLoading(bool isLoading) {
    _loadingStreamController.add(isLoading);
    isOpen = isLoading;
  }
}

/// {@template LoadingDialogManager}
/// The class that holds the UI part of the loading.
/// {@endtemplate}
class LoadingDialogManager {
  /// {@macro LoadingDialogManager}
  LoadingDialogManager(this._globalNavigationKey, this._loadingManager);

  final GlobalKey<NavigatorState> _globalNavigationKey;
  final LoadingManager _loadingManager;

  /// The identifier of the loading dialog in the widget tree.
  BuildContext get globalContext => _globalNavigationKey.currentState!.context;

  /// Initialize the loading manager to listen to the state of the loading stream.
  void init() {
    _loadingManager.loadingStream.listen(_onLoadingStateChanged);
  }

  void _onLoadingStateChanged(bool isLoading) {
    if (isLoading) {
      SmartDialog.show(
        clickMaskDismiss: false,
        backType: SmartBackType.block,
        bindPage: true,
        tag: 'loading',
        builder: (globalContext) {
          return PopScope(
            canPop: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 90,
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Assets.lotties.pawPrints.lottie(
                    //   repeat: true,
                    //   height: 80,
                    // ),
                    const SizedBox(width: 16),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${_loadingManager.message}...',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          // style: nunito16w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } else {
      SmartDialog.dismiss(tag: 'loading');
    }
  }
}
