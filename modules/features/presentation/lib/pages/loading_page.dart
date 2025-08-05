// // ignore_for_file: lines_longer_than_80_chars

// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:presentation/routes/app_router.dart';

// class LoadingPage extends StatefulWidget {
//   const LoadingPage({super.key});

//   @override
//   State<LoadingPage> createState() => _LoadingPageState();
// }

// bool isLoading = true;

// class _LoadingPageState extends State<LoadingPage> {
//   @override
//   void initState() {
//     super.initState();

//     Future.delayed(const Duration(seconds: 5)).then(
//       (value) => {
//         if (mounted)
//           context.go(
//             context.namedLocation(
//               RoutePath.main.name,
//               pathParameters: {'param': 'Sample Params'},
//               queryParameters: {'key1': 'sample query param'},
//             ),
//           )
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder(
//         future: Future.delayed(const Duration(seconds: 5)),
//         builder: (context, snapshot) {
//           return const Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 CircularProgressIndicator(),
//                 Text(
//                   'Loading page...',
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }



// // // ignore_for_file: use_build_context_synchronously

// // import 'package:application/blocs/abstracts/runner/runner_cubit.dart';
// // import 'package:application/blocs/global/dynamic_link/watch_dynamic_link_cubit.dart';
// // import 'package:application/blocs/global/theme/theme_cubit.dart';
// // import 'package:application/blocs/local/app_initializer/app_initializer_cubit.dart';
// // import 'package:application/blocs/local/app_initializer/initializers/cart_initializer.dart';
// // import 'package:application/blocs/local/app_initializer/initializers/remote_config_initializer.dart';
// // import 'package:application/blocs/local/app_initializer/initializers/shared_preferences_initializer.dart';
// // import 'package:application/blocs/local/app_initializer/initializers/silent_sign_in_initializer.dart';
// // import 'package:application/blocs/local/authentication/sign_in_anonymously_cubit.dart';
// // import 'package:core/extensions/dartz_extension.dart';
// // import 'package:core/service_locator.dart';
// // import 'package:domain/entities/order/order_item_change.dart';
// // import 'package:domain/failures/network/network_failure.dart';
// // import 'package:domain/services/remote_config_service.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:presentation/global_widgets/actuators/failure_actuator.dart';
// // import 'package:presentation/global_widgets/actuators/network_failure_actuator.dart';
// // import 'package:presentation/global_widgets/bottom_sheets/cart_changes_bottom_sheet.dart';
// // import 'package:presentation/global_widgets/dialogs/update_dialog.dart';
// // import 'package:presentation/global_widgets/inherited_widgets/inherited_main_page.dart';
// // import 'package:presentation/global_widgets/loading/loading_contents.dart';
// // import 'package:presentation/pages/main_page.dart';
// // import 'package:presentation/pages/maintenance_page.dart';
// // import 'package:presentation/pages/onboarding/carousel_page.dart';
// // import 'package:presentation/pages/onboarding/landing_page.dart';
// // import 'package:presentation/routes/named_page_route.dart';
// // import 'package:presentation/utils/deeplink_redirection_logic.dart';
// // import 'package:presentation/utils/open_store_listing.dart';

// // class LoadingPage extends StatefulWidget {
// //   const LoadingPage({super.key});

// //   @override
// //   State<LoadingPage> createState() => _LoadingPageState();
// // }

// // class _LoadingPageState extends State<LoadingPage> {
// //   bool isSecondOpen = false;

// //   @override
// //   Widget build(BuildContext context) {
// //     final isLightTheme =
// //         BlocProvider.of<ThemeCubit>(context).state == Brightness.light;

// //     return Stack(
// //       children: [
// //         Scaffold(
// //           appBar: AppBar(
// //             systemOverlayStyle: isLightTheme
// //                 ? SystemUiOverlayStyle.dark
// //                 : SystemUiOverlayStyle.light,
// //           ),
// //         ),
// //         Scaffold(
// //           appBar: AppBar(
// //             automaticallyImplyLeading: false,
// //             elevation: 0,
// //             backgroundColor: Theme.of(context).scaffoldBackgroundColor,
// //           ),
// //           body: Center(
// //             child: BlocProvider(
// //               lazy: false,
// //               create: (context) =>
// //                   serviceLocator<AppInitializerCubit>()..run(params: null),
// //               child: BlocConsumer<AppInitializerCubit, RunnerState>(
// //                 listener: (context, initializeAppState) async {
// //                   if (initializeAppState is RunSuccess<InitializeAppResult>) {
// //                     final isAppOutdated = initializeAppState
// //                         .result<RemoteConfigInitializer>()!
// //                         .result() as bool;

// //                     final maintenanceMode =
// //                         await serviceLocator<RemoteConfigService>()
// //                             .maintenanceMode();

// //                     if (maintenanceMode.right()) {
// //                       Navigator.of(context).pushReplacement(
// //                         NamedPageRoute<MaintenancePage, dynamic>(
// //                           builder: (context) => const MaintenancePage(),
// //                         ),
// //                       );
// //                     } else {
// //                       final hasSession = initializeAppState
// //                           .result<SilentSignInInitializer>()!
// //                           .result() as bool;

// //                       if (hasSession) {
// //                         Navigator.of(context).pushReplacement(
// //                           NamedPageRoute<InheritedMainPage, dynamic>(
// //                             builder: (context) => InheritedMainPage(
// //                               mainPageKey: GlobalKey<MainPageState>(),
// //                             ),
// //                           ),
// //                         );
// //                         deepLinkRedirectionLogic(context);
// //                       } else {
// //                         final deeplinkobject =
// //                             BlocProvider.of<WatchDeepLinkCubit>(context).value;
// //                         //If there's a deeplink present, forced login the user as
// //                         // guest before redirecting.
// //                         if (deeplinkobject != null) {
// //                           await BlocProvider.of<SignInAnonymouslyCubit>(context)
// //                               .run(params: null);
// //                           final signInState =
// //                               BlocProvider.of<SignInAnonymouslyCubit>(context)
// //                                   .state;
// //                           if (signInState is RunSuccess) {
// //                             Navigator.of(context).pushReplacement(
// //                               NamedPageRoute<InheritedMainPage, dynamic>(
// //                                 builder: (context) => InheritedMainPage(
// //                                   mainPageKey: GlobalKey<MainPageState>(),
// //                                 ),
// //                               ),
// //                             );
// //                             deepLinkRedirectionLogic(context);
// //                           }
// //                         } else {
// //                           isSecondOpen = initializeAppState
// //                               .result<SharedPreferencesInitializer>()!
// //                               .result() as bool;
// //                           if (isSecondOpen) {
// //                             Navigator.of(context).pushReplacement(
// //                               NamedPageRoute<LandingPage, dynamic>(
// //                                 builder: (context) => const LandingPage(),
// //                               ),
// //                             );
// //                           } else {
// //                             Navigator.of(context).pushReplacement(
// //                               NamedPageRoute<CarouselPage, dynamic>(
// //                                 builder: (context) => const CarouselPage(),
// //                               ),
// //                             );
// //                           }
// //                         }
// //                       }

// //                       if (isAppOutdated) {
// //                         final result = await UpdateDialog(
// //                           context,
// //                         ).show();
// //                         if (result) {
// //                           await openStoreListing(context);
// //                         }
// //                       }

// //                       final cartItemChanges = initializeAppState
// //                           .result<CartInitializer>()!
// //                           .result() as List<OrderItemChange>?;

// //                       final cartItemChangesFiltered = cartItemChanges
// //                           ?.where(
// //                             (itemChange) =>
// //                                 itemChange.changeType ==
// //                                     OrderItemChangeType.deletedOrderItem ||
// //                                 itemChange.changeType ==
// //                                     OrderItemChangeType.updatedOrderItem,
// //                           )
// //                           .toList();

// //                       if (cartItemChangesFiltered?.isNotEmpty ?? false) {
// //                         CartChangesBottomSheet(
// //                           context,
// //                           orderItemChanges: cartItemChangesFiltered!,
// //                         ).show();
// //                       }
// //                     }
// //                   }
// //                 },
// //                 builder: (context, refreshSessionState) {
// //                   if (refreshSessionState is RunFailed) {
// //                     final failure = refreshSessionState.failure;

// //                     if (failure is NetworkFailure) {
// //                       return NetworkFailureActuator(
// //                         onPressed: () =>
// //                             BlocProvider.of<AppInitializerCubit>(context)
// //                                 .run(params: null),
// //                       );
// //                     } else {
// //                       return FailureActuator(
// //                         description: failure.message,
// //                         onPressed: () =>
// //                             BlocProvider.of<AppInitializerCubit>(context)
// //                                 .run(params: null),
// //                       );
// //                     }
// //                   }

// //                   return LoadingContent(
// //                     isSecondOpen: isSecondOpen,
// //                     isInitialization: true,
// //                   );
// //                 },
// //               ),
// //             ),
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }
