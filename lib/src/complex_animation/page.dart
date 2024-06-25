import 'package:flutter/material.dart';

import '../common/common.dart';
import '../implicit/implicit.dart';
import 'explicit.dart';
import 'shader.dart';

class ComplexAnimationPage extends StatelessWidget {
  const ComplexAnimationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
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
