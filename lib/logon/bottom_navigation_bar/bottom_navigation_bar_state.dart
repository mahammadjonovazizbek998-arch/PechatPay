part of 'bottom_navigation_bar_cubit.dart';

enum AppProfilPeges { profil, myAccount }

@immutable
sealed class BottomNavigationBarState {
  final int currentIndex;
  final AppProfilPeges appProfilPeges;

  const BottomNavigationBarState({
    required this.currentIndex,
    required this.appProfilPeges,
  });
}

final class BottomNavigationBarInitial extends BottomNavigationBarState {
  const BottomNavigationBarInitial({
    required super.currentIndex,
    required super.appProfilPeges,
  });
}

final class BottomNavigationBarFinish extends BottomNavigationBarState {
  const BottomNavigationBarFinish({
    required super.currentIndex,
    required super.appProfilPeges,
  });
}
