import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pechat_pay/data/style/text_style.dart';
import 'package:pechat_pay/logon/bottom_navigation_bar/bottom_navigation_bar_cubit.dart';
import 'package:pechat_pay/presentation/presentation/profile_peges.dart';
import 'package:pechat_pay/presentation/presentation/rating_peges.dart';
import 'package:pechat_pay/presentation/presentation/tasks_peges.dart';

import '../../data/theme/theme_class.dart';
import 'home_peges.dart';

class MainHomePeges extends StatefulWidget {
  const MainHomePeges({super.key});

  @override
  State<MainHomePeges> createState() => _HomePegesState();
}

class _HomePegesState extends State<MainHomePeges> {
  final List<Widget> _pages = <Widget>[
    HomePeges(),
    TasksPeges(),
    RatingPeges(),
    ProfilePeges(),
  ];

  @override
  Widget build(BuildContext childContex) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (childContex) => BottomNavigationBarCubit()),
      ],
      child: Builder(
        builder: (contex) {
          final myTheme = Theme.of(context).extension<ThemeClass>()!;
          return Scaffold(
            body:
                BlocBuilder<BottomNavigationBarCubit, BottomNavigationBarState>(
                  builder: (contex, state) {
                    return _pages[state.currentIndex];
                  },
                ),
            bottomNavigationBar:
                BlocBuilder<BottomNavigationBarCubit, BottomNavigationBarState>(
                  builder: (contex, state) {
                    return BottomNavigationBar(
                      backgroundColor: myTheme.globalBackgroundColor,
                      type: BottomNavigationBarType.fixed,
                      showUnselectedLabels: true,
                      selectedItemColor: myTheme.globalColor,
                      unselectedItemColor: myTheme.unselctedColor,
                      currentIndex: contex
                          .read<BottomNavigationBarCubit>()
                          .state
                          .currentIndex,
                      onTap: (index) {
                        contex.read<BottomNavigationBarCubit>().onTap(index);
                      },selectedLabelStyle: AppTextStyles.style13,unselectedLabelStyle: AppTextStyles.style13,
                      items: [
                        BottomNavigationBarItem(
                          icon: Icon(Icons.home, size: 25.sp),
                          label: "Asosiy",
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.person, size: 25.sp),
                          label: "Guruhlar",
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.person, size: 30.sp),
                          label: "Reyting",
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.person, size: 30.sp),
                          label: "Profil",
                        ),
                      ],
                    );
                  },
                ),
          );
        },
      ),
    );
  }
}
