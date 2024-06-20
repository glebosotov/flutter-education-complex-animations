import 'package:flutter/material.dart';
import 'package:interactive_animation_demo/complex_animation/explicit.dart';

import '../component.dart';
import 'implicit.dart';
import 'shader.dart';

class ComplexAnimationPage extends StatelessWidget {
  const ComplexAnimationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.loose,
          children: [
            AlignReturner(
              builder: (context, child, isLifted) => PickupScaler(
                defaultSize: const Size.square(Component.dimension),
                isLifted: isLifted,
                child: child,
              ),
              child: const SparkleAdder(
                child: Component(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
