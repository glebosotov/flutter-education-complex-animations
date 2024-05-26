import 'package:flutter/material.dart';
import 'package:interactive_animation_demo/complex_animation/explicit.dart';

import 'implicit.dart';

class ComplexAnimationPage extends StatelessWidget {
  const ComplexAnimationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: AlignReturner(
                child: PickupScaler(
                  defaultSize: Size.square(_Component.dimension),
                  child: _Component(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Component extends StatelessWidget {
  static const dimension = 200.0;

  const _Component({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: dimension,
      height: dimension,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/go.png'),
          fit: BoxFit.cover,
        ),
        shape: BoxShape.circle,
      ),
    );
  }
}
