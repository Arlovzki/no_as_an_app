import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:presentation/themes/swatches/global_swatches.dart';

/// The global light theme.
final ThemeData globalLightTheme = _createGlobalThemeData(
  accentColor: satinGold,
  brightness: Brightness.light,
  primarySwatch: delftBlue,
  textTheme: _createTextTheme(brightness: Brightness.light),
);

/// The global dark theme.
final ThemeData globalDarkTheme = _createGlobalThemeData(
  accentColor: satinGold,
  brightness: Brightness.dark,
  primarySwatch: delftBlue,
  textTheme: _createTextTheme(brightness: Brightness.dark),
);

/// Defines the default corner radius for the Global theme.
const defaultCornerRadius = 12.0;

/// Defines the default corner radius for the Global theme.
const defaultButtonRadius = 100.0;

/// Defines the default padding of the screen.
const defaultScreenPadding = 16.0;

TextTheme _createTextTheme({required Brightness brightness}) {
  return GoogleFonts.montserratTextTheme().apply(
    bodyColor: brightness == Brightness.light
        ? ThemeData.light().textTheme.bodyLarge!.color
        : ThemeData.dark().textTheme.bodyLarge!.color,
    displayColor: brightness == Brightness.light
        ? ThemeData.light().textTheme.bodySmall!.color
        : ThemeData.dark().textTheme.bodySmall!.color,
  );
}

ThemeData _createGlobalThemeData({
  required Color accentColor,
  required Brightness brightness,
  required MaterialColor primarySwatch,
  required TextTheme textTheme,
}) {
  final primaryColor = primarySwatch;

  return ThemeData(
    scaffoldBackgroundColor: brightness == Brightness.light
        ? Colors.white
        : Colors.white,
    primaryColor: primaryColor,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: primaryColor,
      accentColor: accentColor,
      brightness: brightness,
    ),
    canvasColor: brightness == Brightness.light ? Colors.white : Colors.white,
    dialogTheme: DialogThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultCornerRadius),
      ),
    ),
    appBarTheme: AppBarTheme(
      elevation: 1.5,
      centerTitle: false,
      titleSpacing: 10,
      titleTextStyle: textTheme.headlineSmall!.copyWith(
        fontWeight: FontWeight.bold,
        color: primaryColor,
        fontSize: 28,
      ),
      color: primaryColor,
      iconTheme: IconThemeData(color: accentColor),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: brightness == Brightness.light ? Colors.white : null,
      selectedItemColor: primaryColor,
      unselectedItemColor: brightness == Brightness.light
          ? Colors.black38
          : Colors.white38,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: textTheme,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: _createTextTheme(
          brightness: brightness == Brightness.light
              ? Brightness.dark
              : Brightness.light,
        ).labelLarge!.color,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultButtonRadius),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultButtonRadius),
        ),
        side: const BorderSide(color: Colors.white),
      ),
    ),
    radioTheme: RadioThemeData(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryColor;
        }

        return brightness == Brightness.light ? Colors.black12 : Colors.white24;
      }),
    ),
    sliderTheme: const SliderThemeData(
      rangeThumbShape: RoundRangeSliderThumbShape(
        enabledThumbRadius: 12,
        elevation: 3,
      ),
      thumbColor: Colors.white,
      trackHeight: 5,
    ),
    snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.floating),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: accentColor),
        borderRadius: BorderRadius.circular(8),
      ),
      hintStyle: textTheme.bodyLarge!.copyWith(
        color: brightness == Brightness.light ? Colors.black38 : Colors.white38,
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.all(primarySwatch),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),
  );
}
