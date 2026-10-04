part of 'homle_cubit.dart';

@immutable
sealed class HomleState {
  final int currentIndex;
  final HistoryHomePage? historyHomePage;
  final DriverNoactiveResponse? driverNoactiveResponse;
  final PechatCreateResponse? pechatCreateResponse;

  const HomleState({
    required this.currentIndex,
    required this.historyHomePage,
    required this.driverNoactiveResponse,
    required this.pechatCreateResponse,
  });
}

final class HomleInitial extends HomleState {
  const HomleInitial({
    required super.currentIndex,
    required super.historyHomePage,
    required super.driverNoactiveResponse,
    required super.pechatCreateResponse,
  });
}

final class HomleFinish extends HomleState {
  const HomleFinish({
    required super.currentIndex,
    required super.historyHomePage,
    required super.driverNoactiveResponse,
    required super.pechatCreateResponse,
  });
}

final class HomeLoding extends HomleState {
  const HomeLoding({
    required super.currentIndex,
    required super.historyHomePage,
    required super.driverNoactiveResponse,
    required super.pechatCreateResponse,
  });
}

final class HomeError extends HomleState {
  final TokenErorrModel tokenErorrModel;

  const HomeError({
    required super.currentIndex,
    required super.historyHomePage,
    required super.driverNoactiveResponse,
    required this.tokenErorrModel,
    required super.pechatCreateResponse,
  });
}
