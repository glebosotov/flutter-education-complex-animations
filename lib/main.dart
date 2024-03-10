import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import 'package:motion_sensors/motion_sensors.dart';

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
      home: const AnimationDemo(),
    );
  }
}

class AnimationDemo extends StatefulWidget {
  const AnimationDemo({super.key});

  @override
  State<AnimationDemo> createState() => _AnimationDemoState();
}

class _AnimationDemoState extends State<AnimationDemo> {
  bool _showDebugData = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            _AnimatedComponent(_showDebugData),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton.icon(
                onPressed: () =>
                    setState(() => _showDebugData = !_showDebugData),
                icon: const Icon(Icons.visibility),
                label: const Text('Show Debug Data'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnimatedComponent extends StatefulWidget {
  final bool showDebugData;
  const _AnimatedComponent(this.showDebugData);

  @override
  State<_AnimatedComponent> createState() => _AnimatedComponentState();
}

class _AnimatedComponentState extends State<_AnimatedComponent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Alignment _dragAlignment = Alignment.center;
  late Animation<Alignment> _animation;

  void _runAnimation(Offset pixelsPerSecond, Size size) {
    _animation = _controller.drive(
      AlignmentTween(
        begin: _dragAlignment,
        end: Alignment.center,
      ),
    );

    final unitsPerSecondX = pixelsPerSecond.dx / size.width;
    final unitsPerSecondY = pixelsPerSecond.dy / size.height;
    final unitsPerSecond = Offset(unitsPerSecondX, unitsPerSecondY);
    final unitVelocity = unitsPerSecond.distance;

    const spring = SpringDescription(
      mass: 30,
      stiffness: 1,
      damping: 1,
    );

    final simulation = SpringSimulation(spring, 0, 1, -unitVelocity);

    _controller.animateWith(simulation);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    _controller.addListener(() {
      setState(() {
        _dragAlignment = _animation.value;
      });
    });

    _timer = Timer.periodic(const Duration(milliseconds: 7), (timer) {
      // Update rotation with inertia and friction
      setState(() {
        rotationX += angularVelocityX;
        rotationY += angularVelocityY;
        angularVelocityX *= 0.99; // Friction for x-axis
        angularVelocityY *= 0.99; // Friction for y-axis
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  double rotation = 0.0;
  double rotationX = 0.0;
  double rotationY = 0.0;
  double angularVelocityX = 0.0;
  double angularVelocityY = 0.0;
  late Timer _timer;

  bool isLifted = false;

  final Stream<AbsoluteOrientationEvent> stream =
      motionSensors.absoluteOrientation;
  static const scale = 2;
  static const hue = 0.8;
  static const saturation = 0.4;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // Rotation Y
    return Stack(
      children: [
        if (widget.showDebugData)
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              '''
                  Rotation X: ${rotationX.toStringAsFixed(2)}
                  Rotation Y: ${rotationY.toStringAsFixed(2)}
                  Angular Velocity X: ${angularVelocityX.toStringAsFixed(2)}
                  Angular Velocity Y: ${angularVelocityY.toStringAsFixed(2)}
                  Alignment: $_dragAlignment
                  isLifted: $isLifted
                ''',
            ),
          ),
        Positioned.fill(
          child: Align(
            alignment: _dragAlignment,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Tilt gradient
                StreamBuilder(
                  stream: stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) return const Text('ERROR');
                    final event =
                        snapshot.data ?? AbsoluteOrientationEvent(0, 0, 0);

                    // Lift-up effect
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 100),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: isLifted
                            ? const [
                                BoxShadow(
                                  color: Colors.black45,
                                  blurRadius: 10,
                                  spreadRadius: 5,
                                ),
                              ]
                            : null,
                      ),
                      width: isLifted ? 200 * 0.9 : 200 * 0.8,
                      height: isLifted ? 200 * 0.9 : 200 * 0.8,
                      child: ShaderMask(
                        shaderCallback: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            for (var value in event.values.map(_radianToDegree))
                              HSVColor.fromAHSV(
                                hue,
                                value * scale % 360,
                                saturation,
                                1.0,
                              ).toColor(),
                          ],
                        ).createShader,
                        child: GestureDetector(
                          onPanUpdate: (details) {
                            setState(() {
                              rotationY += details.delta.dx /
                                  80; // Adjust sensitivity as needed
                              rotationX += details.delta.dy /
                                  80; // Adjust sensitivity as needed
                            });
                            if (radiansToDegrees(rotationX) % 5 < 0.5 ||
                                radiansToDegrees(rotationY) % 5 < 0.5) {
                              HapticFeedback.lightImpact();
                            }
                          },
                          onPanEnd: (details) {
                            angularVelocityX = rotationY / 150;
                            angularVelocityY = rotationX / 150;
                          },
                          child: Transform.rotate(
                            angle: rotationX,
                            child: Transform.rotate(
                              angle: rotationY,
                              child: Container(
                                width: 200,
                                height: 200,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/go.png'),
                                    fit: BoxFit.cover,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                GestureDetector(
                  onPanDown: (details) {
                    isLifted = true;
                    HapticFeedback.lightImpact();
                    _controller.stop();
                  },
                  onPanUpdate: (details) {
                    setState(
                      () {
                        // rotationX = 0;
                        // rotationY = 0;
                        // angularVelocityX = 0;
                        // angularVelocityY = 0;

                        _dragAlignment += Alignment(
                          details.delta.dx / (size.width / 2),
                          details.delta.dy / (size.height / 2),
                        )..rotateAroundCenter(-rotationX, -rotationY);
                      },
                    );
                  },
                  onPanEnd: (details) {
                    isLifted = false;
                    _runAnimation(details.velocity.pixelsPerSecond, size);
                  },
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: const BoxDecoration(
                      // color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

double _radianToDegree(double radian) => (radian * 180 / math.pi) + 180;

extension AbsoluteOrientationEventX on AbsoluteOrientationEvent {
  List<double> get values => [yaw, pitch, roll];
}

extension RotationExtension on Alignment {
  /// Rotates the alignment around its center by the specified angles in radians for x and y axes.
  Alignment rotateAroundCenter(double radiansX, double radiansY) {
    final double cosThetaX = math.cos(radiansX);
    final double sinThetaX = math.sin(radiansX);

    final double rotatedX = x * cosThetaX - y * sinThetaX;
    final double rotatedYX = x * sinThetaX + y * cosThetaX;

    final double cosThetaY = math.cos(radiansY);
    final double sinThetaY = math.sin(radiansY);

    final double rotatedY = rotatedYX * cosThetaY - rotatedX * sinThetaY;
    final double rotatedXY = rotatedYX * sinThetaY + rotatedX * cosThetaY;

    return Alignment(rotatedY, rotatedXY);
  }
}

double radiansToDegrees(double radians) {
  return radians * (180 / math.pi);
}
