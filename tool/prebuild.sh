#!/bin/sh

# Cleans and re-fetches the dependencies in preparation for an app build.
#
# This also generates the `modules/presentation/lib/assets/assets.gen.dart` file
# of [flutter_gen package](https://pub.dev/packages/flutter_gen).

echo 'Clean project...'

flutter clean &
flutter clean modules/features/domain &
flutter clean modules/features/infrastructure &
flutter clean modules/features/application &
flutter clean modules/features/presentation

echo 'Get dependencies...'

flutter pub get modules/core --directory
flutter pub get modules/features/domain --directory
flutter pub get modules/features/infrastructure --directory
flutter pub get modules/features/application --directory
flutter pub get modules/features/presentation --directory
flutter pub get

echo 'Run builder runner...'

cd modules/features/infrastructure
dart run build_runner build --delete-conflicting-outputs
cd .. 
cd .. 
cd .. 
cd modules/features/presentation && 
dart run build_runner build --delete-conflicting-outputs


cd .. 
cd .. 
cd .. 
cd ios
rm Podfile.lock
if [ "$1" == "m1" ]; then
  arch -x86_64 pod update
else
  pod update
fi
cd ..