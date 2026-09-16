import 'package:bloc/bloc.dart';

import '../../data/repository/auth.dart';
import '../../data/token_model/token_erorr_model.dart';
import '../../data/token_model/token_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial(toHider: true)) {
    getSheredPreferences();
  }

  void hider() {
    emit(LoginButton(toHider: !state.toHider, token: state.token));
  }

  AuthRepository authRepository = AuthRepository();

  //token ni xotridan o'qish
  Future<void> getSheredPreferences() async {
    emit(LoginLoding(token: state.token, toHider: state.toHider));
    TokenModel? tokenModel = await authRepository.tokenGetSharePreferences();
    if (tokenModel != null) {
      await authMe(tokenModel.token);
    } else {
      emit(LoginFinish(token: tokenModel, toHider: state.toHider));
    }
  }

  //token ni xotriaga yozish
  Future<void> setSharedPrefences(TokenModel? newToken) async {
    emit(LoginLoding(token: state.token, toHider: state.toHider));
    bool responseText = await authRepository.tokenSetSharedPreferences(
      newToken,
    );
    if (responseText) {
      emit(LoginFinish(token: newToken, toHider: state.toHider));
    } else {
      emit(
        LoginError(
          error: TokenErorrModel(message: 'Tokenni saqlab bo‘lmadi'),
          toHider: state.toHider,
          token: state.token,
        ),
      );
    }
  }

  //sin in
  Future<void> sinIn(String phone, String password) async {

    emit(LoginLoding(toHider: state.toHider, token: state.token));
    final response = await authRepository.sinIn(phone, password);
    if (response is TokenModelApi) {
      TokenModelApi tokenModelApi = response;
      await setSharedPrefences(
        TokenModel(
          id: tokenModelApi.tokenModelApiUserModel!.id,
          name: tokenModelApi.tokenModelApiUserModel!.name,
          phone: tokenModelApi.tokenModelApiUserModel!.name,
          token: tokenModelApi.token,
        ),
      );
      emit(
        LoginFinish(
          token: TokenModel(
            id: tokenModelApi.tokenModelApiUserModel!.id,
            name: tokenModelApi.tokenModelApiUserModel!.name,
            phone: tokenModelApi.tokenModelApiUserModel!.name,
            token: tokenModelApi.token,
          ),
          toHider: state.toHider,
        ),
      );
    }
    if (response is TokenErorrModel) {

      emit(
        LoginError(error: response, toHider: state.toHider, token: state.token),
      );
    }
  }

  //profil malumotlari
  Future<void> authMe(String token) async {


    final response = await authRepository.authMe(token);
    if (response is TokenModel) {
      TokenModel tokenModelApi = response;
      emit(LoginFinish(token: tokenModelApi, toHider: state.toHider));
    } else if (response == 401) {
      await authRepository.tokenSetSharedPreferences(null);
      emit(LoginFinish(token: null, toHider: state.toHider));
    } else if (response is TokenErorrModel) {
      emit(
        LoginError(error: response, toHider: state.toHider, token: state.token),
      );
    }
  }

  // //logout
  // Future<void> logOut() async {
  //   emit(LoginLoding(toHider: state.toHider, token: state.token));
  //   final response = await authRepository.logOut();
  //   if (response is TokenErorrModel) {
  //     emit(
  //       LoginError(error: response, toHider: state.toHider, token: state.token),
  //     );
  //   }
  // }
}
