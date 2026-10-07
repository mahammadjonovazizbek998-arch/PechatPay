import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider.value(value: sl<ThemeCubit>()),
        BlocProvider.value(value: sl<LoginCubit>()),
        BlocProvider.value(value: sl<ProfilCubit>()),
        BlocProvider.value(value: sl<TasksCubit>()),
        BlocProvider.value(value: sl<HomleCubit>()),
        BlocProvider.value(value: sl<BottomNavigationBarCubit>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final shortestSide = MediaQuery.of(context).size.shortestSide;
    final isTablet = shortestSide >= 600;
    return ScreenUtilInit(
      designSize:  isTablet ? const Size(768, 1024) : const Size(390, 884),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            final bool isTheme = state.theme ?? true;
            return MaterialApp(
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
              debugShowCheckedModeBanner: false,
              home: BlocBuilder<ThemeCubit, ThemeState>(
                builder: (ctx, state) {
                  if (state is ThemeFinish) {
                    return BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, stateToken) {
                        if (stateToken is LoginLoding &&
                            stateToken.token != null &&
                            stateToken.token!.token == "") {
                          return const CircularIndicator();
                        } else if (stateToken.token == null ||
                            stateToken.token?.token == "") {
                          return const SinIn();
                        } else {
                          return const MainHomePeges();
                        }
                      },
                    );
                  } else {
                    return const CircularIndicator();
                  }
                },
              ),
            );
          },
        );
      },
    );
  }
}

class CircularIndicator extends StatefulWidget {
  const CircularIndicator({super.key});

  @override
  State<CircularIndicator> createState() => _CircularIndicatorState();
}

class _CircularIndicatorState extends State<CircularIndicator> {
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
