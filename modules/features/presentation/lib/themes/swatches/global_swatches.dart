import 'package:flutter/material.dart';

/// Sample primary color in map form.
Map<int, Color> delftBlueColor = {
  50: const Color(0xFF29345E).withValues(alpha: 0.1),
  100: const Color(0xFF29345E).withValues(alpha: 0.2),
  200: const Color(0xFF29345E).withValues(alpha: 0.3),
  300: const Color(0xFF29345E).withValues(alpha: 0.4),
  400: const Color(0xFF29345E).withValues(alpha: 0.5),
  500: const Color(0xFF29345E).withValues(alpha: 0.6),
  600: const Color(0xFF29345E).withValues(alpha: 0.7),
  700: const Color(0xFF29345E).withValues(alpha: 0.8),
  800: const Color(0xFF29345E).withValues(alpha: 0.9),
  900: const Color(0xFF29345E).withValues(alpha: 1),
};

/// Sample primary color in material color.
MaterialColor delftBlue = MaterialColor(0xFF29345E, delftBlueColor);

/// Sample accent color.
const satinGold = Color(0xFFC5A03F);

/// Sample error color.
const lavaRed = Color(0xFFEE2A29);
