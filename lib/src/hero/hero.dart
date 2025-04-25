import 'package:flutter/material.dart';

class SimpleHero extends StatelessWidget {
  const SimpleHero({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
              child: Image.network(
                'https://avatars.mds.yandex.net/i?id=5497c7dc23d8acedf62e168321c645a8_l-5220447-images-thumbs&n=13',
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTap(BuildContext context) => Navigator.of(context).push(
        MaterialPageRoute<dynamic>(
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
              child: Image.network(
                'https://avatars.mds.yandex.net/i?id=5497c7dc23d8acedf62e168321c645a8_l-5220447-images-thumbs&n=13',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
