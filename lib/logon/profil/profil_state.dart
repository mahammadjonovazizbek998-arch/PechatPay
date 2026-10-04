part of 'profil_cubit.dart';

@immutable
sealed class ProfilState {
  final bool password1;
  final bool password2;
  final bool password3;
  final String? shift1Start;
  final String? shift1End;
  final String? shift2Start;
  final String? shift2End;
  final int stampPauseHours;
  final List<TokenModelApiUserModel> filiallPagel;
  final DriverNoactiveResponse? driverNoactiveModel;
  final String day;

  const ProfilState({
    required this.password1,
    required this.password2,
    required this.password3,
    required this.shift1Start,
    required this.shift1End,
    required this.shift2Start,
    required this.shift2End,
    required this.stampPauseHours,
    required this.filiallPagel,
    required this.driverNoactiveModel,
    required this.day,
    re
  });
}

final class ProfilInitial extends ProfilState {
  const ProfilInitial({
    required super.password1,
    required super.password2,
    required super.password3,
    required super.shift2Start,
    required super.shift2End,
    required super.shift1Start,
    required super.shift1End,
    required super.stampPauseHours,
    required super.filiallPagel,
    required super.driverNoactiveModel,
    required super.day

  });
}

final class ProfilLoding extends ProfilState {
  const ProfilLoding({
    required super.password1,
    required super.password2,
    required super.password3,
    required super.shift1Start,
    required super.shift1End,
    required super.shift2Start,
    required super.shift2End,
    required super.stampPauseHours,
    required super.filiallPagel,
    required super.driverNoactiveModel,
    required super.day
  });
}

final class ProfilFinish extends ProfilState {
  const ProfilFinish({
    required super.password1,
    required super.password2,
    required super.password3,
    required super.shift1Start,
    required super.shift1End,
    required super.shift2Start,
    required super.shift2End,
    required super.stampPauseHours,
    required super.filiallPagel,
    required super.driverNoactiveModel,
    required super.day
  });
}

final class ProfilError extends ProfilState {
  final TokenErorrModel tokenErorrModel;

  const ProfilError({
    required super.password1,
    required super.password2,
    required super.password3,
    required super.shift1Start,
    required super.shift1End,
    required super.shift2Start,
    required super.shift2End,
    required super.stampPauseHours,
    required super.filiallPagel,
    required this.tokenErorrModel,
    required super.driverNoactiveModel,
    required super.day
  });
}
