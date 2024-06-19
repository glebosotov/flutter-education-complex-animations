import 'dart:developer';

import 'package:flutter/material.dart';

class TweenPage extends StatefulWidget {
  const TweenPage({super.key});

  @override
  State<TweenPage> createState() => _TweenPageState();
}

class _TweenPageState extends State<TweenPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _offsetAnimation;
  late final Animation _curvedOffsetAnimation;

  final tween = Tween<Offset>(
    begin: const Offset(10, 0),
    end: const Offset(200, 0),
  );

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _offsetAnimation = _controller.drive(tween);

    final curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceIn,
    );

    _curvedOffsetAnimation = curvedAnimation.drive(tween);

    try {
      _controller.repeat(reverse: true);
    } on TickerCanceled {
      log('cancelled animation');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _offsetAnimation,
          builder: (context, _) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 200,
                child: Transform.translate(
                  offset: _offsetAnimation.value,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.redAccent,
                    ),
                    width: 100,
                  ),
                ),
              ),
              SizedBox(
                height: 200,
                child: Transform.translate(
                  offset: _curvedOffsetAnimation.value,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blueAccent,
                    ),
                    width: 100,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
