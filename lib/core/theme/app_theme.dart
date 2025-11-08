// lib/core/theme/app_theme.dart
import 'package:flutter/material.dart';

/// Tema de la aplicación con Material 3
/// Define colores, estilos y configuraciones visuales globales
class AppTheme {
  // Colores principales
  static const Color primaryBlue = Color(0xFF42A5F5);
  static const Color secondaryPurple = Color(0xFFAB47BC);
  static const Color accentAmber = Color(0xFFFFA726);
  static const Color darkBackground = Color(0xFF212121);
  static const Color successGreen = Color(0xFF66BB6A);
  static const Color errorRed = Color(0xFFEF5350);

  // Tema claro
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryBlue,
        brightness: Brightness.light,
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Gradientes predefinidos
  static LinearGradient get primaryGradient {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        primaryBlue.withOpacity(0.8),
        secondaryPurple.withOpacity(0.6),
      ],
    );
  }

  static LinearGradient get cardGradient {
    return LinearGradient(
      colors: [
        primaryBlue.withOpacity(0.1),
        primaryBlue.withOpacity(0.05),
      ],
    );
  }
}