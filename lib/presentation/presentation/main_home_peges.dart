
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pechat_pay/presentation/presentation/profile_peges.dart';
import 'package:pechat_pay/presentation/presentation/rating_peges.dart';
import 'package:pechat_pay/presentation/presentation/tasks_peges.dart';

import '../../data/get_it/get_it.dart';
import '../../data/style/text_style.dart';
import '../../data/theme/theme_class.dart';
import '../../logon/bottom_navigation_bar/bottom_navigation_bar_cubit.dart';
import '../../logon/dashboard/dashboard_cubit.dart';
import '../../logon/home/homle_cubit.dart';
import '../../logon/tasks/tasks_cubit.dart';

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
const double kSidebarMinWidth = 800;

class AdaptiveNavScaffold extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;

    // Joriy ekran kengligi logical pixel hisobida olinadi.
    final size = MediaQuery.sizeOf(context);

    // Kichik planshet va telefon: pastki navigatsiya.
    // Katta planshet: chapdagi sidebar.
    final bool useSidebar = size.width >= kSidebarMinWidth;

    if (useSidebar) {
      return Scaffold(
        body: SafeArea(
          child: Row(
            children: [
              Container(
                width: 190,
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

                    for (int i = 0; i < _items.length; i++)
                      Padding(
                        padding: EdgeInsets.only(bottom: 4.h),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8.r),
                          onTap: () => onTap(i),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 10.h,
                            ),
                            decoration: BoxDecoration(
                              color: currentIndex == i
                                  ? myTheme.globalColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  _items[i].$1,
                                  width: _items[i].$3,
                                  height: _items[i].$3,
                                  color: currentIndex == i
                                      ? myTheme.textColor
                                      : myTheme.text.withValues(alpha: 0.8),
                                ),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: Text(
                                    _items[i].$2,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles.style12.copyWith(
                                      color: currentIndex == i
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
                  ],
                ),
              ),

              Expanded(child: body),
            ],
          ),
        ),
      );
    }

    // Telefon va kichik planshet uchun pastki navigatsiya.
    return Scaffold(
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: myTheme.cardColor,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        selectedItemColor: myTheme.globalColor,
        unselectedItemColor: myTheme.text.withValues(alpha: 0.8),
        currentIndex: currentIndex,
        onTap: onTap,
        selectedLabelStyle: AppTextStyles.style12,
        unselectedLabelStyle: AppTextStyles.style12,
        items: [
          for (int i = 0; i < _items.length; i++)
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 2.h, top: 10.h),
                child: Image.asset(
                  _items[i].$1,
                  width: _items[i].$3,
                  height: _items[i].$3,
                  color: currentIndex == i
                      ? myTheme.globalColor
                      : myTheme.text.withValues(alpha: 0.8),
                ),
              ),
              label: _items[i].$2,
            ),
        ],
      ),
    );
  }
}
