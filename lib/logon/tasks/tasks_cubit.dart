import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:pechat_pay/data/repository/auth.dart';
import 'package:pechat_pay/logon/home/homle_cubit.dart';
import '../../data/driver_model/chip_model.dart';
import '../../data/driver_model/driver_noactive_model.dart';
import '../../data/driver_model/show_history.dart';
import '../../data/driver_model/show_model.dart';
import '../../data/get_it/get_it.dart';
import '../../data/token_model/token_erorr_model.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  AuthRepository authRepository = AuthRepository();

  TasksCubit()
    : super(
        TasksInitial(
          value: "name",
          hidingData: false,
          rapidOperations: false,
          number: 0,
          selectedIndex: null,
          driverDetailData: null,
          unpaidPechatsSum: 0,
          driverHistoryResponse: null,
          type: true,
          chip: [
            ChipModel(name: "Barchasi", key: "all", selected: true),
            ChipModel(
              name: "7 kun faol emas",
              key: "inactive_7",
              selected: false,
            ),
            ChipModel(
              name: "15 kun faol emas",
              key: "inactive_15",
              selected: false,
            ),
            ChipModel(
              name: "30 kun faol emas",
              key: "inactive_30",
              selected: false,
            ),
            ChipModel(name: "Naqd puli bor", key: "has_cash", selected: false),
            ChipModel(name: "Qarzdor", key: "has_debt", selected: false),
            ChipModel(name: "Pechati bor", key: "has_pechat", selected: false),
            ChipModel(name: "Pechati yo‘q", key: "no_pechat", selected: false),
          ],
          driversPage: null,
        ),
      );

  Future<void> onTap(
    String value,
    bool hidingData,
    bool rapidOperations,
    int? selectedIndex,
    bool type,
  ) async {
    emit(
      TasksFinish(
        unpaidPechatsSum: state.unpaidPechatsSum,
        value: value,
        rapidOperations: rapidOperations,
        hidingData: hidingData,
        number: state.number,
        selectedIndex: selectedIndex,
        driverDetailData: state.driverDetailData,
        driverHistoryResponse: state.driverHistoryResponse,
        type: type,
        chip: state.chip,
        driversPage: state.driversPage,
      ),
    );
  }

  Future<void> chip(int index) async {
    List<ChipModel> newchip = [...state.chip];
    if (index == 0 && newchip[0].selected == false) {
      for (final item in newchip) {
        item.selected = false;
      }
      newchip[0].selected = true;
    } else if (index == 0 && newchip[0].selected == true) {
      newchip;
    } else {
      newchip[0].selected = false;
      newchip[index].selected = !newchip[index].selected;
      if (!newchip.any((e) => e.selected)) {
        newchip[0].selected = true;
      }
      debugPrint('index: $index');
      debugPrint(newchip.map((e) => e.selected).toList().toString());
    }
    emit(
      TasksFinish(
        unpaidPechatsSum: state.unpaidPechatsSum,
        value: state.value,
        rapidOperations: state.rapidOperations,
        hidingData: state.hidingData,
        number: state.number,
        selectedIndex: state.selectedIndex,
        driverDetailData: state.driverDetailData,
        driverHistoryResponse: state.driverHistoryResponse,
        type: state.type,
        chip: newchip,
        driversPage: state.driversPage,
      ),
    );
  }

  void number(int value) {
    final list = state.driverDetailData!.unpaidPechat.reversed.toList();
    final current = state.number;

    if (value == -1) {
      if (current == 0) return;
      emit(
        TasksFinish(
          unpaidPechatsSum: state.unpaidPechatsSum - list[current - 1].summa,
          value: state.value,
          hidingData: state.hidingData,
          rapidOperations: state.rapidOperations,
          number: current - 1,
          selectedIndex: state.selectedIndex,
          driverDetailData: state.driverDetailData,
          driverHistoryResponse: state.driverHistoryResponse,
          type: state.type,
          chip: state.chip,
          driversPage: state.driversPage,
        ),
      );
    } else {
      if (current >= list.length) return;
      emit(
        TasksFinish(
          unpaidPechatsSum: state.unpaidPechatsSum + list[current].summa,
          value: state.value,
          hidingData: state.hidingData,
          rapidOperations: state.rapidOperations,
          number: current + 1,
          selectedIndex: state.selectedIndex,
          driverDetailData: state.driverDetailData,
          driverHistoryResponse: state.driverHistoryResponse,
          type: state.type,
          chip: state.chip,
          driversPage: state.driversPage,
        ),
      );
    }
  }

  Future<void> show(int id, int page) async {
    emit(
      TasksLoding(
        unpaidPechatsSum: 0,
        value: state.value,
        hidingData: state.hidingData,
        rapidOperations: state.rapidOperations,
        number: 0,
        selectedIndex: state.selectedIndex,
        driverDetailData: null,
        driverHistoryResponse: state.driverHistoryResponse,
        type: state.type,
        chip: state.chip,
        driversPage: state.driversPage,
      ),
    );
    final response = await Future.wait([
      authRepository.show(id),
      authRepository.showHistory(id, page),
    ]);

    if (response[0] is TokenErorrModel || response[0] is TokenErorrModel) {
      emit(
        TasksError(
          unpaidPechatsSum: state.unpaidPechatsSum,
          value: state.value,
          hidingData: state.hidingData,
          rapidOperations: state.rapidOperations,
          number: state.number,
          selectedIndex: state.selectedIndex,
          driverDetailData: state.driverDetailData,
          tokenErorrModel: response[0] == TokenErorrModel
              ? response[0]
              : response[1],
          driverHistoryResponse: state.driverHistoryResponse,
          type: state.type,
          chip: state.chip,
          driversPage: state.driversPage,
        ),
      );
    } else if (response[0] is DriverDetailData &&
        response[1] is DriverHistoryResponse) {
      emit(
        TasksFinish(
          unpaidPechatsSum: state.unpaidPechatsSum,
          value: state.value,
          hidingData: state.hidingData,
          rapidOperations: state.rapidOperations,
          number: state.number,
          selectedIndex: state.selectedIndex,
          driverDetailData: response[0],
          driverHistoryResponse: response[1],
          type: state.type,
          chip: state.chip,
          driversPage: state.driversPage,
        ),
      );
    }
  }

  Future<void> showHistory(int id, int page) async {
    if (page == 1) {
      emit(
        TasksLoding(
          unpaidPechatsSum: state.unpaidPechatsSum,
          value: state.value,
          hidingData: state.hidingData,
          rapidOperations: state.rapidOperations,
          number: state.number,
          selectedIndex: state.selectedIndex,
          driverDetailData: state.driverDetailData,
          driverHistoryResponse: null,
          type: state.type,
          chip: state.chip,
          driversPage: state.driversPage,
        ),
      );
    }
    final response = await authRepository.showHistory(id, page);
    if (response is TokenErorrModel) {
      emit(
        TasksError(
          unpaidPechatsSum: state.unpaidPechatsSum,
          value: state.value,
          hidingData: state.hidingData,
          rapidOperations: state.rapidOperations,
          number: state.number,
          selectedIndex: state.selectedIndex,
          driverDetailData: state.driverDetailData,
          tokenErorrModel: response,
          driverHistoryResponse: state.driverHistoryResponse,
          type: state.type,
          chip: state.chip,
          driversPage: state.driversPage,
        ),
      );
    } else if (response is DriverHistoryResponse) {
      emit(
        TasksFinish(
          unpaidPechatsSum: state.unpaidPechatsSum,
          value: state.value,
          hidingData: state.hidingData,
          rapidOperations: state.rapidOperations,
          number: state.number,
          selectedIndex: state.selectedIndex,
          driverDetailData: state.driverDetailData,
          driverHistoryResponse: page == 1
              ? response
              : DriverHistoryResponse(
                  data: [
                    ...state.driverHistoryResponse!.data,
                    ...response.data,
                  ],
                  meta: response.meta,
                ),
          type: state.type,
          chip: state.chip,
          driversPage: state.driversPage,
        ),
      );
    }
  }

  Future<void> driversPage(String? search, int page) async {
    final List<String> key = state.chip
        .where((e) => e.selected)
        .map((m) => m.key)
        .toList();
    if (page == 1) {
      emit(
        TasksLoding(
          unpaidPechatsSum: state.unpaidPechatsSum,
          value: state.value,
          hidingData: state.hidingData,
          rapidOperations: state.rapidOperations,
          number: state.number,
          selectedIndex: state.selectedIndex,
          driverDetailData: state.driverDetailData,
          driverHistoryResponse: state.driverHistoryResponse,
          type: state.type,
          chip: state.chip,
          driversPage: null,
        ),
      );
    }
    final response = await authRepository.driversPage(
      search,
      state.value,
      key,
      page,
    );
    if (response is TokenErorrModel) {
      emit(
        TasksError(
          unpaidPechatsSum: state.unpaidPechatsSum,
          value: state.value,
          hidingData: state.hidingData,
          rapidOperations: state.rapidOperations,
          number: state.number,
          selectedIndex: state.selectedIndex,
          driverDetailData: state.driverDetailData,
          tokenErorrModel: response,
          driverHistoryResponse: state.driverHistoryResponse,
          type: state.type,
          chip: state.chip,
          driversPage: null,
        ),
      );
    } else if (response is DriverNoactiveResponse) {
      emit(
        TasksFinish(
          unpaidPechatsSum: state.unpaidPechatsSum,
          value: state.value,
          hidingData: state.hidingData,
          rapidOperations: state.rapidOperations,
          number: state.number,
          selectedIndex: state.selectedIndex,
          driverDetailData: state.driverDetailData,
          driverHistoryResponse: state.driverHistoryResponse,
          type: state.type,
          chip: state.chip,
          driversPage: page == 1
              ? response
              : DriverNoactiveResponse(
                  data: [...state.driversPage!.data, ...response.data],
                  meta: response.meta,
                ),
        ),
      );
    }
  }

  Future<bool> createUpdateDriver(
      String name,
      String phone,
      String carNumer,
      int? id,
      ) async {
    emit(
      TasksLoding(
        unpaidPechatsSum: state.unpaidPechatsSum,
        value: state.value,
        hidingData: state.hidingData,
        rapidOperations: state.rapidOperations,
        number: state.number,
        selectedIndex: state.selectedIndex,
        driverDetailData: state.driverDetailData,
        driverHistoryResponse: state.driverHistoryResponse,
        type: state.type,
        chip: state.chip,
        driversPage: state.driversPage,
      ),
    );

    final response = await authRepository.createUpdateDriver(
      name, phone, carNumer, id,
    );

    if (response is TokenErorrModel) {

      emit(
        TasksError(
          unpaidPechatsSum: state.unpaidPechatsSum,
          value: state.value,
          hidingData: state.hidingData,
          rapidOperations: state.rapidOperations,
          number: state.number,
          selectedIndex: state.selectedIndex,
          driverDetailData: state.driverDetailData,
          tokenErorrModel: response,
          driverHistoryResponse: state.driverHistoryResponse,
          type: state.type,
          chip: state.chip,
          driversPage: state.driversPage,
        ),
      );
      return false;
    }
    emit(
      TasksFinish(
        unpaidPechatsSum: state.unpaidPechatsSum,
        value: state.value,
        hidingData: state.hidingData,
        rapidOperations: state.rapidOperations,
        number: state.number,
        selectedIndex: state.selectedIndex,
        driverDetailData: state.driverDetailData,
        driverHistoryResponse: state.driverHistoryResponse,
        type: state.type,
        chip: state.chip,
        driversPage: state.driversPage,
      ),
    );
    await sl<HomleCubit>().historyHomePage(1);
    return true;
  }
}
