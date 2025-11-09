// lib/core/utils/responsive_utils.dart
import 'package:flutter/material.dart';

/// Utilidades para diseño responsive
class ResponsiveUtils {
  /// Obtiene el tamaño de pantalla
  static Size getScreenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  /// Obtiene el ancho de pantalla
  static double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// Obtiene el alto de pantalla
  static double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  /// Verifica si es un dispositivo pequeño (< 360px)
  static bool isSmallDevice(BuildContext context) {
    return getWidth(context) < 360;
  }

  /// Verifica si es un dispositivo mediano (360-600px)
  static bool isMediumDevice(BuildContext context) {
    final width = getWidth(context);
    return width >= 360 && width < 600;
  }

  /// Verifica si es una tablet (>= 600px)
  static bool isTablet(BuildContext context) {
    return getWidth(context) >= 600;
  }

  /// Obtiene padding responsive basado en el tamaño de pantalla
  static double getResponsivePadding(BuildContext context, {
    double small = 12.0,
    double medium = 16.0,
    double large = 24.0,
  }) {
    if (isSmallDevice(context)) return small;
    if (isTablet(context)) return large;
    return medium;
  }

  /// Obtiene tamaño de fuente responsive
  static double getResponsiveFontSize(BuildContext context, {
    double small = 12.0,
    double medium = 14.0,
    double large = 16.0,
  }) {
    if (isSmallDevice(context)) return small;
    if (isTablet(context)) return large;
    return medium;
  }

  /// Escala un valor basado en el ancho de pantalla
  /// Usa 375 como baseline (iPhone SE / tamaño común)
  static double scaleWidth(BuildContext context, double size) {
    final width = getWidth(context);
    return (size * width) / 375;
  }

  /// Escala un valor basado en el alto de pantalla
  /// Usa 667 como baseline
  static double scaleHeight(BuildContext context, double size) {
    final height = getHeight(context);
    return (size * height) / 667;
  }

  /// Obtiene un tamaño de icono responsive
  static double getIconSize(BuildContext context, {
    double baseSize = 24.0,
  }) {
    if (isSmallDevice(context)) return baseSize * 0.9;
    if (isTablet(context)) return baseSize * 1.3;
    return baseSize;
  }

  /// Obtiene el radio de borde responsive
  static double getBorderRadius(BuildContext context, {
    double small = 12.0,
    double medium = 16.0,
    double large = 20.0,
  }) {
    if (isSmallDevice(context)) return small;
    if (isTablet(context)) return large;
    return medium;
  }

  /// Calcula el espacio vertical entre elementos
  static double getVerticalSpacing(BuildContext context, {
    double multiplier = 1.0,
  }) {
    if (isSmallDevice(context)) return 8.0 * multiplier;
    if (isTablet(context)) return 16.0 * multiplier;
    return 12.0 * multiplier;
  }

  /// Obtiene márgenes seguros
  static EdgeInsets getSafeAreaPadding(BuildContext context) {
    return MediaQuery.of(context).padding;
  }

  /// Verifica si el dispositivo está en orientación horizontal
  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  /// Obtiene un valor escalado proporcionalmente
  static double sp(BuildContext context, double size) {
    final width = getWidth(context);
    return size * (width / 375);
  }
}