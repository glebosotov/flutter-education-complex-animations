import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

enum ComplexAnimationType { physical, curve }

class AlignReturner extends StatefulWidget {
  const AlignReturner({
    required this.type,
    required this.child,
    required this.builder,
    super.key,
  });

  final ComplexAnimationType type;
  final Widget child;
  // ignore: avoid_positional_boolean_parameters
  final Widget Function(BuildContext, Widget, bool) builder;

  @override
  State<AlignReturner> createState() => _AlignReturnerState();
}

class _AlignReturnerState extends State<AlignReturner>
    with SingleTickerProviderStateMixin {
  bool _isLifted = false;

  late final AnimationController _controller;
  Alignment _dragAlignment = Alignment.center;
  late Animation<Alignment> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

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

  void _runCurvedAnimation(Offset pixelsPerSecond, Size size) {
    _animation = _controller.drive(
      AlignmentTween(
        begin: _dragAlignment,
        end: Alignment.center,
      ),
    );

    try {
      _controller.forward(from: 0);
    } on TickerCanceled catch (e) {
      debugPrint('Ticker canceled: $e');
    }
  }

  void _runPhysicalAnimation(Offset pixelsPerSecond, Size size) {
    _animation = _controller.drive(
      AlignmentTween(
        begin: _dragAlignment,
        end: Alignment.center,
      ),
    );

    // Calculate the velocity relative to the unit interval, [0,1],
    // used by the animation controller.
    final unitsPerSecondX = pixelsPerSecond.dx / size.width;
    final unitsPerSecondY = pixelsPerSecond.dy / size.height;
    final unitsPerSecond = Offset(unitsPerSecondX, unitsPerSecondY);
    final unitVelocity = unitsPerSecond.distance;

    const spring = SpringDescription(
      mass: 30,
      stiffness: 1,
      damping: 1,
    );

    final simulation = SpringSimulation(spring, 0, 1, -unitVelocity);

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
        final velocity = details.velocity.pixelsPerSecond;
        return switch (widget.type) {
          ComplexAnimationType.curve => _runCurvedAnimation(velocity, size),
          ComplexAnimationType.physical =>
            _runPhysicalAnimation(velocity, size),
        };
      },
      child: Align(
        alignment: _dragAlignment,
        child: widget.builder(context, widget.child, _isLifted),
      ),
    );
  }
}
