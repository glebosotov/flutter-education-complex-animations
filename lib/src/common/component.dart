import 'package:flutter/widgets.dart';

class Component extends StatelessWidget {
  const Component({super.key});

  static const dimension = 200.0;

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
