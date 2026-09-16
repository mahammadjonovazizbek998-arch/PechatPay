import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:pechat_pay/data/repository/auth.dart';
import 'package:pechat_pay/data/theme_model/theme_model.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial()) {
    getSheredPreferences();
  }

  AuthRepository authRepository = AuthRepository();

  //theme ni xotridan o'qish
  Future<void> getSheredPreferences() async {
    emit(ThemeLoding(theme: state.theme));
    ThemeModel themeModel = await authRepository.getSharePreferences();
    emit(ThemeFinish(theme: themeModel.theme));
  }

  //them ni xotriraga yozish
  Future<void> setSharedPrefences() async {
    emit(ThemeLoding(theme: state.theme));
    String? responseText = await authRepository.setSharedPreferences(
      ThemeModel(theme: state.theme == null ? true : !state.theme!),
    );
    if (responseText != null) {
      getSheredPreferences();
    } else {
      setSharedPrefences();
    }
  }
}
