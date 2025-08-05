// ignore_for_file: depend_on_referenced_packages

import 'package:application/application.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:get_it/get_it.dart';
import 'package:infrastructure/infrastructure.dart';
import 'package:presentation/presentation.dart';

part 'application_injectables.dart';
part 'core_injectables.dart';
part 'dependency_injectables.dart';
part 'infrastructure_injectables.dart';

/// THis function
Future<void> initialize() async {
  await Future.wait([
    injectInfrastructure(serviceLocator),
    injectionApplications(serviceLocator),
    injectCore(serviceLocator),
    injectDependencies(serviceLocator),
  ]);
}
