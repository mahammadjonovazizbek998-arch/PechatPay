import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

part 'bottom_navigation_bar_state.dart';

class BottomNavigationBarCubit extends Cubit<BottomNavigationBarState> {
  BottomNavigationBarCubit()
    : super(
        BottomNavigationBarInitial(
          currentIndex: 0,
          appProfilPeges: AppProfilPeges.profil,
        ),
      );

  void onTap(int index, AppProfilPeges appPeges) {
    emit(
      BottomNavigationBarFinish(currentIndex: index, appProfilPeges: appPeges),
    );
  }
}
