import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math';

class Clock extends StatefulWidget {
  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  double angle = -90;
  Timer _timer;
  @override
  void initState() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        angle += 45;
        angle = angle % 360;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        height: 100,
        width: 100,
        child: CustomPaint(
          painter: ClockPainter(angle),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  final double angle;

  ClockPainter(this.angle);
  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);
    var outlineBrush = Paint()
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    var timeBrush = Paint()
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    var hourX = centerX + radius / 1.5 * cos(angle * pi / 180);
    var hourY = centerX + radius / 1.5 * sin(angle * pi / 180);
    canvas.drawLine(center, Offset(hourX, hourY), timeBrush);
    canvas.drawCircle(
        center, radius - outlineBrush.strokeWidth / 2, outlineBrush);
    canvas.drawCircle(center, 5, outlineBrush..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return true;
  }
}
