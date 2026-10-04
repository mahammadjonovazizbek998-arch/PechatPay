part of 'tasks_cubit.dart';

@immutable
sealed class TasksState {
  final int index;
  final String value;
  final bool rapidOperations;
  final bool hidingData;
  final int? selectedIndex;
  final DriverDetailData? driverDetailData;
  final int number;
  final int unpaidPechatsSum;
  final DriverHistoryResponse? driverHistoryResponse;
  final bool type;


  const TasksState({
    required this.index,
    required this.value,
    required this.rapidOperations,
    required this.hidingData,
    required this.number,
    required this.selectedIndex,
    required this.driverDetailData,
    required this.unpaidPechatsSum,
    required this.driverHistoryResponse,
    required this.type,
  });
}

final class TasksInitial extends TasksState {
  const TasksInitial({
    required super.index,
    required super.value,
    required super.rapidOperations,
    required super.hidingData,
    required super.number,
    required super.selectedIndex,
    required super.driverDetailData,
    required super.unpaidPechatsSum,
    required super.driverHistoryResponse,
    required super.type,

  });
}

final class TasksFinish extends TasksState {
  const TasksFinish({
    required super.index,
    required super.value,
    required super.hidingData,
    required super.rapidOperations,
    required super.number,
    required super.selectedIndex,
    required super.driverDetailData,
    required super.unpaidPechatsSum,
    required super.driverHistoryResponse,
    required super.type,

  });
}

final class TasksLoding extends TasksState {
  const TasksLoding({
    required super.index,
    required super.value,
    required super.hidingData,
    required super.rapidOperations,
    required super.number,
    required super.selectedIndex,
    required super.driverDetailData,
    required super.driverHistoryResponse,
    required super.unpaidPechatsSum,
    required super.type,

  });
}

final class TasksError extends TasksState {
  final TokenErorrModel tokenErorrModel;

  const TasksError({
    required super.index,
    required super.value,
    required super.hidingData,
    required super.rapidOperations,
    required super.number,
    required super.selectedIndex,
    required super.driverDetailData,
    required super.unpaidPechatsSum,
    required super.driverHistoryResponse,
    required super.type,

    required this.tokenErorrModel,
  });
}
