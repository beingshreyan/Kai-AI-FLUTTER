import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF09090B), 
      primaryColor: const Color(0xFF00FFCC), 
      
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF00FFCC),
        secondary: Color(0xFFFF00FF), 
        surface: Color(0xFF18181B), 
      ),
      
      
        textTheme: ThemeData.dark().textTheme
          .apply(fontFamily: GoogleFonts.spaceGrotesk().fontFamily)
          .copyWith(
        bodyLarge: const TextStyle(color: Colors.white, fontSize: 16),
        bodyMedium: const TextStyle(color: Colors.white70, fontSize: 14),
        titleLarge: const TextStyle(
          color: Color(0xFF00FFCC), 
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
      
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF09090B),
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xFF00FFCC)),
      ),
      
      
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF18181B),
        hintStyle: const TextStyle(color: Colors.white38),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: Color(0xFF00FFCC), width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
    );
  }
}