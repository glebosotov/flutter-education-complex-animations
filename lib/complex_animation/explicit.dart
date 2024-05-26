import 'package:flutter/material.dart';

class AlignReturner extends StatefulWidget {
  final Widget child;

  const AlignReturner({
    required this.child,
    super.key,
  });

  @override
  State<AlignReturner> createState() => _AlignReturnerState();
}

class _AlignReturnerState extends State<AlignReturner> {
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
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
