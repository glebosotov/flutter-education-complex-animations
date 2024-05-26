import 'dart:math';

import 'package:flutter/material.dart';
import 'package:foil/foil.dart';

class SimpleHero extends StatelessWidget {
  const SimpleHero({super.key});

  @override
  Widget build(BuildContext context) {
    final width =
        MediaQuery.sizeOf(context).width * (Random().nextDouble() * 0.2 + 0.1);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      persistentFooterButtons: [
        ElevatedButton(
          onPressed: () => Navigator.of(context).popUntil(
            (route) => route.isFirst,
          ),
          child: const Text('Back home'),
        ),
        ElevatedButton(
          onPressed: () => _onTap(context),
          child: const Text('Onwards'),
        ),
      ],
      body: SafeArea(
        child: Align(
          alignment: Alignment(
            Random().nextDouble(),
            Random().nextDouble(),
          ),
          child: SizedBox(
            width: width,
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
          builder: (_) => const SimpleHero(),
        ),
      );
}
