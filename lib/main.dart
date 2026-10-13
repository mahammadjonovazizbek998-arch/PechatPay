import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pechat_pay/logon/dashboard/dashboard_cubit.dart';
import 'package:pechat_pay/logon/theme/theme_cubit.dart';
import 'package:pechat_pay/presentation/presentation/main_home_peges.dart';
import 'package:pechat_pay/presentation/sin_in/sin_in.dart';

import 'data/get_it/get_it.dart';
import 'data/theme/theme_class.dart';
import 'logon/bottom_navigation_bar/bottom_navigation_bar_cubit.dart';
import 'logon/home/homle_cubit.dart';
import 'logon/login/login_cubit.dart';
import 'logon/profil/profil_cubit.dart';
import 'logon/tasks/tasks_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupServiceLocator();

  // Telefon portret holatida qoladi.
  // Planshet erkin aylanishi mumkin.
  final view = WidgetsBinding.instance.platformDispatcher.views.first;
  final shortest = view.physicalSize.shortestSide / view.devicePixelRatio;

  if (shortest < 600) {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider.value(value: sl<ThemeCubit>()),
        BlocProvider.value(value: sl<LoginCubit>()),
        BlocProvider.value(value: sl<ProfilCubit>()),
        BlocProvider.value(value: sl<TasksCubit>()),
        BlocProvider.value(value: sl<HomleCubit>()),
        BlocProvider.value(value: sl<BottomNavigationBarCubit>()),
        BlocProvider.value(value: sl<DashboardCubit>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Katta planshet uchun UI masshtabi.
  static const double _tabletScale = 1.25;



  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    final shortestSide = size.shortestSide;

    final bool isPhone = shortestSide < 600;

    final Size designSize = isPhone
        ? const Size(390, 884)
        : Size(size.width / _tabletScale, size.height / _tabletScale);

    return ScreenUtilInit(
      designSize: designSize,
      minTextAdapt: false,
      splitScreenMode: false,
      builder: (context, child) {
        return BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            final bool isTheme = state.theme ?? true;

            return MaterialApp(
              debugShowCheckedModeBanner: false,

              builder: (context, child) {
                final mq = MediaQuery.of(context);

                return MediaQuery(
                  data: mq.copyWith(
                    textScaler: mq.textScaler.clamp(
                      minScaleFactor: 0.9,
                      maxScaleFactor: 1.1,
                    ),
                  ),
                  child: child!,
                );
              },

              themeMode: isTheme ? ThemeMode.light : ThemeMode.dark,

              theme: ThemeData(
                useMaterial3: true,
                brightness: Brightness.light,
                colorSchemeSeed: lightCustom.globalColor,
                scaffoldBackgroundColor: lightCustom.globalBackgroundColor,
                extensions: [lightCustom],
              ),

              darkTheme: ThemeData(
                useMaterial3: true,
                brightness: Brightness.dark,
                colorSchemeSeed: darkCustom.globalColor,
                scaffoldBackgroundColor: darkCustom.globalBackgroundColor,
                extensions: [darkCustom],
              ),

              home: BlocBuilder<ThemeCubit, ThemeState>(
                builder: (ctx, state) {
                  if (state is! ThemeFinish) {
                    return const CircularIndicator();
                  }

                  return BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, stateToken) {
                      if (stateToken is LoginLoding &&
                          stateToken.token != null &&
                          stateToken.token!.token == '') {
                        return const CircularIndicator();
                      }

                      if (stateToken.token == null ||
                          stateToken.token?.token == '') {
                        return const SinIn();
                      }

                      return MainHomePeges(
                        // Bu parametrni qabul qilish uchun
                        // MainHomePeges konstruktorini ham
                        // o'zgartirish kerak bo'lishi mumkin.
                      );
                    },
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}

class CircularIndicator extends StatelessWidget {
  const CircularIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;

    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: myTheme.globalColor.withValues(alpha: 0.7),
        ),
      ),
    );
  }
}
