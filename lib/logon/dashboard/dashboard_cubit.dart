import 'package:bloc/bloc.dart';
import 'package:pechat_pay/logon/login/login_cubit.dart';

import '../../data/dashboar_model/all_dashboar_model.dart';
import '../../data/driver_model/chip_model.dart';
import '../../data/get_it/get_it.dart';
import '../../data/repository/auth.dart';
import '../../data/token_model/token_erorr_model.dart';
import '../../data/token_model/token_model.dart';
import 'dashboard_state.dart';

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
              shift1Start: "08:00",
              shift1End: "18:00",
              shift2Start: "18:00",
              shift2End: "06:00",
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
          statsResponse: null,
          statisticsBool: true,
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
          statsResponse: state.statsResponse,
          statisticsBool: false,
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
          statsResponse: state.statsResponse,
          statisticsBool: false,
        ),
      );
    }
    await statisticsBrench();
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
          statsResponse: state.statsResponse,
          statisticsBool: false,
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
          statsResponse: state.statsResponse,
          statisticsBool: false,
        ),
      );
    }
    await statisticsBrench();
  }

  Future<void> filiallPage() async {
    emit(
      DashboardLoding(
        chip: state.chip,
        filiallPagel: state.filiallPagel,
        index: state.index,
        selectedDate: state.selectedDate,
        selectedIndex: state.selectedIndex,
        statsResponse: state.statsResponse,

        statisticsBool: state.statisticsBool,
      ),
    );
    final response = await Future.wait([
      authRepository.filiallPage(),
      authRepository.dashboard(
        sl<LoginCubit>().state.token!.id,
        "day",
        "2026-09-04",
        //"${state.selectedDate.year}-${state.selectedDate.month}-${state.selectedDate.day}",
        null,
        null,
        null,
        null,
      ),
    ]);
    if (response[0] is TokenErorrModel || response[1] is TokenErorrModel) {
      emit(
        DashboardError(
          filiallPagel: state.filiallPagel,
          tokenErorrModel: response[0] is TokenErorrModel
              ? response[0]
              : response[1],
          statsResponse: state.statsResponse,
          chip: state.chip,
          index: state.index,
          selectedDate: state.selectedDate,
          selectedIndex: state.selectedIndex,
          statisticsBool: state.statisticsBool,
        ),
      );
    } else if (response[0] is List<TokenModelApiUserModel> &&
        response[1] is StatsResponse) {
      int id = sl<LoginCubit>().state.token!.id;
      final index = response[0].indexWhere((item) => item.id == id);
      emit(
        DashboardFinish(
          chip: state.chip,
          index: index != -1 ? index + 1 : 0,
          filiallPagel: [...state.filiallPagel, ...response[0]],
          selectedDate: state.selectedDate,
          selectedIndex: state.selectedIndex,
          statsResponse: response[1],
          statisticsBool: state.statisticsBool,
        ),
      );
    }
  }

  Future<void> statisticsPage(bool value) async {
    emit(
      DashboardFinish(
        filiallPagel: state.filiallPagel,
        index: state.index,
        chip: state.chip,
        selectedIndex: state.selectedIndex,
        selectedDate: state.selectedDate,
        statsResponse: state.statsResponse,
        statisticsBool: value,
      ),
    );
  }

  Future<void> statisticsBrench() async {
    int? key;
    if (state.index != 0 && state.index < state.filiallPagel.length) {
      key = state.filiallPagel[state.index].id;
    } else {
      key = null;
    }

    emit(
      DashboardLoding(
        index: state.index,
        filiallPagel: state.filiallPagel,
        chip: state.chip,
        selectedDate: state.selectedDate,
        selectedIndex: state.selectedIndex,
        statsResponse: null,
        statisticsBool: state.statisticsBool,
      ),
    );

    final dynamic response;
    final year = state.selectedDate.year;
    final month = state.selectedDate.month.toString().padLeft(2, '0');
    final day = state.selectedDate.day.toString().padLeft(2, '0');
    final formattedDate = "$year-$month-$day";

    if (state.chip[4].selected == true) {
      // Kunlik
      response = await authRepository.dashboard(
        key,
        "day",
        formattedDate,
        null,
        null,
        null,
        null,
      );
    } else if (state.chip[3].selected == true) {
      // Haftalik (Dushanba - Yakshanba)
      final monday = state.selectedDate.subtract(
        Duration(days: state.selectedDate.weekday - 1),
      );
      final sunday = monday.add(const Duration(days: 6));
      final wStart = "${monday.year}-${monday.month.toString().padLeft(2, '0')}-${monday.day.toString().padLeft(2, '0')}";
      final wEnd = "${sunday.year}-${sunday.month.toString().padLeft(2, '0')}-${sunday.day.toString().padLeft(2, '0')}";

      response = await authRepository.dashboard(
        key,
        "week",
        null,
        wStart,
        wEnd,
        null,
        null,
      );
    } else if (state.chip[2].selected == true) {
      // Oylik
      response = await authRepository.dashboard(
        key,
        "month",
        null,
        null,
        null,
        state.selectedDate.month.toString(), // <-- Faqat oy raqami (masalan: "10")
        state.selectedDate.year.toString(),
      );
    } else if (state.chip[1].selected == true) {
      // Yillik
      response = await authRepository.dashboard(
        key,
        "year",
        null,
        null,
        null,
        null,
        "$year",
      );
    } else {
      // Barchasi
      response = await authRepository.dashboard(
        key,
        "all",
        null,
        null,
        null,
        null,
        null,
      );
    }

    if (response is TokenErorrModel) {
      emit(
        DashboardError(
          filiallPagel: state.filiallPagel,
          tokenErorrModel: response,
          statsResponse: state.statsResponse,
          chip: state.chip,
          index: state.index,
          selectedDate: state.selectedDate,
          selectedIndex: state.selectedIndex,
          statisticsBool: state.statisticsBool,
        ),
      );
    } else if (response is StatsResponse) {
      emit(
        DashboardFinish(
          chip: state.chip,
          index: state.index,
          filiallPagel: state.filiallPagel,
          selectedDate: state.selectedDate,
          selectedIndex: state.selectedIndex,
          statsResponse: response,
          statisticsBool: state.statisticsBool,
        ),
      );
    } else {
      // Fallback (kutilmagan javob kelganda loadingda qotib qolmasligi uchun)
      emit(
        DashboardFinish(
          chip: state.chip,
          index: state.index,
          filiallPagel: state.filiallPagel,
          selectedDate: state.selectedDate,
          selectedIndex: state.selectedIndex,
          statsResponse: state.statsResponse,
          statisticsBool: state.statisticsBool,
        ),
      );
    }
  }
}
