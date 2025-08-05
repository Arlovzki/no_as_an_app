import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:domain/domain.dart';
// import 'package:infrastructure/infrastructure.dart';

/// Holds the device information where the app is currently running.
late DeviceInfo deviceInfo;

/// Initialize the plugin for getting the device information
Future<void> initializeDeviceInfo() async {
  final deviceInfoPlugin = DeviceInfoPlugin();

  if (kIsWeb) {
    // final _preferences = serviceLocator<Preferences>();

    // /// Check if the app is on web platform

    // /// then, check if there's an existing `web device id`
    // ///
    // /// If false, generate a new one and save it locally.
    // ///
    // /// The `web device id` will be used as a device id for
    // /// device registration
    // var webDeviceId = await _preferences.fetchWebDeviceId();

    // if (webDeviceId?.deviceId == null) {
    //   final deviceId = generateUUID();

    //   await _preferences.setWebDeviceId(
    //       deviceId: PrefWebDeviceIdModel(deviceId: deviceId));
    // }

    // final webBrowserInfo = await deviceInfoPlugin.webBrowserInfo;

    // /// Fetch the saved `web device id` from local storage.
    // webDeviceId = await serviceLocator<Preferences>().fetchWebDeviceId();

    // deviceInfo = _DeviceInfo(
    //     deviceId: webDeviceId!.deviceId, webBrowserInfo: webBrowserInfo);
  } else {
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfoPlugin.androidInfo;

      deviceInfo =
          DeviceInfo(deviceId: androidInfo.id, androidDeviceInfo: androidInfo);
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfoPlugin.iosInfo;

      deviceInfo = DeviceInfo(
        deviceId: iosInfo.identifierForVendor!,
        iosDeviceInfo: iosInfo,
      );
    }
  }

  // // Get device cache size
  // deviceInfo = deviceInfo.copywith(cacheSize: await getCacheSize());
}

/// {@template DeviceInfo}
/// Class that holds the current device information.
/// {@endtemplate}
class DeviceInfo {
  /// {@macro DeviceInfo}
  const DeviceInfo({
    required this.deviceId,
    this.androidDeviceInfo,
    this.webBrowserInfo,
    this.iosDeviceInfo,
    this.cacheSize = 0,
  });

  /// The unique id of the device.
  final String deviceId;

  /// Holds android device info.
  final AndroidDeviceInfo? androidDeviceInfo;

  /// Holds ios device info.
  final IosDeviceInfo? iosDeviceInfo;

  /// Holds web device info.
  final WebBrowserInfo? webBrowserInfo;

  /// Identifies the current cache size of the app.
  final int cacheSize;

  /// @nodoc
  DeviceInfo copywith({
    String? deviceId,
    AndroidDeviceInfo? androidDeviceInfo,
    IosDeviceInfo? iosDeviceInfo,
    WebBrowserInfo? webBrowserInfo,
    int? cacheSize,
  }) {
    return DeviceInfo(
      deviceId: deviceId ?? this.deviceId,
      androidDeviceInfo: androidDeviceInfo ?? this.androidDeviceInfo,
      iosDeviceInfo: iosDeviceInfo ?? this.iosDeviceInfo,
      webBrowserInfo: webBrowserInfo ?? this.webBrowserInfo,
      cacheSize: cacheSize ?? this.cacheSize,
    );
  }
}

// Future<int> getCacheSize() async {
//   if (kIsWeb) {
//     return 0;
//   } else {
//     Directory tempDir = await getTemporaryDirectory();
//     int tempDirSize = _getSize(tempDir);
//     return tempDirSize;
//   }
// }

// int _getSize(FileSystemEntity file) {
//   if (file is File) {
//     return file.lengthSync();
//   } else if (file is Directory) {
//     int sum = 0;
//     List<FileSystemEntity> children = file.listSync();
//     for (FileSystemEntity child in children) {
//       sum += _getSize(child);
//     }
//     return sum;
//   }
//   return 0;
// }
