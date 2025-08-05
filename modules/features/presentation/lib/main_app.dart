import 'dart:developer';

import 'package:application/application.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:presentation/presentation.dart';

/// The main entry point of the application.
class MainApp extends StatefulWidget {
  /// Constructs a [MainApp] widget.
  const MainApp({super.key});

  @override
  _MainAppState createState() => _MainAppState();
}

/// The state for the [MainApp] widget.
class _MainAppState extends State<MainApp> {
  /// A focus node used for removing focus on widgets when the background
  /// is clicked.
  final _focusNode = FocusNode();

  /// Initializes the loading dialog manager.
  void _initLoadingDialogManager() =>
      serviceLocator<LoadingDialogManager>().init();

  @override
  void initState() {
    super.initState();

    _initLoadingDialogManager();
    Env.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return _MainAppBuilder(focusNode: _focusNode);
  }
}

class _MainAppBuilder extends StatelessWidget {
  const _MainAppBuilder({required FocusNode focusNode})
    : _focusNode = focusNode;

  final FocusNode _focusNode;

  @override
  Widget build(BuildContext context) {
    return _GlobalMultiBlocProvider(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(_focusNode),
        child: _SystemUIOverlayHandler(
          child: BlocBuilder<ThemeCubit, Brightness>(
            builder: (context, brightness) {
              // UNCOMMENT THIS IF DARK MODE IS NEEDED!!
              // final themeData = brightness == Brightness.light
              //     ? globalLightTheme
              //     : globalDarkTheme;

              final themeData = globalLightTheme;

              return MaterialApp.router(
                title: 'flutter_test_project',
                theme: themeData,
                // darkTheme: globalDarkTheme,
                debugShowCheckedModeBanner: false,
                builder: (context, child) {
                  final flutterSmartDialogBuilder =
                      FlutterSmartDialog.init(); //1. call init

                  // Obtain the current media query information.
                  final mediaQueryData = MediaQuery.of(context);

                  child = MediaQuery(
                    // Set the default textScaleFactor to 1.0 for
                    // the whole subtree.
                    data: mediaQueryData.copyWith(
                      textScaler: TextScaler.noScaling,
                    ),
                    child: _GlobalMultiBlocListener(
                      rootNavigatorKey: AppRouter.rootNavigatorKey,
                      child: child!,
                    ),
                  );

                  child = flutterSmartDialogBuilder(context, child);

                  /// Display the custom banner if existed
                  /// It will be used for easy tracking of the `env` and `flavor` of
                  /// the app.
                  if (Env.banner != '' && Env.flavor != 'prod') {
                    return Banner(
                      message: Env.banner,
                      location: BannerLocation.topEnd,
                      child: child,
                    );
                  }

                  return child;
                },
                routerConfig: router,
              );
            },
          ),
        ),
      ),
    );
  }
}

/// A widget which ensures that the system UI overlay are correctly calibrated
/// when the app is on foreground.
class _SystemUIOverlayHandler extends StatefulWidget {
  const _SystemUIOverlayHandler({required this.child});

  final Widget child;

  @override
  _SystemUIOverlayHandlerState createState() => _SystemUIOverlayHandlerState();
}

class _SystemUIOverlayHandlerState extends State<_SystemUIOverlayHandler>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   super.didChangeAppLifecycleState(state);

  //   // There are cases that the system ui overlay change while the app is at
  //   // the background.
  //   //
  //   // If the app state has returned in the foregroned, then ensure that the
  //   // system ui overlay is updated

  //   // UNCOMMENT THIS IF DARK MODE IS NEEDED!!
  //   // if (state == AppLifecycleState.resumed) {
  //   //   _updateSystemUIOverlay(BlocProvider.of<ThemeCubit>(context).state);
  //   // }
  // }

  @override
  Widget build(BuildContext context) {
    // UNCOMMENT THIS IF DARK MODE IS NEEDED!!
    // return BlocListener<ThemeCubit, Brightness>(
    //   listener: (context, brightness) => _updateSystemUIOverlay(brightness),
    //   child: widget.child,
    // );

    return widget.child;
  }

  /// Updates the status bar and system navigation bar colors based on the
  /// given [brightness].
  ///
  // UNCOMMENT THIS IF DARK MODE IS NEEDED!!

  // void _updateSystemUIOverlay(Brightness brightness) {
  //   SystemChrome.setSystemUIOverlayStyle(
  //     brightness == Brightness.light
  //         ? SystemUiOverlayStyle.light.copyWith(
  //             statusBarColor: Colors.transparent,
  //             statusBarIconBrightness: Brightness.dark,
  //           )
  //         : SystemUiOverlayStyle.dark.copyWith(
  //             statusBarColor: Colors.transparent,
  //             statusBarIconBrightness: Brightness.light,
  //           ),
  //   );
  // }
}

/// NOTE: Initialize all global blocs here
class _GlobalMultiBlocProvider extends StatefulWidget {
  const _GlobalMultiBlocProvider({required this.child});

  final Widget child;

  @override
  State<_GlobalMultiBlocProvider> createState() =>
      _GlobalMultiBlocProviderState();
}

class _GlobalMultiBlocProviderState extends State<_GlobalMultiBlocProvider> {
  @override
  Widget build(BuildContext context) {
    // NOTE: Sort by lazily loaded, alpha ascending
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) => serviceLocator<ThemeCubit>()..initialize(),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => serviceLocator<WatchDeeplinkCubit>()..watch(),
        ),
      ],
      child: widget.child,
    );
  }
}

/// NOTE: Setup global bloc listeners here.
class _GlobalMultiBlocListener extends StatelessWidget {
  const _GlobalMultiBlocListener({
    required this.child,
    required this.rootNavigatorKey,
  });

  final Widget child;

  /// A references to the root navigator key of the [MaterialApp].
  ///
  /// This is needed for displaying dialogs globally.
  final GlobalKey<NavigatorState> rootNavigatorKey;

  @override
  Widget build(BuildContext context) {
    // return Material(child: child);

    void openAppLink(Uri? uri) {
      log(uri?.path ?? '');
      if (uri != null) router.go(uri.path);
    }

    return MultiBlocListener(
      listeners: [
        BlocListener<WatchDeeplinkCubit, WatcherState>(
          listener: (context, watchDeepLinkState) {
            if (watchDeepLinkState is WatchValueChanged<DeeplinkData?>) {
              openAppLink(watchDeepLinkState.value?.uri);
            }
          },
        ),
      ],
      child: child,
    );
  }
}
