import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pechat_pay/data/style/text_form_style.dart';
import 'package:pechat_pay/data/style/text_style.dart';
import 'package:pechat_pay/logon/dashboard/dashboard_cubit.dart';

import '../../data/theme/theme_class.dart';
import '../../logon/dashboard/dashboard_state.dart';
import 'componets/app_bar_widget.dart';
import 'componets/profil/filter_button.dart';
import 'componets/rating_components/data_widget.dart';
import 'componets/rating_components/day_page.dart';

import 'componets/rating_components/statistics.dart';
import 'componets/rating_components/top_drivers_card.dart';
import 'componets/taxis/chip_widget.dart';

class RatingPeges extends StatefulWidget {
  const RatingPeges({super.key});

  @override
  State<RatingPeges> createState() => _RatingPegesState();
}

class _RatingPegesState extends State<RatingPeges> {
  String name() {
    final state = context.read<DashboardCubit>().state;
    final branchName = state.filiallPagel.isNotEmpty && state.index < state.filiallPagel.length
        ? state.filiallPagel[state.index].name
        : "";

    final displayName = state.index == 0
        ? branchName
        : "$branchName filiallar bo'yicha";

    if (state.chip[4].selected == true) {
      return "$displayName 1 kunlik hisob: Kunduzgi smena, Tungi smena";
    } else if (state.chip[3].selected == true) {
      return "$displayName 1 haftalik hisob (Dushanba – Yakshanba)";
    } else if (state.chip[2].selected == true) {
      return '$displayName 1 oylik hisob';
    } else if (state.chip[1].selected == true) {
      return '$displayName 1 yillik hisob';
    } else {
      return '$displayName Barcha vaqt bo\'yicha umumiy hisob';
    }
  }

  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;
    final style = AppTextStyles.style12.copyWith(color: myTheme.text);
    final lineHeight = (style.fontSize ?? 12) * (style.height ?? 1.3);

    return Scaffold(
      appBar: AppBarWidget(),
      body: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                sliver: SliverMainAxisGroup(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                        decoration: AppTextFormStyle.container(
                          color: myTheme.textColor,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: DashboardButton(
                                    onFilterSelected: (value) => context
                                        .read<DashboardCubit>()
                                        .onTap(int.parse(value), null),
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                SizedBox(
                                  width: 44.w,
                                  height: 44.h,
                                  child: ElevatedButton(
                                    style: AppTextFormStyle.buttonStyleBorder(
                                      background: myTheme.text.withValues(alpha: 0.1),
                                      foreground: myTheme.text.withValues(alpha: 0.9),
                                      padding: true,
                                    ),
                                    onPressed: () => context.read<DashboardCubit>().filiallPage(),
                                    child: Icon(
                                      Icons.refresh,
                                      color: myTheme.text,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: lineHeight,
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Icon(
                                      state.chip[4].selected == true
                                          ? Icons.access_time
                                          : Icons.calendar_month_outlined,
                                      color: myTheme.globalColor,
                                      size: 15.w,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 2.w),
                                Flexible(
                                  child: Text(
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    name(),
                                    style: AppTextStyles.style12.copyWith(
                                      color: myTheme.text,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(child: SizedBox(height: 12.h)),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 40.h,
                        child: ListView.separated(
                          itemCount: state.chip.length,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              child: ChipWidget(
                                name: state.chip[index].name,
                                isSelected: state.chip[index].selected,
                                onTap: () => context.read<DashboardCubit>().onTap(
                                  null,
                                  index,
                                ),
                              ),
                            );
                          },
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(width: 8.w);
                          },
                        ),
                      ),
                    ),
                    if (state.chip[0].selected != true)
                      SliverToBoxAdapter(child: SizedBox(height: 12.h)),
                    if (state.chip[0].selected != true)
                      SliverToBoxAdapter(child: DataWidget()),
                    if (state.chip[4].selected == true) ...[
                      SliverToBoxAdapter(child: SizedBox(height: 12.h)),
                      SliverToBoxAdapter(child: DayPage()),
                    ],
                    SliverToBoxAdapter(child: SizedBox(height: 12.h)),
                    SliverToBoxAdapter(child: Statistics()),
                    SliverToBoxAdapter(child: SizedBox(height: 12.h)),
                    SliverToBoxAdapter(child: TopDriversCard()),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}