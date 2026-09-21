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
  final List<Widget> _pages = [
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
          return PopScope(
            child: Scaffold(
              body:
                  BlocBuilder<
                    BottomNavigationBarCubit,
                    BottomNavigationBarState
                  >(
                    builder: (contex, state) {
                      return _pages[state.currentIndex];
                    },
                  ),
              bottomNavigationBar:
                  BlocBuilder<
                    BottomNavigationBarCubit,
                    BottomNavigationBarState
                  >(
                    builder: (contex, state) {
                      return BottomNavigationBar(
                        backgroundColor: myTheme.cardColor,
                        type: BottomNavigationBarType.fixed,
                        showUnselectedLabels: true,
                        selectedItemColor: myTheme.globalColor,
                        unselectedItemColor: myTheme.text.withValues(
                          alpha: 0.8,
                        ),
                        currentIndex: contex
                            .read<BottomNavigationBarCubit>()
                            .state
                            .currentIndex,
                        onTap: (index) {
                          contex.read<BottomNavigationBarCubit>().onTap(
                            index,
                            state.appProfilPeges,
                          );
                        },
                        selectedLabelStyle: AppTextStyles.style12,
                        unselectedLabelStyle: AppTextStyles.style12,

                        items: [
                          BottomNavigationBarItem(
                            icon: Padding(
                              padding: EdgeInsets.only(bottom: 2.h, top: 10.h),
                              child: Image.asset(
                                "assets/img_6.png",
                                width: 18.w,
                                height: 18.h,
                                color: state.currentIndex == 0
                                    ? myTheme.globalColor
                                    : myTheme.text.withValues(alpha: 0.8),
                              ),
                            ),
                            label: "Bosh sahifa",
                          ),
                          BottomNavigationBarItem(
                            icon: Padding(
                              padding: EdgeInsets.only(bottom: 2.h, top: 10.h),
                              child: Image.asset(
                                "assets/img_5.png",
                                width: 18.w,
                                height: 18.h,
                                color: state.currentIndex == 1
                                    ? myTheme.globalColor
                                    : myTheme.text.withValues(alpha: 0.8),
                              ),
                            ),
                            label: "Haydovchilar",
                          ),
                          BottomNavigationBarItem(
                            icon: Padding(
                              padding: EdgeInsets.only(bottom: 2.h, top: 10.h),
                              child: Image.asset(
                                "assets/img_4.png",
                                width: 18.w,
                                height: 18.h,
                                color: state.currentIndex == 2
                                    ? myTheme.globalColor
                                    : myTheme.text.withValues(alpha: 0.8),
                              ),
                            ),
                            label: "Hisobot",
                          ),
                          BottomNavigationBarItem(
                            icon: Padding(
                              padding: EdgeInsets.only(bottom: 2.h, top: 10.h),
                              child: Image.asset(
                                "assets/img_7.png",
                                width: 17.5.w,
                                height: 17.5.h,
                                color: state.currentIndex == 3
                                    ? myTheme.globalColor
                                    : myTheme.text.withValues(alpha: 0.8),
                              ),
                            ),
                            label: "Profil",
                          ),
                        ],
                      );
                    },
                  ),
            ),
          );
        },
      ),
    );
  }
}
