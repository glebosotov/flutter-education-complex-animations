import 'package:flutter/material.dart';
import 'package:interactive_animation_demo/complex_animation/implicit.dart';
import 'package:interactive_animation_demo/component.dart';

class ImplicitPage extends StatefulWidget {
  const ImplicitPage({super.key});

  @override
  State<ImplicitPage> createState() => _ImplicitPageState();
}

class _ImplicitPageState extends State<ImplicitPage> {
  bool _isLifted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: GestureDetector(
            onTapDown: (_) => setState(() => _isLifted = true),
            onTapUp: (_) => setState(() => _isLifted = false),
            child: PickupScaler(
              defaultSize: Size.fromWidth(
                MediaQuery.sizeOf(context).width * 0.5,
              ),
              isLifted: _isLifted,
              child: const Component(),
            ),
          ),
        ),
      ),
    );
  }
}
