import 'dart:math';

import 'package:flutter/material.dart';

class PainterPage extends StatefulWidget {
  const PainterPage({super.key});

  @override
  State<PainterPage> createState() => _PainterPageState();
}

class _PainterPageState extends State<PainterPage>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  );
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animation = Tween<double>(begin: 0, end: 2 * pi).animate(_controller);
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _animation,
        builder: (context, _) {
          return CustomPaint(
            size: MediaQuery.sizeOf(context),
            painter: MathPainter(value: _animation.value),
          );
        },
      ),
    );
  }
}

class MathPainter extends CustomPainter {
  final double value;

  MathPainter({super.repaint, required this.value});

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
