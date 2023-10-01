import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  static var light = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.white).copyWith(
      primary: const Color(0xFFDCC06D), // Soft yellow as the primary color
      //primaryVariant: Color(0xFFDCC06D), // A slightly darker shade
      secondary: const Color(0xFF6D6D6D), // A secondary color (e.g., gray)
      //secondaryVariant: Color(0xFF464646), // A darker shade of secondary color
      surface: Colors.white, // Background color
      background: Colors.white, // Background color
      error: const Color(0xFFD32F2F), // Error color
      onPrimary: Colors.black, // Text color on primary color
      onSecondary: Colors.white, // Text color on secondary color
      onSurface: Colors.black, // Text color on surface
      onBackground: Colors.black, // Text color on background
      onError: Colors.white,
      inversePrimary: const Color(0xFFDCC06D),
      primaryContainer: const Color(0xFFDCC06D),
      onPrimaryContainer: const Color(0xFFFFF2D0),
      inverseSurface: Colors.white,
      onSecondaryContainer: const Color(0xFF464646),
    ),
    useMaterial3: true,
  );

  static var dark = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
  );
}

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? Colors.grey[400] : Colors.grey,
    ),
  );
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
    ),
  );
}

TextStyle get titleStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Get.isDarkMode ? Colors.white : Colors.black,
    ),
  );
}

TextStyle get subTitleStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[600],
    ),
  );
}
