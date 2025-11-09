// lib/ui/widgets/custom_button.dart
import 'package:flutter/material.dart';
import '../../core/utils/constants.dart';

/// Botón personalizado para los modos de la aplicación
class CustomModeButton extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final MaterialColor color;
  final VoidCallback onTap;

  const CustomModeButton({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: _getShadowColor(color),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
        child: Container(
          padding: const EdgeInsets.all(AppConstants.defaultPadding + 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
            gradient: LinearGradient(
              colors: [
                _getLightColor(color),
                _getVeryLightColor(color),
              ],
            ),
          ),
          child: Row(
            children: [
              _buildIcon(),
              const SizedBox(width: 20),
              Expanded(child: _buildContent()),
              _buildArrow(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _getMediumColor(color),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(
        icon,
        size: 40,
        color: color,
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color.shade700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade700,
          ),
        ),
      ],
    );
  }

  Widget _buildArrow() {
    return Icon(
      Icons.arrow_forward_ios,
      color: color,
    );
  }

  // Funciones auxiliares para obtener colores sin withOpacity
  Color _getShadowColor(MaterialColor color) {
    if (color == Colors.blue) return const Color(0x6642A5F5);
    if (color == Colors.amber) return const Color(0x66FFA726);
    if (color == Colors.deepPurple) return const Color(0x66AB47BC);
    return const Color(0x66000000);
  }

  Color _getLightColor(MaterialColor color) {
    if (color == Colors.blue) return const Color(0x1A42A5F5);
    if (color == Colors.amber) return const Color(0x1AFFA726);
    if (color == Colors.deepPurple) return const Color(0x1AAB47BC);
    return const Color(0x1A000000);
  }

  Color _getVeryLightColor(MaterialColor color) {
    if (color == Colors.blue) return const Color(0x0D42A5F5);
    if (color == Colors.amber) return const Color(0x0DFFA726);
    if (color == Colors.deepPurple) return const Color(0x0DAB47BC);
    return const Color(0x0D000000);
  }

  Color _getMediumColor(MaterialColor color) {
    if (color == Colors.blue) return const Color(0x3342A5F5);
    if (color == Colors.amber) return const Color(0x33FFA726);
    if (color == Colors.deepPurple) return const Color(0x33AB47BC);
    return const Color(0x33000000);
  }
}

/// Widget de información reutilizable
class InfoCard extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color backgroundColor;
  final Color textColor;

  const InfoCard({
    super.key,
    required this.text,
    this.icon = Icons.info_outline,
    this.backgroundColor = Colors.blue,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      decoration: BoxDecoration(
        color: _getBackgroundColorWithAlpha(backgroundColor),
        borderRadius: BorderRadius.circular(AppConstants.buttonBorderRadius),
        border: Border.all(
          color: _getBorderColorWithAlpha(backgroundColor),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: textColor,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getBackgroundColorWithAlpha(Color color) {
    if (color == Colors.blue) return const Color(0x33425CF5);
    if (color == Colors.amber) return const Color(0x33FFA726);
    if (color == Colors.deepPurple) return const Color(0x33AB47BC);
    // ignore: deprecated_member_use
    return Color.fromARGB(51, color.red, color.green, color.blue);
  }

  Color _getBorderColorWithAlpha(Color color) {
    if (color == Colors.blue) return const Color(0x66425CF5);
    if (color == Colors.amber) return const Color(0x66FFA726);
    if (color == Colors.deepPurple) return const Color(0x66AB47BC);
    // ignore: deprecated_member_use
    return Color.fromARGB(102, color.red, color.green, color.blue);
  }
}

/// Widget para estadísticas del juego
class StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const StatCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 32),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}