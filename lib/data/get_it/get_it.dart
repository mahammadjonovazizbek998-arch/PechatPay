import 'package:get_it/get_it.dart';
import 'package:pechat_pay/logon/bottom_navigation_bar/bottom_navigation_bar_cubit.dart';
import 'package:pechat_pay/logon/home/homle_cubit.dart';
import 'package:pechat_pay/logon/profil/profil_cubit.dart';
import 'package:pechat_pay/logon/tasks/tasks_cubit.dart';
import 'package:pechat_pay/logon/theme/theme_cubit.dart';

import '../../logon/login/login_cubit.dart';

final GetIt sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  sl.registerLazySingleton<ThemeCubit>(() => ThemeCubit());
  sl.registerLazySingleton<LoginCubit>(() => LoginCubit());
  sl.registerLazySingleton<ProfilCubit>(() => ProfilCubit());
  sl.registerLazySingleton<TasksCubit>(() => TasksCubit());
  sl.registerLazySingleton<HomleCubit>(() => HomleCubit());
  sl.registerLazySingleton<BottomNavigationBarCubit>(
    () => BottomNavigationBarCubit(),
  );
}
