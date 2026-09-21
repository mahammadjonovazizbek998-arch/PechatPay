import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit()
    : super(
        TasksInitial(
          index: 0,
          value: "all",
          hidingData: false,
          rapidOperations: false,
          number: 0,
          selectedIndex: null,
        ),
      );

  void onTap(
    int index,
    String value,
    bool hidingData,
    bool rapidOperations,
    int? selectedIndex,
  ) {
    emit(
      TasksFinish(
        index: index,
        value: value,
        rapidOperations: rapidOperations,
        hidingData: hidingData,
        number: state.number,
        selectedIndex: selectedIndex,
      ),
    );
  }

  void number(int value) {
    if (value == -1) {
      if (state.number == 0) {
        emit(
          TasksFinish(
            index: state.index,
            value: state.value,
            hidingData: state.hidingData,
            rapidOperations: state.rapidOperations,
            number: state.number,
            selectedIndex: state.selectedIndex,
          ),
        );
      } else {
        emit(
          TasksFinish(
            selectedIndex: state.selectedIndex,
            index: state.index,
            value: state.value,
            hidingData: state.hidingData,
            rapidOperations: state.rapidOperations,
            number: state.number + value,
          ),
        );
      }
    } else {
      emit(
        TasksFinish(
          selectedIndex: state.selectedIndex,
          index: state.index,
          value: state.value,
          hidingData: state.hidingData,
          rapidOperations: state.rapidOperations,
          number: state.number + value,
        ),
      );
    }
  }
}
