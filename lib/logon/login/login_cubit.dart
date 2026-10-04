import 'package:bloc/bloc.dart';
import '../../data/repository/auth.dart';
import '../../data/token_model/token_erorr_model.dart';
import '../../data/token_model/token_model.dart';


part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit()
    : super(
        LoginInitial(
          toHider: true,
          token: TokenModel(
            id: 0,
            name: "",
            phone: "",
            token: "",
            role: '',
            shift1Start: '',
            shift1End: '',
            shift2Start: '',
            shift2End: '',
            stampPrice: 0,
            stampPauseHours: 0,
          ),
        ),
      ) {
    getSheredPreferences();
  }

  void hider() {
    emit(LoginButton(toHider: !state.toHider, token: state.token));
  }

  AuthRepository authRepository = AuthRepository();

  Future<void> getSheredPreferences() async {
    emit(LoginLoding(token: state.token, toHider: state.toHider));
    TokenModel? tokenModel = await authRepository.tokenGetSharePreferences();
    emit(LoginFinish(token: tokenModel, toHider: state.toHider));
    if (tokenModel != null) {

      authMe();

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
          phone: tokenModelApi.tokenModelApiUserModel!.phone,
          token: tokenModelApi.token,
          role: tokenModelApi.tokenModelApiUserModel!.role,
          shift1Start: tokenModelApi.tokenModelApiUserModel!.shift1Start,
          shift1End: tokenModelApi.tokenModelApiUserModel!.shift2End,
          shift2Start: tokenModelApi.tokenModelApiUserModel!.shift2Start,
          shift2End: tokenModelApi.tokenModelApiUserModel!.shift2End,
          stampPrice: tokenModelApi.tokenModelApiUserModel!.stampPrice,
          stampPauseHours: tokenModelApi.tokenModelApiUserModel!.stampPauseHours
              .toInt(),
        ),
      );
      emit(
        LoginFinish(
          token: TokenModel(
            id: tokenModelApi.tokenModelApiUserModel!.id,
            name: tokenModelApi.tokenModelApiUserModel!.name,
            phone: tokenModelApi.tokenModelApiUserModel!.name,
            token: tokenModelApi.token,
            role: tokenModelApi.tokenModelApiUserModel!.role,
            shift1Start: tokenModelApi.tokenModelApiUserModel!.shift1Start,
            shift1End: tokenModelApi.tokenModelApiUserModel!.shift2End,
            shift2Start: tokenModelApi.tokenModelApiUserModel!.shift2Start,
            shift2End: tokenModelApi.tokenModelApiUserModel!.shift2End,
            stampPrice: tokenModelApi.tokenModelApiUserModel!.stampPrice,
            stampPauseHours:
                tokenModelApi.tokenModelApiUserModel!.stampPauseHours,
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
  Future<void> authMe() async {
    final response = await authRepository.authMe();
    if (response is TokenModel) {
      emit(LoginFinish(token: state.token, toHider: state.toHider));
    } else if (response == 401) {
      await authRepository.tokenSetSharedPreferences(null);
      emit(LoginFinish(token: null, toHider: state.toHider));
    } else if (response is TokenErorrModel) {
      emit(
        LoginError(error: response, toHider: state.toHider, token: state.token),
      );
    }
  }

  //logout
  Future<void> logOut() async {
    emit(LoginLoding(toHider: state.toHider, token: state.token));
    final response = await authRepository.logOut();
    if (response == null) {
      await setSharedPrefences(null);
    } else if (response is TokenErorrModel) {
      emit(
        LoginError(error: response, toHider: state.toHider, token: state.token),
      );
    }
  }
}
