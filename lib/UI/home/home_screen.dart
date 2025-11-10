import 'package:demostracion_aplicativo/UI/home/reflex_game_screen.dart';
import 'package:demostracion_aplicativo/UI/home/touch_canvas_screen.dart';
import 'package:demostracion_aplicativo/UI/home/touch_detector_screen.dart';
import 'package:demostracion_aplicativo/UI/widgets/custom_button.dart';
import 'package:demostracion_aplicativo/core/theme/app_theme.dart';
import 'package:demostracion_aplicativo/core/utils/constants.dart';
import 'package:flutter/material.dart';

/// Pantalla principal con el menú de modos
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE3F2FD),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: _buildModesList(context),
              ),
              _buildInfoSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(AppConstants.largePadding),
      child: Column(
        children: [
          const Icon(
            Icons.touch_app,
            size: 40,
            color: AppTheme.primaryBlue,
          ),
          const SizedBox(height: 16),
          Text(
            AppConstants.appTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppConstants.appSubtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModesList(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.defaultPadding,
      ),
      children: [
        CustomModeButton(
          title: AppConstants.touchDetectorTitle,
          description: AppConstants.touchDetectorDescription,
          icon: Icons.touch_app,
          color: Colors.blue,
          onTap: () => _navigateToMode(context, const TouchDetectorScreen()),
        ),
        const SizedBox(height: 16),
        CustomModeButton(
          title: AppConstants.reflexGameTitle,
          description: AppConstants.reflexGameDescription,
          icon: Icons.speed,
          color: Colors.amber,
          onTap: () => _navigateToMode(context, const ReflexGameScreen()),
        ),
        const SizedBox(height: 16),
        CustomModeButton(
          title: AppConstants.touchCanvasTitle,
          description: AppConstants.touchCanvasDescription,
          icon: Icons.brush,
          color: Colors.deepPurple,
          onTap: () => _navigateToMode(context, const TouchCanvasScreen()),
        ),
      ],
    );
  }

  Widget _buildInfoSection() {
    return Container(
      margin: const EdgeInsets.all(AppConstants.defaultPadding),
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
        border: Border.all(
          color: const Color(0xFF90CAF9),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.science,
                color: AppTheme.primaryBlue,
                size: 10,
              ),
              SizedBox(width: 8),
              Text(
                '¿Cómo funciona?',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryBlue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            AppConstants.capacitiveInfo,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey.shade700,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToMode(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }
}