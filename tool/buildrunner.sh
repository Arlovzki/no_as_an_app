#!/bin/sh

# run the build runner for generating models, and etc.
flutter pub get
cd modules/features/infrastructure
dart run build_runner build --delete-conflicting-outputs
cd .. 
cd .. 
cd .. 
cd modules/features/presentation
dart run build_runner build --delete-conflicting-outputs
cd .. 
cd .. 
cd .. 