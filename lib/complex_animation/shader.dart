import 'package:flutter/material.dart';
import 'package:foil/foil.dart';

class SparkleAdder extends StatelessWidget {
  final Widget child;

  const SparkleAdder({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Foil(
      opacity: 0.2,
      child: child,
    );
  }
}
