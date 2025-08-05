import 'package:package_info_plus/package_info_plus.dart';

/// Holds the package information of the app.
late final PackageInfo packageInfo;

/// Initialize the package info plugin.
Future<void> initializePackageInfo() async {
  packageInfo = await PackageInfo.fromPlatform();
}
