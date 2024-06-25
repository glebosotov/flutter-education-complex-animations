import 'package:flutter/material.dart';

class AlignReturner extends StatefulWidget {
  const AlignReturner({
    required this.builder,
    required this.child,
    super.key,
  });

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

  void _runAnimation(Offset pixelsPerSecond, Size size) {
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
