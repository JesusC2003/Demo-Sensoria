// lib/core/utils/constants.dart

/// Constantes de la aplicación
class AppConstants {
  // Strings de la aplicación
  static const String appTitle = 'Sensor Capacitivo de Contacto';
  static const String appSubtitle = 'Explora cómo funciona la pantalla táctil';
  
  // Títulos de pantallas
  static const String touchDetectorTitle = 'Detector de Toques';
  static const String reflexGameTitle = 'Juego de Reflejos';
  static const String touchCanvasTitle = 'Lienzo Táctil';
  
  // Descripciones de modos
  static const String touchDetectorDescription = 
      'Visualiza la posición exacta de tus toques';
  static const String reflexGameDescription = 
      'Pon a prueba tu velocidad de respuesta';
  static const String touchCanvasDescription = 
      'Dibuja libremente con tus dedos';
  
  // Configuración del juego de reflejos
  static const int gameInitialTime = 30; // segundos
  static const int pointsPerHit = 10;
  static const int pointsPerMiss = 5;
  static const int targetTimeout = 2; // segundos
  static const int vibrationDuration = 200; // milisegundos
  
  // Configuración del detector de toques
  static const double touchCircleRadius = 25.0;
  static const int touchWaveCount = 3;
  static const double touchWaveSpacing = 15.0;
  
  // Configuración del lienzo táctil
  static const double minStrokeWidth = 2.0;
  static const double maxStrokeWidth = 20.0;
  static const double defaultStrokeWidth = 4.0;
  static const int strokeWidthDivisions = 9;
  
  // Márgenes y espaciados
  static const double defaultPadding = 16.0;
  static const double largePadding = 24.0;
  static const double cardBorderRadius = 20.0;
  static const double buttonBorderRadius = 12.0;
  
  // Información educativa
  static const String capacitiveInfo = 
      'Las pantallas capacitivas detectan el contacto mediante cambios en el '
      'campo eléctrico. Cuando tocas la pantalla con tu dedo, tu cuerpo actúa '
      'como conductor y altera la capacitancia en ese punto, permitiendo '
      'determinar la posición exacta del toque.';
  
  static const String touchDetectorInfo = 
      'Toca o arrastra tu dedo por la pantalla para ver cómo se detecta el contacto';
  
  static const String reflexGameInfo = 
      '• Toca los círculos amarillos lo más rápido posible\n'
      '• Cada acierto suma $pointsPerHit puntos\n'
      '• Si no tocas a tiempo, pierdes $pointsPerMiss puntos\n'
      '• El dispositivo vibrará cuando falles';
  
  static const String touchCanvasInfo = 
      'El sensor capacitivo rastrea el movimiento continuo de tu dedo, '
      'actualizando la posición múltiples veces por segundo';
}