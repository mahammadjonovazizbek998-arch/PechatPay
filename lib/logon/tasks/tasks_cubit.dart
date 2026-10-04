import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:pechat_pay/data/repository/auth.dart';
import '../../data/driver_model/show_history.dart';
import '../../data/driver_model/show_model.dart';
import '../../data/token_model/token_erorr_model.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  AuthRepository authRepository = AuthRepository();

  TasksCubit()
    : super(
        TasksInitial(
          index: 0,
          value: "all",
          hidingData: false,
          rapidOperations: false,
          number: 0,
          selectedIndex: null,
          driverDetailData: null,
          unpaidPechatsSum: 0,
          driverHistoryResponse: null,
          type: true,

        ),
      );

  void onTap(
    int index,
    String value,
    bool hidingData,
    bool rapidOperations,
    int? selectedIndex,
    bool type,
  ) {
    emit(
      TasksFinish(
        unpaidPechatsSum: state.unpaidPechatsSum,
        index: index,
        value: value,
        rapidOperations: rapidOperations,
        hidingData: hidingData,
        number: state.number,
        selectedIndex: selectedIndex,
        driverDetailData: state.driverDetailData,
        driverHistoryResponse: state.driverHistoryResponse,
        type: type,

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
          index: state.index,
          value: state.value,
          hidingData: state.hidingData,
          rapidOperations: state.rapidOperations,
          number: current - 1,
          selectedIndex: state.selectedIndex,
          driverDetailData: state.driverDetailData,
          driverHistoryResponse: state.driverHistoryResponse,
          type: state.type,

        ),
      );
    } else {
      if (current >= list.length) return;
      emit(
        TasksFinish(
          unpaidPechatsSum: state.unpaidPechatsSum + list[current].summa,
          index: state.index,
          value: state.value,
          hidingData: state.hidingData,
          rapidOperations: state.rapidOperations,
          number: current + 1,
          selectedIndex: state.selectedIndex,
          driverDetailData: state.driverDetailData,
          driverHistoryResponse: state.driverHistoryResponse,
          type: state.type,
        ),
      );
    }
  }

  Future<void> show(int id, int page) async {
    emit(
      TasksLoding(
        unpaidPechatsSum: state.unpaidPechatsSum,
        index: state.index,
        value: state.value,
        hidingData: state.hidingData,
        rapidOperations: state.rapidOperations,
        number: state.number,
        selectedIndex: state.selectedIndex,
        driverDetailData: null,
        driverHistoryResponse: state.driverHistoryResponse,
        type: state.type,
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
          index: state.index,
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
        ),
      );
    } else if (response[0] is DriverDetailData &&
        response[1] is DriverHistoryResponse) {
      emit(
        TasksFinish(
          unpaidPechatsSum: state.unpaidPechatsSum,
          index: state.index,
          value: state.value,
          hidingData: state.hidingData,
          rapidOperations: state.rapidOperations,
          number: state.number,
          selectedIndex: state.selectedIndex,
          driverDetailData: response[0],
          driverHistoryResponse: response[1],
          type: state.type,
        ),
      );
    }
  }

  Future<void> showHistory(int id, int page) async {
    if (page == 1) {
      emit(
        TasksLoding(
          unpaidPechatsSum: state.unpaidPechatsSum,
          index: state.index,
          value: state.value,
          hidingData: state.hidingData,
          rapidOperations: state.rapidOperations,
          number: state.number,
          selectedIndex: state.selectedIndex,
          driverDetailData: state.driverDetailData,
          driverHistoryResponse: null,
          type: state.type,
        ),
      );
    }
    final response = await authRepository.showHistory(id, page);
    if (response is TokenErorrModel) {
      emit(
        TasksError(
          unpaidPechatsSum: state.unpaidPechatsSum,
          index: state.index,
          value: state.value,
          hidingData: state.hidingData,
          rapidOperations: state.rapidOperations,
          number: state.number,
          selectedIndex: state.selectedIndex,
          driverDetailData: state.driverDetailData,
          tokenErorrModel: response,
          driverHistoryResponse: state.driverHistoryResponse,
          type: state.type,
        ),
      );
    } else if (response is DriverHistoryResponse) {
      emit(
        TasksFinish(
          unpaidPechatsSum: state.unpaidPechatsSum,
          index: state.index,
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
        ),
      );
    }
  }


}
