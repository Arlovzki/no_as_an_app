import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:flutter/foundation.dart';

/// {@template ThemeCubit}
/// A cubit responsible for managing the theme brightness of the application.
/// {@endtemplate}
class ThemeCubit extends Cubit<Brightness> {
  /// {@macro ThemeCubit}
  ThemeCubit() : super(Brightness.light);

  /// Initializes this cubit.
  ///
  /// This method sets up a watcher for any brightness changes on the device
  /// to automatically update the app's theme.
  Future<void> initialize() async {
    await ensureAsync();
    _watchPlatformBrightnessChanges();
  }

  /// Watches for any brightness changes on the device to automatically update
  /// the app's theme.
  void _watchPlatformBrightnessChanges() {
    final window = PlatformDispatcher.instance.views.first.platformDispatcher;

    // Update the theme mode when setting up the watcher.
    emit(window.platformBrightness);

    // Setup a listener that will automatically update the theme mode based on
    // the device's brightness preference.
    window.onPlatformBrightnessChanged = () {
      emit(window.platformBrightness);
    };
  }
}
