import 'package:bloc/bloc.dart';

/// Event
sealed class AnimationEvent {}

final class StartAnimationEvent extends AnimationEvent {}

final class StopAnimationEvent extends AnimationEvent {}

/// State
sealed class AnimationState {}

final class StoppedAnimationState extends AnimationState {}

final class RunningAnimationState extends AnimationState {}

class AnimationBloc extends Bloc<AnimationEvent, AnimationState> {
  AnimationBloc() : super(RunningAnimationState()) {
    on<AnimationEvent>(_handleEvent);
  }

  void _handleEvent(
    AnimationEvent event,
    Emitter<AnimationState> emit,
  ) =>
      switch (event) {
        StartAnimationEvent() => _handleStartEvent(event, emit),
        StopAnimationEvent() => _handleStopEvent(event, emit),
      };

  void _handleStartEvent(
    StartAnimationEvent event,
    Emitter<AnimationState> emit,
  ) =>
      emit(RunningAnimationState());

  void _handleStopEvent(
    StopAnimationEvent event,
    Emitter<AnimationState> emit,
  ) =>
      emit(StoppedAnimationState());
}
