import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class PhysicsPage extends StatefulWidget {
  const PhysicsPage({super.key});

  @override
  State<PhysicsPage> createState() => _PhysicsPageState();
}

class _PhysicsPageState extends State<PhysicsPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final GravitySimulation simulation;

  @override
  void initState() {
    super.initState();

    simulation = GravitySimulation(
      300, // acceleration
      0, // starting point
      500, // end point
      0, // starting velocity
    );

    controller = AnimationController(
      vsync: this,
      upperBound: 500,
    );

    controller.animateWith(simulation);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, _) => Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: controller.value,
                child: GestureDetector(
                  onTap: () {
                    controller
                      ..stop()
                      ..animateWith(simulation);
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.redAccent,
                    ),
                    height: 30,
                    width: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
