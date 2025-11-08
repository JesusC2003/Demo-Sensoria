import 'package:demostracion_aplicativo/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CapacitiveTouchDemoApp extends StatelessWidget {
  const CapacitiveTouchDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sensor Capacitivo de Contacto',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const TouchScreen(),
    );
  }
}