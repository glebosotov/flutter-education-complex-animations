import 'package:flutter/material.dart';
import 'package:foil/foil.dart';

class SparkleAdder extends StatelessWidget {
  const SparkleAdder({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Foil(
      opacity: 0.2,
      child: child,
    );
  }
}
