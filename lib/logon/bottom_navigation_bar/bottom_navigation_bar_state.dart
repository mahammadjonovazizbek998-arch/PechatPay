part of 'bottom_navigation_bar_cubit.dart';

@immutable
sealed class BottomNavigationBarState {
  final int currentIndex;
 const BottomNavigationBarState({required this.currentIndex});
}
final class BottomNavigationBarInitial extends BottomNavigationBarState {
  const BottomNavigationBarInitial({required super.currentIndex});
}
final class BottomNavigationBarFinish extends BottomNavigationBarState {
  const BottomNavigationBarFinish({required super.currentIndex});
}
