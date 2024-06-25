import 'package:flutter/material.dart';

class PageTransitionExample extends StatelessWidget {
  const PageTransitionExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemBuilder: (context, index) {
            final entries = transitions.entries.toList();
            final transition = entries[index];
            return ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(_createRoute(transition.value));
              },
              child: Text(transition.key),
            );
          },
          itemCount: transitions.length,
          shrinkWrap: true,
        ),
      ),
    );
  }
}

final transitions = <String,
    Widget Function(
  BuildContext,
  Animation<double>,
  Animation<double>,
  Widget,
)>{
  'Slide from top': (context, animation, secondaryAnimation, child) {
    const begin = Offset(0, 1);
    const end = Offset.zero;
    const curve = Curves.ease;

    final tween = Tween(begin: begin, end: end);
    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: curve,
    );

    return SlideTransition(
      position: tween.animate(curvedAnimation),
      child: child,
    );
  },
  'Comics rotation': (context, animation, secondaryAnimation, child) {
    const begin = 0.0;
    const end = 4.0;
    final tween = Tween(begin: begin, end: end);
    final rotationAnimation = animation.drive(tween);

    return RotationTransition(
      turns: rotationAnimation,
      child: child,
    );
  },
};

Route<dynamic> _createRoute(
  Widget Function(
    BuildContext,
    Animation<double>,
    Animation<double>,
    Widget,
  ) transitionsBuilder,
) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const Page2(),
    transitionsBuilder: transitionsBuilder,
    transitionDuration: const Duration(milliseconds: 600),
  );
}

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('Destination'),
      ),
    );
  }
}
