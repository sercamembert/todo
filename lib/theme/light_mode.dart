import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
        background: Color(0xFFF1F5F9),
        primary: Color(0xFF4A3780),
        secondary: Color(0xFFE0E0E0),
        inversePrimary: Color(0xFF606061)),
    textTheme: GoogleFonts.interTextTheme(
      ThemeData.light().textTheme.apply(
            bodyColor: const Color(0xFF1B1B1D),
            displayColor: Colors.white,
          ),
    ));
