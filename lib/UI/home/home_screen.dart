import 'package:demostracion_aplicativo/UI/home/reflex_game_screen.dart';
import 'package:demostracion_aplicativo/UI/home/touch_canvas_screen.dart';
import 'package:demostracion_aplicativo/UI/home/touch_detector_screen.dart';
import 'package:demostracion_aplicativo/UI/widgets/custom_button.dart';
import 'package:demostracion_aplicativo/core/theme/app_theme.dart';
import 'package:demostracion_aplicativo/core/utils/constants.dart';
import 'package:demostracion_aplicativo/core/utils/responsive_utils.dart';
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
              _buildHeader(context),
              Expanded(
                child: _buildModesList(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final padding = ResponsiveUtils.getResponsivePadding(context);
    final iconSize = ResponsiveUtils.getIconSize(context, baseSize: 40);
    final titleSize = ResponsiveUtils.sp(context, 28);
    final subtitleSize = ResponsiveUtils.sp(context, 16);
    final spacing = ResponsiveUtils.getVerticalSpacing(context);

    return Container(
      padding: EdgeInsets.all(padding),
      child: Column(
        children: [
          Icon(
            Icons.touch_app,
            size: iconSize,
            color: AppTheme.primaryBlue,
          ),
          SizedBox(height: spacing),
          Text(
            AppConstants.appTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: titleSize,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
          SizedBox(height: spacing * 0.5),
          Text(
            AppConstants.appSubtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: subtitleSize,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModesList(BuildContext context) {
    final padding = ResponsiveUtils.getResponsivePadding(context);
    final spacing = ResponsiveUtils.getVerticalSpacing(context);

    return ListView(
      padding: EdgeInsets.symmetric(horizontal: padding),
      children: [
        CustomModeButton(
          title: AppConstants.touchDetectorTitle,
          description: AppConstants.touchDetectorDescription,
          icon: Icons.touch_app,
          color: Colors.blue,
          onTap: () => _navigateToMode(context, const TouchDetectorScreen()),
        ),
        SizedBox(height: spacing),
        CustomModeButton(
          title: AppConstants.reflexGameTitle,
          description: AppConstants.reflexGameDescription,
          icon: Icons.speed,
          color: Colors.amber,
          onTap: () => _navigateToMode(context, const ReflexGameScreen()),
        ),
        SizedBox(height: spacing),
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

  Widget _buildInfoSection(BuildContext context) {
    final padding = ResponsiveUtils.getResponsivePadding(context);
    final borderRadius = ResponsiveUtils.getBorderRadius(context);
    final iconSize = ResponsiveUtils.getIconSize(context, baseSize: 20);
    final titleSize = ResponsiveUtils.sp(context, 16);
    final textSize = ResponsiveUtils.sp(context, 14);
    final spacing = ResponsiveUtils.getVerticalSpacing(context);

    return Container(
      margin: EdgeInsets.all(padding),
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: const Color(0xFF90CAF9),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.science,
                color: AppTheme.primaryBlue,
                size: iconSize,
              ),
              SizedBox(width: spacing * 0.5),
              Text(
                '¿Cómo funciona?',
                style: TextStyle(
                  fontSize: titleSize,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryBlue,
                ),
              ),
            ],
          ),
          SizedBox(height: spacing),
          Text(
            AppConstants.capacitiveInfo,
            style: TextStyle(
              fontSize: textSize,
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