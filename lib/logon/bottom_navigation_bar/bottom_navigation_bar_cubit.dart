import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';


part 'bottom_navigation_bar_state.dart';

class BottomNavigationBarCubit extends Cubit<BottomNavigationBarState> {
  BottomNavigationBarCubit()
    : super(BottomNavigationBarInitial(currentIndex: 0));

  void onTap(int index) {
    emit(BottomNavigationBarFinish(currentIndex: index));
  }
}
