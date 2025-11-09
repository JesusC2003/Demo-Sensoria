// lib/ui/home/reflex_game_screen.dart
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/constants.dart';
import '../widgets/custom_button.dart';

/// MODO 2: JUEGO DE REFLEJOS
class ReflexGameScreen extends StatefulWidget {
  const ReflexGameScreen({super.key});

  @override
  State<ReflexGameScreen> createState() => _ReflexGameScreenState();
}

class _ReflexGameScreenState extends State<ReflexGameScreen> {
  Offset? _targetPosition;
  int _score = 0;
  int _timeLeft = AppConstants.gameInitialTime;
  bool _isPlaying = false;
  Timer? _gameTimer;
  Timer? _targetTimer;
  final Random _random = Random();
  static const double _targetRadius = 40;

  @override
  void dispose() {
    _gameTimer?.cancel();
    _targetTimer?.cancel();
    super.dispose();
  }

  void _startGame() {
    setState(() {
      _score = 0;
      _timeLeft = AppConstants.gameInitialTime;
      _isPlaying = true;
    });

    _generateNewTarget();

    _gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _timeLeft--;
        if (_timeLeft <= 0) {
          _endGame();
        }
      });
    });
  }

  void _generateNewTarget() {
    _targetTimer?.cancel();

    final size = MediaQuery.of(context).size;
    const margin = 80.0;

    setState(() {
      _targetPosition = Offset(
        margin + _random.nextDouble() * (size.width - 2 * margin),
        margin + 150 + _random.nextDouble() * (size.height - 2 * margin - 200),
      );
    });

    _targetTimer = Timer(
      Duration(seconds: AppConstants.targetTimeout),
      () {
        if (_isPlaying) {
          _missTarget();
        }
      },
    );
  }

  void _hitTarget() {
    setState(() {
      _score += AppConstants.pointsPerHit;
    });
    _generateNewTarget();
  }

  void _missTarget() async {
    if (await Vibration.hasVibrator()) {
      Vibration.vibrate(duration: AppConstants.vibrationDuration);
    }

    setState(() {
      if (_score > 0) _score -= AppConstants.pointsPerMiss;
    });
    _generateNewTarget();
  }

  void _endGame() {
    _gameTimer?.cancel();
    _targetTimer?.cancel();
    setState(() {
      _isPlaying = false;
      _targetPosition = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text(AppConstants.reflexGameTitle),
        backgroundColor: AppTheme.accentAmber,
        elevation: 0,
      ),
      body: Stack(
        children: [
          if (_isPlaying && _targetPosition != null) _buildGameArea(),
          _buildStatsPanel(),
          if (!_isPlaying) _buildStartScreen(),
        ],
      ),
    );
  }

  Widget _buildGameArea() {
    return GestureDetector(
      onTapDown: (details) {
        final distance = (details.localPosition - _targetPosition!).distance;
        if (distance <= _targetRadius) {
          _hitTarget();
        }
      },
      child: Container(
        color: Colors.transparent,
        child: CustomPaint(
          size: MediaQuery.of(context).size,
          painter: TargetPainter(
            position: _targetPosition!,
            radius: _targetRadius,
          ),
        ),
      ),
    );
  }

  Widget _buildStatsPanel() {
    return Positioned(
      top: 20,
      left: 20,
      right: 20,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            StatCard(
              icon: Icons.emoji_events,
              label: 'Puntos',
              value: '$_score',
              color: AppTheme.accentAmber,
            ),
            StatCard(
              icon: Icons.timer,
              label: 'Tiempo',
              value: '$_timeLeft s',
              color: _timeLeft <= 10 ? AppTheme.errorRed : AppTheme.primaryBlue,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStartScreen() {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(40),
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.speed,
              size: 80,
              color: AppTheme.accentAmber,
            ),
            const SizedBox(height: 20),
            Text(
              _score > 0 ? '¡Juego Terminado!' : 'Juego de Reflejos',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            if (_score > 0) ...[
              const SizedBox(height: 20),
              Text(
                'Puntuación Final',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '$_score',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.accentAmber,
                ),
              ),
            ],
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _startGame,
              icon: Icon(_score > 0 ? Icons.refresh : Icons.play_arrow),
              label: Text(_score > 0 ? 'Jugar de Nuevo' : 'Comenzar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.accentAmber,
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            _buildInstructions(),
          ],
        ),
      ),
    );
  }

  Widget _buildInstructions() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.lightbulb_outline,
                color: Colors.blue.shade700,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'Cómo Jugar',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            AppConstants.reflexGameInfo,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

/// CustomPainter para dibujar el objetivo
class TargetPainter extends CustomPainter {
  final Offset position;
  final double radius;

  TargetPainter({
    required this.position,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Dibuja anillos concéntricos
    for (int i = 3; i > 0; i--) {
      final ringPaint = Paint()
        ..color = AppTheme.accentAmber.withOpacity(0.3 * (4 - i) / 3)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(position, radius * (i / 2), ringPaint);
    }

    // Dibuja el círculo principal
    final targetPaint = Paint()
      ..color = AppTheme.accentAmber
      ..style = PaintingStyle.fill;

    canvas.drawCircle(position, radius, targetPaint);

    // Dibuja el borde
    final borderPaint = Paint()
      ..color = Colors.amber.shade800
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    canvas.drawCircle(position, radius, borderPaint);

    // Dibuja el centro
    final centerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(position, radius * 0.3, centerPaint);
  }

  @override
  bool shouldRepaint(covariant TargetPainter oldDelegate) {
    return oldDelegate.position != position || oldDelegate.radius != radius;
  }
}