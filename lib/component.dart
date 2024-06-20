import 'package:flutter/widgets.dart';

class Component extends StatelessWidget {
  static const dimension = 200.0;

  const Component({super.key});

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
