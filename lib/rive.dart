import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RivePage extends StatefulWidget {
  const RivePage({super.key});

  @override
  State<RivePage> createState() => _RivePageState();
}

class _RivePageState extends State<RivePage> {
  SMIBool? _clicked;

  void _onRiveInit(Artboard artboard) {
    final controller =
        StateMachineController.fromArtboard(artboard, 'State Machine 1');
    artboard.addController(controller!);
    _clicked = controller.findInput<bool>('Clicked') as SMIBool;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white54,
        backgroundColor: const Color(0xFF313131),
      ),
      backgroundColor: const Color(0xFF313131),
      body: SafeArea(
        child: RiveAnimation.asset(
          'assets/start.riv',
          onInit: _onRiveInit,
        ),
      ),
    );
  }
}
