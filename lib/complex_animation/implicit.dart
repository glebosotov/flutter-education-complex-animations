import 'package:flutter/material.dart';

class PickupScaler extends StatefulWidget {
  final Size defaultSize;
  final Widget child;

  const PickupScaler({
    required this.defaultSize,
    required this.child,
    super.key,
  });

  @override
  State<PickupScaler> createState() => _PickupScalerState();
}

class _PickupScalerState extends State<PickupScaler> {
  bool _isLifted = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (_) {
        setState(() => _isLifted = true);
      },
      onPanEnd: (_) {
        setState(() => _isLifted = false);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
        width: _isLifted
            ? widget.defaultSize.width * 0.95
            : widget.defaultSize.width,
        height: _isLifted
            ? widget.defaultSize.height * 0.95
            : widget.defaultSize.height,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            if (_isLifted)
              const BoxShadow(
                color: Colors.black45,
                blurRadius: 10,
                spreadRadius: 5,
              ),
          ],
        ),
        child: widget.child,
      ),
    );
  }
}
