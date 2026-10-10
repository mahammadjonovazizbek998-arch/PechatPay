import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:pechat_pay/logon/login/login_cubit.dart';

import '../../data/driver_model/chip_model.dart';
import '../../data/get_it/get_it.dart';
import '../../data/repository/auth.dart';
import '../../data/token_model/token_erorr_model.dart';
import '../../data/token_model/token_model.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit()
    : super(
        DashboardInitial(
          index: 0,
          filiallPagel: [
            TokenModelApiUserModel(
              id: 0,
              name: "Barcha filiallar bo'yicha",
              phone: "",
              role: "",
              shift1Start: "",
              shift1End: "",
              shift2Start: "",
              shift2End: "",
              stampPrice: 0,
              stampPauseHours: 0,
            ),
          ],
          chip: [
            ChipModel(name: "Barchasi", key: "all", selected: false),
            ChipModel(name: "Yillik", key: "year", selected: false),
            ChipModel(name: "Oylik", key: "month", selected: false),
            ChipModel(name: "Haftalik", key: "week", selected: false),
            ChipModel(name: "Kunlik", key: "day", selected: true),
          ],
          selectedDate: DateTime.now(),
          selectedIndex: 0,
        ),
      );
  AuthRepository authRepository = AuthRepository();

  Future<void> onTap(int? id, int? chipIndex) async {
    if (id != null) {
      chipIndex = 4;
      final index = state.filiallPagel.indexWhere((item) => item.id == id);
      emit(
        DashboardFinish(
          filiallPagel: state.filiallPagel,
          index: index == -1 ? 0 : index,
          chip: state.chip,
          selectedDate: DateTime.now(),
          selectedIndex: 0,
        ),
      );
    }
    if (chipIndex != null) {
      List<ChipModel> newChip = [...state.chip];
      for (int i = 0; i < newChip.length; i++) {
        newChip[i].selected = (i == chipIndex);
      }

      emit(
        DashboardFinish(
          filiallPagel: state.filiallPagel,
          index: state.index,
          chip: newChip,
          selectedDate: DateTime.now(),
          selectedIndex: 0,
        ),
      );
    }
  }

  Future<void> selected(int? index, DateTime? data) async {
    if (data != null) {
      emit(
        DashboardFinish(
          filiallPagel: state.filiallPagel,
          index: state.index,
          chip: state.chip,
          selectedIndex: 0,
          selectedDate: data,
        ),
      );
    } else if (index != null) {
      emit(
        DashboardFinish(
          filiallPagel: state.filiallPagel,
          index: state.index,
          chip: state.chip,
          selectedIndex: index,
          selectedDate: state.selectedDate,
        ),
      );
    }
  }

  Future<void> filiallPage() async {
    emit(
      DashboardLoding(
        chip: state.chip,
        filiallPagel: state.filiallPagel,
        index: state.index,
        selectedDate: state.selectedDate,
        selectedIndex: state.selectedIndex,
      ),
    );
    final response = await Future.wait([authRepository.filiallPage()]);
    if (response[0] is TokenErorrModel) {
      emit(
        DashboardError(
          chip: state.chip,
          filiallPagel: state.filiallPagel,
          tokenErorrModel: response[0],
          index: state.index,
          selectedDate: state.selectedDate,
          selectedIndex: state.selectedIndex,
        ),
      );
    } else if (response[0] is List<TokenModelApiUserModel>) {
      int id = sl<LoginCubit>().state.token!.id;
      final index = response[0].indexWhere((item) => item.id == id);
      emit(
        DashboardFinish(
          chip: state.chip,
          index: index != -1 ? index + 1 : 0,
          filiallPagel: [...state.filiallPagel, ...response[0]],
          selectedDate: state.selectedDate,
          selectedIndex: state.selectedIndex,
        ),
      );
    }
    // if (response[0] is TokenErorrModel || response[0] is TokenErorrModel) {
    //   emit(
    //     DashboardError(
    //       filiallPagel: state.filiallPagel,
    //       tokenErorrModel: response[0] is TokenErorrModel
    //           ? response[0]
    //           : response[1],
    //     ),
    //   );
    // }
  }
}
