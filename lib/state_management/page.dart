import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import '/state_management/bloc.dart';

class StateManagedAnimationPage extends StatefulWidget {
  const StateManagedAnimationPage({super.key});

  @override
  State<StateManagedAnimationPage> createState() =>
      _StateManagedAnimationPageState();
}

class _StateManagedAnimationPageState extends State<StateManagedAnimationPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AnimationBloc(),
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                margin: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: const Animation1(),
              ),
              Flexible(
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  margin: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: Animation2(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Animation1 extends StatefulWidget {
  const Animation1({super.key});

  @override
  State<Animation1> createState() => _Animation1State();
}

class _Animation1State extends State<Animation1>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _rotationAnimation;
  final tween = Tween(begin: 0.0, end: 2 * pi);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _rotationAnimation = _controller.drive(tween);

    final state = BlocProvider.of<AnimationBloc>(context).state;
    if (state is RunningAnimationState) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AnimationBloc, AnimationState>(
      listener: (BuildContext context, AnimationState state) {
        switch (state) {
          case RunningAnimationState():
            _controller.repeat();
          case StoppedAnimationState():
            _controller.stop();
        }
      },
      builder: (BuildContext context, AnimationState state) {
        return Row(
          children: [
            AnimatedBuilder(
              animation: _rotationAnimation,
              builder: (context, _) => Transform.rotate(
                angle: _rotationAnimation.value,
                child: const Icon(
                  Icons.hexagon_rounded,
                  size: 60,
                ),
              ),
            ),
            IconButton(
              onPressed: () => BlocProvider.of<AnimationBloc>(context).add(
                StartAnimationEvent(),
              ),
              icon: const Icon(Icons.play_arrow),
            ),
            IconButton(
              onPressed: () => BlocProvider.of<AnimationBloc>(context).add(
                StopAnimationEvent(),
              ),
              icon: const Icon(Icons.stop),
            ),
          ],
        );
      },
    );
  }
}

class Animation2 extends StatefulWidget {
  const Animation2({super.key});

  @override
  State<Animation2> createState() => _Animation2State();
}

class _Animation2State extends State<Animation2> {
  late VideoPlayerController _controller;
  static const url =
      'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4';

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.networkUrl(
      Uri.parse(url),
    );
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    final bloc = BlocProvider.of<AnimationBloc>(context);

    await _controller.initialize();
    await _controller.setLooping(true);
    await _controller.setVolume(0);
    setState(() {});
    if (bloc.state is RunningAnimationState) {
      _controller.play();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AnimationBloc, AnimationState>(
      listener: (BuildContext context, AnimationState state) {
        switch (state) {
          case RunningAnimationState():
            _controller.play();
          case StoppedAnimationState():
            _controller.pause();
        }
      },
      builder: (BuildContext context, AnimationState state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _controller.value.isInitialized
                ? Flexible(
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                  )
                : const SizedBox.shrink(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => BlocProvider.of<AnimationBloc>(context).add(
                    StartAnimationEvent(),
                  ),
                  icon: const Icon(Icons.play_arrow),
                ),
                IconButton(
                  onPressed: () => BlocProvider.of<AnimationBloc>(context).add(
                    StopAnimationEvent(),
                  ),
                  icon: const Icon(Icons.stop),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
