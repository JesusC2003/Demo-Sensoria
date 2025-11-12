import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/constants.dart';
import '../../core/utils/responsive_utils.dart';

/// MODO 3: LIENZO TÁCTIL (RESPONSIVE)
class TouchCanvasScreen extends StatefulWidget {
  const TouchCanvasScreen({super.key});

  @override
  State<TouchCanvasScreen> createState() => _TouchCanvasScreenState();
}

class _TouchCanvasScreenState extends State<TouchCanvasScreen> {
  final List<DrawingStroke> _strokes = [];
  DrawingStroke? _currentStroke;

  final List<Color> _colors = [
    Colors.black,
    AppTheme.primaryBlue,
    AppTheme.errorRed,
    AppTheme.successGreen,
    AppTheme.secondaryPurple,
    AppTheme.accentAmber,
    Colors.pink,
    Colors.teal,
  ];

  Color _selectedColor = Colors.blue;
  double _strokeWidth = AppConstants.defaultStrokeWidth;

  void _clearCanvas() {
    setState(() {
      _strokes.clear();
      _currentStroke = null;
    });
  }

  void _undoLastStroke() {
    if (_strokes.isNotEmpty) {
      setState(() {
        _strokes.removeLast();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          AppConstants.touchCanvasTitle,
          style: TextStyle(
            fontSize: ResponsiveUtils.sp(context, 20),
          ),
        ),
        backgroundColor: AppTheme.secondaryPurple,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.undo,
              size: ResponsiveUtils.getIconSize(context, baseSize: 24),
            ),
            onPressed: _strokes.isEmpty ? null : _undoLastStroke,
            tooltip: 'Deshacer',
          ),
          IconButton(
            icon: Icon(
              Icons.delete_outline,
              size: ResponsiveUtils.getIconSize(context, baseSize: 24),
            ),
            onPressed: _strokes.isEmpty ? null : _clearCanvas,
            tooltip: 'Limpiar todo',
          ),
        ],
      ),
      body: Column(
        children: [
          _buildToolbar(),
          Expanded(child: _buildCanvas()),
          _buildInfoFooter(),
        ],
      ),
    );
  }

  Widget _buildToolbar() {
    final padding = ResponsiveUtils.getResponsivePadding(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: padding,
        vertical: ResponsiveUtils.getVerticalSpacing(context),
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildColorPicker(),
          SizedBox(height: ResponsiveUtils.getVerticalSpacing(context)),
          _buildStrokeWidthSlider(),
        ],
      ),
    );
  }

  Widget _buildColorPicker() {
    final iconSize = ResponsiveUtils.getIconSize(context, baseSize: 24);
    final colorSize = ResponsiveUtils.scaleWidth(context, 40);

    return Row(
      children: [
        Icon(
          Icons.palette,
          color: AppTheme.secondaryPurple,
          size: iconSize,
        ),
        SizedBox(width: ResponsiveUtils.getVerticalSpacing(context)),
        Expanded(
          child: SizedBox(
            height: colorSize,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _colors.length,
              itemBuilder: (context, index) {
                final color = _colors[index];
                final isSelected = color == _selectedColor;
                return GestureDetector(
                  onTap: () => setState(() => _selectedColor = color),
                  child: Container(
                    width: colorSize,
                    height: colorSize,
                    margin: EdgeInsets.only(
                      right: ResponsiveUtils.getVerticalSpacing(context, multiplier: 0.5),
                    ),
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected
                            ? AppTheme.secondaryPurple
                            : Colors.transparent,
                        width: 3,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: color.withOpacity(0.5),
                                blurRadius: 8,
                                spreadRadius: 2,
                              ),
                            ]
                          : null,
                    ),
                    child: isSelected
                        ? Icon(
                            Icons.check,
                            color: Colors.white,
                            size: colorSize * 0.5,
                          )
                        : null,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStrokeWidthSlider() {
    final iconSize = ResponsiveUtils.getIconSize(context, baseSize: 24);
    final previewSize = ResponsiveUtils.scaleWidth(context, 40);

    return Row(
      children: [
        Icon(
          Icons.line_weight,
          color: AppTheme.secondaryPurple,
          size: iconSize,
        ),
        SizedBox(width: ResponsiveUtils.getVerticalSpacing(context)),
        Expanded(
          child: Slider(
            value: _strokeWidth,
            min: AppConstants.minStrokeWidth,
            max: AppConstants.maxStrokeWidth,
            divisions: AppConstants.strokeWidthDivisions,
            label: _strokeWidth.toStringAsFixed(0),
            activeColor: AppTheme.secondaryPurple,
            onChanged: (value) => setState(() => _strokeWidth = value),
          ),
        ),
        Container(
          width: previewSize,
          height: previewSize,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              ResponsiveUtils.getBorderRadius(context, small: 6, medium: 8),
            ),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Center(
            child: Container(
              width: _strokeWidth,
              height: _strokeWidth,
              decoration: BoxDecoration(
                color: _selectedColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCanvas() {
    return Container(
      color: Colors.white,
      child: GestureDetector(
        onPanStart: (details) {
          setState(() {
            _currentStroke = DrawingStroke(
              points: [details.localPosition],
              color: _selectedColor,
              width: _strokeWidth,
            );
          });
        },
        onPanUpdate: (details) {
          setState(() {
            _currentStroke?.points.add(details.localPosition);
          });
        },
        onPanEnd: (details) {
          setState(() {
            if (_currentStroke != null) {
              _strokes.add(_currentStroke!);
              _currentStroke = null;
            }
          });
        },
        child: CustomPaint(
          size: Size.infinite,
          painter: DrawingPainter(
            strokes: _strokes,
            currentStroke: _currentStroke,
          ),
        ),
      ),
    );
  }

  Widget _buildInfoFooter() {
    final padding = ResponsiveUtils.getResponsivePadding(context);
    final iconSize = ResponsiveUtils.getIconSize(context, baseSize: 24);
    final textSize = ResponsiveUtils.sp(context, 13);

    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade50,
        border: Border(
          top: BorderSide(
            color: Colors.deepPurple.shade100,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: AppTheme.secondaryPurple,
            size: iconSize,
          ),
          SizedBox(width: ResponsiveUtils.getVerticalSpacing(context)),
          Expanded(
            child: Text(
              AppConstants.touchCanvasInfo,
              style: TextStyle(
                color: Colors.deepPurple.shade900,
                fontSize: textSize,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Clase que representa un trazo dibujado
class DrawingStroke {
  final List<Offset> points;
  final Color color;
  final double width;

  DrawingStroke({
    required this.points,
    required this.color,
    required this.width,
  });
}

/// CustomPainter que dibuja todos los trazos en el canvas
class DrawingPainter extends CustomPainter {
  final List<DrawingStroke> strokes;
  final DrawingStroke? currentStroke;

  DrawingPainter({
    required this.strokes,
    this.currentStroke,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final stroke in strokes) {
      _drawStroke(canvas, stroke);
    }

    if (currentStroke != null) {
      _drawStroke(canvas, currentStroke!);
    }
  }

  void _drawStroke(Canvas canvas, DrawingStroke stroke) {
    if (stroke.points.isEmpty) return;

    final paint = Paint()
      ..color = stroke.color
      ..strokeWidth = stroke.width
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    if (stroke.points.length == 1) {
      canvas.drawCircle(stroke.points[0], stroke.width / 2, paint);
      return;
    }

    final path = Path();
    path.moveTo(stroke.points[0].dx, stroke.points[0].dy);

    for (int i = 1; i < stroke.points.length; i++) {
      final p1 = stroke.points[i - 1];
      final p2 = stroke.points[i];

      final controlPoint = Offset(
        (p1.dx + p2.dx) / 2,
        (p1.dy + p2.dy) / 2,
      );

      path.quadraticBezierTo(
        p1.dx,
        p1.dy,
        controlPoint.dx,
        controlPoint.dy,
      );
    }

    final lastPoint = stroke.points.last;
    path.lineTo(lastPoint.dx, lastPoint.dy);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant DrawingPainter oldDelegate) {
    return oldDelegate.strokes != strokes ||
        oldDelegate.currentStroke != currentStroke;
  }
}