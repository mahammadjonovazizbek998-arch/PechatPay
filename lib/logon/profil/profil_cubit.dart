import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:pechat_pay/data/token_model/token_erorr_model.dart';
import 'package:pechat_pay/data/token_model/token_model.dart';
import 'package:pechat_pay/logon/login/login_cubit.dart';

import '../../data/driver_model/driver_noactive_model.dart';
import '../../data/get_it/get_it.dart';
import '../../data/repository/auth.dart';

part 'profil_state.dart';

class ProfilCubit extends Cubit<ProfilState> {
  ProfilCubit()
    : super(
        ProfilInitial(
          password1: false,
          password2: false,
          password3: false,
          shift2End: null,
          shift2Start: null,
          shift1End: null,
          shift1Start: null,
          stampPauseHours: 0,
          filiallPagel: [],
          driverNoactiveModel: null,
          day: "7",
        ),
      );
  AuthRepository authRepository = AuthRepository();

  void onTap(bool password1, bool password2, bool password3) {
    emit(
      ProfilInitial(
        password1: password1,
        password2: password2,
        password3: password3,
        shift1Start: state.shift1Start,
        shift1End: state.shift1End,
        shift2Start: state.shift2Start,
        shift2End: state.shift2End,
        stampPauseHours: state.stampPauseHours,
        filiallPagel: state.filiallPagel,
        driverNoactiveModel: state.driverNoactiveModel,
        day: state.day,
      ),
    );
  }

  void itmeOfDay(
    String? shift2Start,
    String? shift2End,
    String? shift1Start,
    String? shift1End,
    int stampPauseHours,
  ) {
    emit(
      ProfilInitial(
        password1: state.password1,
        password2: state.password2,
        password3: state.password3,
        shift2Start: shift2Start,
        shift2End: shift2End,
        shift1Start: shift1Start,
        shift1End: shift1End,
        stampPauseHours: stampPauseHours,
        filiallPagel: state.filiallPagel,
        driverNoactiveModel: state.driverNoactiveModel,
        day: state.day,
      ),
    );
  }

  Future<void> meUpdate(
    String name,

    String phone,
    String currentPassword,
    String passwordConfirmation,
    String stampPrice,
    String password,
  ) async {
    emit(
      ProfilLoding(
        password1: state.password1,
        password2: state.password2,
        password3: state.password3,
        shift1Start: state.shift1Start,
        shift1End: state.shift1End,
        shift2Start: state.shift2Start,
        shift2End: state.shift2End,
        stampPauseHours: state.stampPauseHours,
        filiallPagel: state.filiallPagel,
        driverNoactiveModel: state.driverNoactiveModel,
        day: state.day,
      ),
    );

    final response = await authRepository.meUpdate(
      name,
      phone,
      currentPassword,
      password,
      passwordConfirmation,
      stampPrice,
      state.stampPauseHours.toString(),
      state.shift1Start ?? "08:00",
      state.shift1End ?? "20:00",
      state.shift2Start ?? "20:00",
      state.shift2End ?? "08:00",
    );
    if (response is TokenErorrModel) {
      emit(
        ProfilError(
          password1: state.password1,
          password2: state.password2,
          password3: state.password3,
          shift1Start: state.shift1Start,
          shift1End: state.shift1End,
          shift2Start: state.shift2Start,
          shift2End: state.shift2End,
          stampPauseHours: state.stampPauseHours,
          tokenErorrModel: response,
          filiallPagel: state.filiallPagel,
          driverNoactiveModel: state.driverNoactiveModel,
          day: state.day,
        ),
      );
    } else if (response is TokenModel) {
      await sl<LoginCubit>().setSharedPrefences(response);

      emit(
        ProfilFinish(
          password1: false,
          password2: false,
          password3: false,
          shift1Start: null,
          shift1End: null,
          shift2Start: null,
          shift2End: null,
          stampPauseHours: 0,
          filiallPagel: state.filiallPagel,
          driverNoactiveModel: state.driverNoactiveModel,
          day: state.day,
        ),
      );
    }
  }

  Future<void> filiallPage() async {
    emit(
      ProfilLoding(
        password1: state.password1,
        password2: state.password2,
        password3: state.password3,
        shift1Start: state.shift1Start,
        shift1End: state.shift1End,
        shift2Start: state.shift2Start,
        shift2End: state.shift2End,
        stampPauseHours: state.stampPauseHours,
        filiallPagel: state.filiallPagel,
        driverNoactiveModel: state.driverNoactiveModel,
        day: state.day,
      ),
    );
    final response = await authRepository.filiallPage();
    if (response is TokenErorrModel) {
      emit(
        ProfilError(
          password1: state.password1,
          password2: state.password2,
          password3: state.password3,
          shift1Start: state.shift1Start,
          shift1End: state.shift1End,
          shift2Start: state.shift2Start,
          shift2End: state.shift2End,
          stampPauseHours: state.stampPauseHours,
          tokenErorrModel: response,
          filiallPagel: state.filiallPagel,
          driverNoactiveModel: state.driverNoactiveModel,
          day: state.day,
        ),
      );
    } else if (response is List<TokenModelApiUserModel>) {
      emit(
        ProfilFinish(
          password1: false,
          password2: false,
          password3: false,
          shift1Start: null,
          shift1End: null,
          shift2Start: null,
          shift2End: null,
          stampPauseHours: 0,
          filiallPagel: response,
          driverNoactiveModel: state.driverNoactiveModel,
          day: state.day,
        ),
      );
    }
  }

  Future<void> filiallUpdate(
    String name,
    String phone,
    String? currentPassword,
    String passwordConfirmation,
    String stampPrice,
    String password,
    int? id,
  ) async {
    emit(
      ProfilLoding(
        password1: state.password1,
        password2: state.password2,
        password3: state.password3,
        shift1Start: state.shift1Start,
        shift1End: state.shift1End,
        shift2Start: state.shift2Start,
        shift2End: state.shift2End,
        stampPauseHours: state.stampPauseHours,
        filiallPagel: state.filiallPagel,
        driverNoactiveModel: state.driverNoactiveModel,
        day: state.day,
      ),
    );

    final response = await authRepository.filiallUpdate(
      name,
      phone,
      currentPassword,
      password,
      passwordConfirmation,
      stampPrice,
      state.stampPauseHours.toString(),
      state.shift1Start ?? "08:00",
      state.shift1End ?? "20:00",
      state.shift2Start ?? "20:00",
      state.shift2End ?? "08:00",
      id,
    );

    if (response is TokenErorrModel) {
      emit(
        ProfilError(
          password1: state.password1,
          password2: state.password2,
          password3: state.password3,
          shift1Start: state.shift1Start,
          shift1End: state.shift1End,
          shift2Start: state.shift2Start,
          shift2End: state.shift2End,
          stampPauseHours: state.stampPauseHours,
          tokenErorrModel: response,
          filiallPagel: state.filiallPagel,
          driverNoactiveModel: state.driverNoactiveModel,
          day: state.day,
        ),
      );
    } else if (response is TokenModel) {
      await filiallPage();
    }
  }

  Future<void> noActiveDriver(int? day, int page) async {
  if(page==1){  emit(
      ProfilLoding(
        password1: state.password1,
        password2: state.password2,
        password3: state.password3,
        shift1Start: state.shift1Start,
        shift1End: state.shift1End,
        shift2Start: state.shift2Start,
        shift2End: state.shift2End,
        stampPauseHours: state.stampPauseHours,
        filiallPagel: state.filiallPagel,
        driverNoactiveModel: state.driverNoactiveModel,
        day: day == null ? state.day : day.toString(),
      ),
    );}
    final response = await authRepository.noActiveDriver(
      day ?? int.parse(state.day),
      page,
    );
    if (response is TokenErorrModel) {
      emit(
        ProfilError(
          password1: state.password1,
          password2: state.password2,
          password3: state.password3,
          shift1Start: state.shift1Start,
          shift1End: state.shift1End,
          shift2Start: state.shift2Start,
          shift2End: state.shift2End,
          stampPauseHours: state.stampPauseHours,
          tokenErorrModel: response,
          filiallPagel: state.filiallPagel,
          driverNoactiveModel: state.driverNoactiveModel,
          day: state.day,
        ),
      );
    } else if (response is DriverNoactiveResponse) {
      emit(
        ProfilFinish(
          password1: false,
          password2: false,
          password3: false,
          shift1Start: null,
          shift1End: null,
          shift2Start: null,
          shift2End: null,
          stampPauseHours: 0,
          filiallPagel: state.filiallPagel,
          driverNoactiveModel:page==1
              ? response
              : DriverNoactiveResponse(
                  data: [...state.driverNoactiveModel!.data, ...response.data],
                  meta: response.meta,
                ),
          day: state.day,
        ),
      );
    }
  }
}
