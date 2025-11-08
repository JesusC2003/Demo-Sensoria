// lib/ui/home/touch_detector_screen.dart
import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/constants.dart';
import '../widgets/custom_button.dart';

/// MODO 1: DETECTOR DE TOQUES
/// 
/// Este modo demuestra cómo el sensor capacitivo detecta la posición exacta
/// del contacto en la pantalla.
class TouchDetectorScreen extends StatefulWidget {
  const TouchDetectorScreen({super.key});

  @override
  State<TouchDetectorScreen> createState() => _TouchDetectorScreenState();
}

class _TouchDetectorScreenState extends State<TouchDetectorScreen> {
  Offset? _touchPosition;
  int _touchCount = 0;
  bool _isTouching = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: AppBar(
        title: Text(AppConstants.touchDetectorTitle),
        backgroundColor: AppTheme.primaryBlue,
        elevation: 0,
      ),
      body: Stack(
        children: [
          _buildTouchArea(size),
          _buildInfoPanel(),
          _buildInstructions(),
        ],
      ),
    );
  }

  Widget _buildTouchArea(Size size) {
    return GestureDetector(
      onPanDown: (details) {
        setState(() {
          _touchPosition = details.localPosition;
          _touchCount++;
          _isTouching = true;
        });
      },
      onPanUpdate: (details) {
        setState(() {
          _touchPosition = details.localPosition;
        });
      },
      onPanEnd: (details) {
        setState(() {
          _isTouching = false;
        });
      },
      child: Container(
        width: size.width,
        height: size.height,
        color: Colors.transparent,
        child: CustomPaint(
          painter: TouchVisualizerPainter(
            touchPosition: _touchPosition,
            isTouching: _isTouching,
          ),
        ),
      ),
    );
  }

  Widget _buildInfoPanel() {
    return Positioned(
      top: 20,
      left: 20,
      right: 20,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.7),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppTheme.primaryBlue.withOpacity(0.5),
            width: 2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  _isTouching ? Icons.touch_app : Icons.touch_app_outlined,
                  color: _isTouching ? AppTheme.primaryBlue : Colors.grey,
                  size: 30,
                ),
                const SizedBox(width: 10),
                Text(
                  _isTouching ? 'Detectando contacto...' : 'Esperando contacto',
                  style: TextStyle(
                    color: _isTouching ? AppTheme.primaryBlue : Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _InfoRow(
              label: 'Posición X:',
              value: _touchPosition != null
                  ? '${_touchPosition!.dx.toStringAsFixed(1)} px'
                  : '---',
            ),
            const SizedBox(height: 8),
            _InfoRow(
              label: 'Posición Y:',
              value: _touchPosition != null
                  ? '${_touchPosition!.dy.toStringAsFixed(1)} px'
                  : '---',
            ),
            const SizedBox(height: 8),
            _InfoRow(
              label: 'Total de toques:',
              value: '$_touchCount',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInstructions() {
    return Positioned(
      bottom: 30,
      left: 20,
      right: 20,
      child: InfoCard(
        text: AppConstants.touchDetectorInfo,
        backgroundColor: AppTheme.primaryBlue,
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

/// CustomPainter para visualizar el punto de contacto
class TouchVisualizerPainter extends CustomPainter {
  final Offset? touchPosition;
  final bool isTouching;

  TouchVisualizerPainter({
    required this.touchPosition,
    required this.isTouching,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (touchPosition == null) return;

    // Dibuja ondas expansivas cuando hay contacto activo
    if (isTouching) {
      for (int i = 0; i < AppConstants.touchWaveCount; i++) {
        final wavePaint = Paint()
          ..color = AppTheme.primaryBlue.withOpacity(0.3 - (i * 0.1))
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;

        canvas.drawCircle(
          touchPosition!,
          AppConstants.touchCircleRadius + (i * AppConstants.touchWaveSpacing),
          wavePaint,
        );
      }
    }

    // Dibuja el círculo principal de contacto
    final touchPaint = Paint()
      ..color = isTouching 
          ? AppTheme.primaryBlue 
          : AppTheme.primaryBlue.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      touchPosition!, 
      AppConstants.touchCircleRadius, 
      touchPaint,
    );

    // Dibuja el borde del círculo
    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    canvas.drawCircle(
      touchPosition!, 
      AppConstants.touchCircleRadius, 
      borderPaint,
    );

    // Dibuja un punto central
    final centerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(touchPosition!, 5, centerPaint);
  }

  @override
  bool shouldRepaint(covariant TouchVisualizerPainter oldDelegate) {
    return oldDelegate.touchPosition != touchPosition ||
        oldDelegate.isTouching != isTouching;
  }
}