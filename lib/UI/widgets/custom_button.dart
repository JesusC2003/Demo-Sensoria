// lib/ui/widgets/custom_button.dart
import 'package:flutter/material.dart';
import '../../core/utils/constants.dart';
import '../../core/utils/responsive_utils.dart';

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
    final borderRadius = ResponsiveUtils.getBorderRadius(context);
    final padding = ResponsiveUtils.getResponsivePadding(context);

    return Card(
      elevation: 8,
      shadowColor: _getShadowColor(color),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          padding: EdgeInsets.all(padding + 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            gradient: LinearGradient(
              colors: [
                _getLightColor(color),
                _getVeryLightColor(color),
              ],
            ),
          ),
          child: Row(
            children: [
              _buildIcon(context),
              SizedBox(width: ResponsiveUtils.getVerticalSpacing(context)),
              Expanded(child: _buildContent(context)),
              _buildArrow(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    final iconSize = ResponsiveUtils.getIconSize(context, baseSize: 40);
    final padding = ResponsiveUtils.getResponsivePadding(context);
    final borderRadius = ResponsiveUtils.getBorderRadius(context, small: 12, medium: 16);

    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: _getMediumColor(color),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Icon(
        icon,
        size: iconSize,
        color: color,
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final titleSize = ResponsiveUtils.sp(context, 18);
    final descriptionSize = ResponsiveUtils.sp(context, 14);
    final spacing = ResponsiveUtils.getVerticalSpacing(context, multiplier: 0.3);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: titleSize,
            fontWeight: FontWeight.bold,
            color: color.shade700,
          ),
        ),
        SizedBox(height: spacing),
        Text(
          description,
          style: TextStyle(
            fontSize: descriptionSize,
            color: Colors.grey.shade700,
          ),
        ),
      ],
    );
  }

  Widget _buildArrow(BuildContext context) {
    final iconSize = ResponsiveUtils.getIconSize(context, baseSize: 24);

    return Icon(
      Icons.arrow_forward_ios,
      color: color,
      size: iconSize,
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
    final padding = ResponsiveUtils.getResponsivePadding(context);
    final borderRadius = ResponsiveUtils.getBorderRadius(context, small: 8, medium: 12);
    final iconSize = ResponsiveUtils.getIconSize(context, baseSize: 24);
    final textSize = ResponsiveUtils.sp(context, 14);
    final spacing = ResponsiveUtils.getVerticalSpacing(context);

    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: _getBackgroundColorWithAlpha(backgroundColor),
        borderRadius: BorderRadius.circular(borderRadius),
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
            size: iconSize,
          ),
          SizedBox(width: spacing),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: textSize,
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
    final iconSize = ResponsiveUtils.getIconSize(context, baseSize: 32);
    final labelSize = ResponsiveUtils.sp(context, 14);
    final valueSize = ResponsiveUtils.sp(context, 24);
    final spacing = ResponsiveUtils.getVerticalSpacing(context, multiplier: 0.5);

    return Column(
      children: [
        Icon(icon, color: color, size: iconSize),
        SizedBox(height: spacing),
        Text(
          label,
          style: TextStyle(
            fontSize: labelSize,
            color: Colors.grey.shade600,
          ),
        ),
        SizedBox(height: spacing * 0.5),
        Text(
          value,
          style: TextStyle(
            fontSize: valueSize,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}