import 'package:flutter/material.dart';

import 'src/pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animations Demo',
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
          crossAxisCount: 3,
          children: const [
            _GridTile(
              name: 'Implicit',
              icon: Icons.double_arrow_sharp,
              destination: ImplicitPage(),
            ),
            _GridTile(
              name: 'Tween',
              icon: Icons.timeline,
              destination: TweenPage(),
            ),
            _GridTile(
              name: 'Physics',
              icon: Icons.wind_power,
              destination: PhysicsPage(),
            ),
            _GridTile(
              name: 'Complex',
              icon: Icons.generating_tokens_rounded,
              destination: ComplexAnimationPage(),
            ),
            _GridTile(
              name: 'Hero',
              icon: Icons.hexagon_rounded,
              destination: SimpleHero(),
            ),
            _GridTile(
              name: 'Complex Hero',
              icon: Icons.egg,
              destination: HeroPage(
                heroType: HeroType.from,
              ),
            ),
            _GridTile(
              name: 'Page Transition',
              icon: Icons.compare_arrows_sharp,
              destination: PageTransitionExample(),
            ),
            _GridTile(
              name: 'Rive',
              icon: Icons.animation,
              destination: RivePage(),
            ),
            _GridTile(
              name: 'Painter',
              icon: Icons.brush,
              destination: PainterPage(),
            ),
            _GridTile(
              name: 'State management',
              icon: Icons.star_rate,
              destination: StateManagedAnimationPage(),
            ),
          ],
        ),
      ),
    );
  }
}

class _GridTile extends StatelessWidget {
  const _GridTile({
    required this.name,
    required this.icon,
    required this.destination,
  });

  final String name;
  final IconData icon;
  final Widget destination;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute<dynamic>(
          builder: (_) => destination,
        ),
      ),
      child: Card.filled(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              icon,
              size: 56,
            ),
            Text(
              name,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
