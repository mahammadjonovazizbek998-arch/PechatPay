import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pechat_pay/logon/theme/theme_cubit.dart';
import 'package:pechat_pay/presentation/presentation/main_home_peges.dart';
import 'data/theme/theme_class.dart';
import 'logon/login/login_cubit.dart';
import 'logon/tasks/tasks_cubit.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (ctx) => ThemeCubit()),
        BlocProvider(create: (ctx) => LoginCubit()),
        BlocProvider(create: (ctx) => TasksCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 884),
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
                  return MainHomePeges();
                  // if (state is ThemeFinish) {
                  //   return BlocBuilder<LoginCubit, LoginState>(
                  //     builder: (context, stateToken) {
                  //      if (stateToken.token != null) {
                  //         return SinIn();
                  //       } else {
                  //         return MainHomePeges();
                  //       }
                  //     },
                  //   );
                  // } else {
                  //   return CircularIndicator();
                  // }
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
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
