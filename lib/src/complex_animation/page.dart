import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../common/common.dart';
import '../implicit/implicit.dart';
import 'explicit.dart';

class ComplexAnimationPage extends StatefulWidget {
  const ComplexAnimationPage({super.key});

  @override
  State<ComplexAnimationPage> createState() => _ComplexAnimationPageState();
}

class _ComplexAnimationPageState extends State<ComplexAnimationPage> {
  ComplexAnimationType _type = ComplexAnimationType.curve;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: CupertinoSlidingSegmentedControl<ComplexAnimationType>(
                groupValue: _type,
                onValueChanged: (ComplexAnimationType? value) => setState(
                  () => _type = value ?? _type,
                ),
                children: const {
                  ComplexAnimationType.curve: Text('Curve'),
                  ComplexAnimationType.physical: Text('Physical'),
                },
              ),
            ),
            AlignReturner(
              type: _type,
              builder: (context, child, isLifted) => PickupScaler(
                defaultSize: const Size.square(Component.dimension),
                isLifted: isLifted,
                child: child,
              ),
              child: const Component(),
            ),
          ],
        ),
      ),
    );
  }
}
