import 'dart:math';

import 'package:flutter/material.dart';

class MathPainter extends CustomPainter {
  MathPainter({required this.value, super.repaint});

  final double value;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(
        0,
        size.height / 2 + (size.height / 3 * sin(value)),
      );

    for (var i = 0.0; i <= 1.0; i += 0.01) {
      path.lineTo(
        i * size.width,
        size.height / 2 + (size.height / 3 * sin(i + value)),
      );
    }

    canvas.drawPath(
      path,
      Paint()
        ..color = Colors.black87
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 3.0
        ..style = PaintingStyle.stroke,
    );
  }

  @override
  bool shouldRepaint(covariant MathPainter oldDelegate) =>
      value != oldDelegate.value;
}
