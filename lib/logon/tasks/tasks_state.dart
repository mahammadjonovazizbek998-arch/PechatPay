part of 'tasks_cubit.dart';

@immutable
sealed class TasksState {
  final int index;
  final String value;
  final bool rapidOperations;
  final bool hidingData;
  final int? selectedIndex;
final int number;
  const TasksState({
    required this.index,
    required this.value,
    required this.rapidOperations,
    required this.hidingData,
    required this.number,
    required this.selectedIndex
  });
}

final class TasksInitial extends TasksState {
  const TasksInitial({
    required super.index,
    required super.value,
    required super.rapidOperations,
    required super.hidingData,
    required super.number,
    required super.selectedIndex
  });
}

final class TasksFinish extends TasksState {
  const TasksFinish({
    required super.index,
    required super.value,
    required super.hidingData,
    required super.rapidOperations,
    required super.number,
    required super.selectedIndex
  });
}
