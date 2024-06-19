import 'package:flutter/material.dart';
import 'package:foil/foil.dart';

class SimpleHero extends StatelessWidget {
  const SimpleHero({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      persistentFooterButtons: [
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Back home'),
        ),
        ElevatedButton(
          onPressed: () => _onTap(context),
          child: const Text('Onwards'),
        ),
      ],
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.4,
            child: Hero(
              tag: 'foil_image',
              child: Foil(
                opacity: 0.1,
                child: Image.network(
                  'https://den-cards.pokellector.com/229/Gyarados-GX.CNV.112.19801.png',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTap(BuildContext context) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const SimpleHero2(),
        ),
      );
}

class SimpleHero2 extends StatelessWidget {
  const SimpleHero2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Back'),
        ),
      ],
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.9,
            child: Hero(
              tag: 'foil_image',
              child: Foil(
                opacity: 0.1,
                child: Image.network(
                  'https://den-cards.pokellector.com/229/Gyarados-GX.CNV.112.19801.png',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
