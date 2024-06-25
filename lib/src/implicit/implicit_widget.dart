import 'package:flutter/material.dart';

class PickupScaler extends StatelessWidget {
  const PickupScaler({
    required this.defaultSize,
    required this.isLifted,
    required this.child,
    super.key,
  });

  final Size defaultSize;
  final bool isLifted;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
      width: isLifted ? defaultSize.width * 0.95 : defaultSize.width,
      height: isLifted ? defaultSize.height * 0.95 : defaultSize.height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          if (isLifted)
            const BoxShadow(
              color: Colors.black45,
              blurRadius: 10,
              spreadRadius: 5,
            ),
        ],
      ),
      child: child,
    );
  }
}
