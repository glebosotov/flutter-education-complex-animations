import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class AlignReturner extends StatefulWidget {
  final Widget child;
  final Widget Function(BuildContext, Widget, bool) builder;

  const AlignReturner({
    required this.builder,
    required this.child,
    super.key,
  });

  @override
  State<AlignReturner> createState() => _AlignReturnerState();
}

class _AlignReturnerState extends State<AlignReturner>
    with SingleTickerProviderStateMixin {
  bool _isLifted = false;

  late final AnimationController _controller;
  Alignment _dragAlignment = Alignment.center;
  late Animation<Alignment> _animation;

  static const _spring = SpringDescription(
    mass: 30,
    stiffness: 1,
    damping: 1,
  );

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);

    _controller.addListener(
      () => setState(
        () => _dragAlignment = _animation.value,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _runAnimation(Offset pixelsPerSecond, Size size) {
    _animation = _controller.drive(
      AlignmentTween(
        begin: _dragAlignment,
        end: Alignment.center,
      ),
    );

    final unitsPerSecondX = pixelsPerSecond.dx / size.width;
    final unitsPerSecondY = pixelsPerSecond.dy / size.height;
    final unitsPerSecond = Offset(unitsPerSecondX, unitsPerSecondY);
    final unitVelocity = unitsPerSecond.distance;

    final simulation = SpringSimulation(_spring, 0, 1, -unitVelocity);

    try {
      _controller.animateWith(simulation);
    } on TickerCanceled catch (e) {
      debugPrint('Ticker canceled: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return GestureDetector(
      onPanDown: (_) {
        setState(() => _isLifted = true);
        _controller.stop();
      },
      onPanUpdate: (details) {
        setState(
          () => _dragAlignment += Alignment(
            details.delta.dx / (size.width / 2),
            details.delta.dy / (size.height / 2),
          ),
        );
      },
      onPanEnd: (details) {
        setState(() => _isLifted = false);
        _runAnimation(details.velocity.pixelsPerSecond, size);
      },
      child: Align(
        alignment: _dragAlignment,
        child: widget.builder(context, widget.child, _isLifted),
      ),
    );
  }
}
