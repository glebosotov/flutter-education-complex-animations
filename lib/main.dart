import 'package:flutter/material.dart';
import 'package:interactive_animation_demo/hero/hero.dart';

import 'complex_animation/complex_animation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animations'),
      ),
      body: SafeArea(
        child: GridView.count(
          padding: const EdgeInsets.all(8),
          crossAxisCount: 2,
          children: [
            _GridTile(
              name: 'Complex',
              icon: Icons.generating_tokens_rounded,
              destination: MaterialPageRoute(
                builder: (_) => const ComplexAnimationPage(),
              ),
            ),
            _GridTile(
              name: 'Hero',
              icon: Icons.hexagon_rounded,
              destination: MaterialPageRoute(
                builder: (_) => const SimpleHero(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GridTile extends StatelessWidget {
  final String name;
  final IconData icon;
  final Route destination;

  const _GridTile({
    required this.name,
    required this.icon,
    required this.destination,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(destination),
      child: Card.filled(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              icon,
              size: 60,
            ),
            Text(
              name,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
}
