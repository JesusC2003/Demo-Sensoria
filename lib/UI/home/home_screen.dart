import 'package:flutter/material.dart';


class TouchDetectorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TouchScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TouchScreen extends StatefulWidget {
  @override
  State<TouchScreen> createState() => _TouchScreenState();
}

class _TouchScreenState extends State<TouchScreen> {
  Offset? _position;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTapDown: (TapDownDetails details) {
          setState(() {
            _position = details.localPosition;
          });
        },
        child: Stack(
          children: [
            if (_position != null)
              Positioned(
                left: _position!.dx - 25,
                top: _position!.dy - 25,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.withOpacity(0.7),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            Center(
              child: Text(
                _position == null
                    ? 'Toca la pantalla'
                    : 'Toque en: (${_position!.dx.toStringAsFixed(1)}, ${_position!.dy.toStringAsFixed(1)})',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
