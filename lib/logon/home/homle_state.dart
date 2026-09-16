part of 'homle_cubit.dart';

@immutable
sealed class HomleState {
  final int currentIndex;

  const HomleState({required this.currentIndex});
}

final class HomleInitial extends HomleState {
  const HomleInitial({required super.currentIndex});
}

final class HomleFinish extends HomleState {
  const HomleFinish({required super.currentIndex});
}

final class HomeLoding extends HomleState {
  const HomeLoding({required super.currentIndex});
}
final class HomeError extends HomleState{
  const HomeError({required super.currentIndex});
}