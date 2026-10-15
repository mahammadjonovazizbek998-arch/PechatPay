import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pechat_pay/data/repository/auth.dart';
import 'package:pechat_pay/data/style/text_form_style.dart';

import 'package:pechat_pay/presentation/presentation/profile_peges.dart';
import 'package:pechat_pay/presentation/presentation/rating_peges.dart';
import 'package:pechat_pay/presentation/presentation/tasks_peges.dart';

import '../../data/get_it/get_it.dart';
import '../../data/style/text_style.dart';
import '../../data/theme/theme_class.dart';
import '../../logon/bottom_navigation_bar/bottom_navigation_bar_cubit.dart';
import '../../logon/dashboard/dashboard_cubit.dart';
import '../../logon/home/homle_cubit.dart';
import '../../logon/login/login_cubit.dart';
import '../../logon/tasks/tasks_cubit.dart';

import 'componets/dialog/logout_dialog.dart';

import 'home_peges.dart';

class MainHomePeges extends StatefulWidget {
  const MainHomePeges({super.key});

  @override
  State<MainHomePeges> createState() => _HomePegesState();
}

class _HomePegesState extends State<MainHomePeges> {
  @override
  void initState() {
    super.initState();

    sl<HomleCubit>().historyHomePage(1);
    sl<TasksCubit>().driversPage(null, 1);
    sl<DashboardCubit>().filiallPage();
  }

  final List<Widget> _pages = [
    HomePeges(),
    TasksPeges(),
    RatingPeges(),
    ProfilePeges(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => BottomNavigationBarCubit())],
      child: PopScope(
        child: BlocBuilder<BottomNavigationBarCubit, BottomNavigationBarState>(
          builder: (context, state) {
            return AdaptiveNavScaffold(
              currentIndex: state.currentIndex,
              onTap: (index) {
                context.read<BottomNavigationBarCubit>().onTap(
                  index,
                  state.appProfilPeges,
                );
              },
              body: _pages[state.currentIndex],
            );
          },
        ),
      ),
    );
  }
}

/// Ekran kengligi ushbu qiymatdan kichik bo'lsa,
/// navigatsiya pastda chiqadi.
///
/// 800 logical pixel va undan katta bo'lsa,
/// navigatsiya chap tomonda chiqadi.

class AdaptiveNavScaffold extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final Widget body;

  const AdaptiveNavScaffold({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.body,
  });

  static const List<(String, String, double)> _items = [
    ("assets/img_6.png", "Bosh sahifa", 18),
    ("assets/img_5.png", "Haydovchilar", 18),
    ("assets/img_4.png", "Hisobot", 18),
    ("assets/img_7.png", "Profil", 17.5),
  ];

  @override
  State<AdaptiveNavScaffold> createState() => _AdaptiveNavScaffoldState();
}

class _AdaptiveNavScaffoldState extends State<AdaptiveNavScaffold> {
  double get shortestSide => MediaQuery.sizeOf(context).shortestSide;

  bool get isPhone => shortestSide < 600;

  bool get isSmallTablet => shortestSide >= 600 && shortestSide < 840;

  bool get isTablet => shortestSide >= 840;

  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;

    if (isTablet) {
      return Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          scrolledUnderElevation: 0,
          elevation: 0,
          backgroundColor: myTheme.textColor,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/icons/logo_p_p.png",
                height: 45.h,
                width: 45.w,
              ),
              SizedBox(width: 5.w),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        "Pechat",
                        style: AppTextStyles.style18.copyWith(
                          fontWeight: FontWeight.bold,
                          color: myTheme.globalColor,
                        ),
                      ),
                      Text(
                        "Pay",
                        style: AppTextStyles.style18.copyWith(
                          fontWeight: FontWeight.bold,
                          color: myTheme.text,
                        ),
                      ),
                    ],
                  ),
                  BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state) {
                      if (state.token != null && state.token!.name.isNotEmpty) {
                        return Text(
                          state.token!.name,
                          style: AppTextStyles.style10.copyWith(
                            fontWeight: FontWeight.w400,
                            color: myTheme.text.withValues(alpha: 0.9),
                          ),
                        );
                      } else {
                        return SizedBox();
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
          toolbarHeight: 64.h,
          actions: [
            Container(
              padding: .symmetric(horizontal: 8.w, vertical: 10.h),
              decoration: AppTextFormStyle.container(borderColor: myTheme.globalColor.withValues(alpha: 0.5),
                color:myTheme.globalColor.withValues(alpha: 0.1),
              ),
              child: BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) {
                  return Text(
                    "1 muhr = ${AuthRepository.formatSum(state.token!.stampPrice.toString())} so'm",
                    style: AppTextStyles.style12.copyWith(
                      color: myTheme.globalColor,
                    ),
                  );
                },
              ),
            ),

            SizedBox(width: 10.w),
            InkWell(
              borderRadius: BorderRadius.circular(8.r),
              onTap: () => widget.onTap(3),
              child: CircleAvatar(
                radius: 20.r,
                backgroundColor: widget.currentIndex == 3
                    ? myTheme.globalColor
                    : Colors.transparent,
                child: Image.asset(
                  AdaptiveNavScaffold._items[3].$1,
                  width: AdaptiveNavScaffold._items[3].$3,
                  height: AdaptiveNavScaffold._items[3].$3,
                  color: widget.currentIndex == 3
                      ? myTheme.textColor
                      : myTheme.text,
                ),
              ),
            ),
            SizedBox(width: 10.w),
          ],
        ),
        body: SafeArea(
          child: Row(
            children: [
              Container(
                width: 190.w,
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: myTheme.cardColor,
                  border: Border(
                    right: BorderSide(
                      color: myTheme.text.withValues(alpha: 0.08),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(6.w, 8.h, 6.w, 12.h),
                      child: Text(
                        'OPERATSIYALAR',
                        style: AppTextStyles.style10.copyWith(
                          letterSpacing: 0.5,
                          color: myTheme.text.withValues(alpha: 0.5),
                        ),
                      ),
                    ),

                    for (
                      int i = 0;
                      i < AdaptiveNavScaffold._items.length - 1;
                      i++
                    )
                      Padding(
                        padding: EdgeInsets.only(bottom: 4.h),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8.r),
                          onTap: () => widget.onTap(i),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 10.h,
                            ),
                            decoration: BoxDecoration(
                              color: widget.currentIndex == i
                                  ? myTheme.globalColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  AdaptiveNavScaffold._items[i].$1,
                                  width: AdaptiveNavScaffold._items[i].$3,
                                  height: AdaptiveNavScaffold._items[i].$3,
                                  color: widget.currentIndex == i
                                      ? myTheme.textColor
                                      : myTheme.text.withValues(alpha: 0.8),
                                ),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: Text(
                                    AdaptiveNavScaffold._items[i].$2,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles.style12.copyWith(
                                      color: widget.currentIndex == i
                                          ? myTheme.textColor
                                          : myTheme.text,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(bottom: 4.h),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8.r),
                        onTap: () {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) => LogoutDialog(),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 10.h,
                          ),
                          decoration: AppTextFormStyle.container(
                            borderColor: myTheme.logUot.withValues(alpha: 0.5),
                            color: myTheme.logUot.withValues(alpha: 0.2),
                          ),

                          child: Row(
                            crossAxisAlignment: .center,
                            children: [
                              Icon(
                                Icons.logout,
                                size: 18.w,
                                color: myTheme.logUot,
                              ),
                              SizedBox(width: 8.w),
                              Flexible(
                                child: Text(
                                  "Filial tizimidan chiqish",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.style12.copyWith(
                                    color: myTheme.logUot,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),

              Expanded(child: widget.body),
            ],
          ),
        ),
      );
    } else if (isPhone) {
      return Scaffold(
        body: widget.body,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: myTheme.cardColor,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          selectedItemColor: myTheme.globalColor,
          unselectedItemColor: myTheme.text.withValues(alpha: 0.8),
          currentIndex: widget.currentIndex,
          onTap: widget.onTap,
          selectedLabelStyle: AppTextStyles.style12,
          unselectedLabelStyle: AppTextStyles.style12,
          items: [
            for (int i = 0; i < AdaptiveNavScaffold._items.length ; i++)
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 2.h, top: 10.h),
                  child: Image.asset(
                    AdaptiveNavScaffold._items[i].$1,
                    width: AdaptiveNavScaffold._items[i].$3,
                    height: AdaptiveNavScaffold._items[i].$3,
                    color: widget.currentIndex == i
                        ? myTheme.globalColor
                        : myTheme.text.withValues(alpha: 0.8),
                  ),
                ),
                label: AdaptiveNavScaffold._items[i].$2,
              ),
          ],
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          scrolledUnderElevation: 0,
          elevation: 0,
          backgroundColor: myTheme.textColor,
          titleSpacing: 0,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 90.w,
                height: 60.h,
                decoration: BoxDecoration(
                  color: myTheme.cardColor,
                  border: Border(
                    right: BorderSide(
                      color: myTheme.text.withValues(alpha: 0.3),
                    ),
                  ),
                ),
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/icons/logo_p_p.png",
                  width: 50.w,
                  height: 50.h,
                  fit: BoxFit.contain,
                ),
              ),

              SizedBox(width: 16.w),
              BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) {
                  return SizedBox(
                    height: 24.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      textBaseline: .ideographic,
                      children: [
                        Text(
                          "Pechat",
                          style: AppTextStyles.style18.copyWith(
                            fontWeight: FontWeight.bold,
                            color: myTheme.globalColor,
                          ),
                        ),
                        Text(
                          "Pay",
                          style: AppTextStyles.style18.copyWith(
                            fontWeight: FontWeight.bold,
                            color: myTheme.text,
                          ),
                        ),
                        VerticalDivider(
                          color: myTheme.text.withValues(alpha: 0.3),
                        ),
                        Image.asset(
                          "assets/shop.png",
                          height: 15.h,
                          width: 15.w,
                        ),
                        SizedBox(width: 5.w),
                        if (state.token != null && state.token!.name.isNotEmpty)
                          Flexible(
                            child: Text(
                              maxLines: 1,
                              overflow: .ellipsis,
                              state.token!.name,
                              style: AppTextStyles.style10.copyWith(
                                fontWeight: FontWeight.w400,
                                color: myTheme.text.withValues(alpha: 0.9),
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
          toolbarHeight: 60.h,
          actions: [
            InkWell(
              borderRadius: BorderRadius.circular(8.r),
              onTap: () => widget.onTap(3),
              child: CircleAvatar(
                radius: 18.r,
                backgroundColor: widget.currentIndex == 3
                    ? myTheme.globalColor
                    : Colors.transparent,
                child: Image.asset(
                  AdaptiveNavScaffold._items[3].$1,
                  width: AdaptiveNavScaffold._items[3].$3,
                  height: AdaptiveNavScaffold._items[3].$3,
                  color: widget.currentIndex == 3
                      ? myTheme.textColor
                      : myTheme.text,
                ),
              ),
            ),
            SizedBox(width: 10.w),
          ],
        ),
        body: SafeArea(
          child: Row(
            children: [
              Container(
                width: 90.w,
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: myTheme.cardColor,
                  border: Border(
                    right: BorderSide(
                      color: myTheme.text.withValues(alpha: 0.3),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (
                      int i = 0;
                      i < AdaptiveNavScaffold._items.length - 1;
                      i++
                    )
                      Padding(
                        padding: EdgeInsets.only(bottom: 4.h),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8.r),
                          onTap: () => widget.onTap(i),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 10.h,
                            ),
                            decoration: BoxDecoration(
                              color: widget.currentIndex == i
                                  ? myTheme.globalColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Column(
                              crossAxisAlignment: .center,
                              children: [
                                Image.asset(
                                  AdaptiveNavScaffold._items[i].$1,
                                  width: AdaptiveNavScaffold._items[i].$3,
                                  height: AdaptiveNavScaffold._items[i].$3,
                                  color: widget.currentIndex == i
                                      ? myTheme.textColor
                                      : myTheme.text.withValues(alpha: 0.8),
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  AdaptiveNavScaffold._items[i].$2,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.style12.copyWith(
                                    color: widget.currentIndex == i
                                        ? myTheme.textColor
                                        : myTheme.text,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(bottom: 4.h),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8.r),
                        onTap: () {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) => LogoutDialog(),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 10.h,
                          ),
                          decoration: AppTextFormStyle.container(
                            borderColor: myTheme.logUot.withValues(alpha: 0.5),
                            color: myTheme.logUot.withValues(alpha: 0.2),
                          ),

                          child: Column(
                            crossAxisAlignment: .center,
                            children: [
                              Icon(
                                Icons.logout,
                                size: 18.w,
                                color: myTheme.logUot,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                "Filial tizimidan chiqish",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.style12.copyWith(
                                  color: myTheme.logUot,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                  ],
                ),
              ),

              Expanded(child: widget.body),
            ],
          ),
        ),
      );
    }
  }
}
