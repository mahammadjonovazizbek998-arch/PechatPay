import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pechat_pay/data/repository/auth.dart';
import 'package:pechat_pay/data/style/text_style.dart';
import 'package:pechat_pay/logon/dashboard/dashboard_cubit.dart';
import 'package:pechat_pay/presentation/presentation/componets/list_tile.dart';

import 'package:pechat_pay/presentation/presentation/componets/rating_components/pedhat_bar_chart.dart';

import '../../../../data/dashboar_model/all_dashboar_model.dart';
import '../../../../data/style/text_form_style.dart';
import '../../../../data/theme/theme_class.dart';
import '../../../../logon/dashboard/dashboard_state.dart';


class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  Future<List<PaymentTrendItem>> payment() async {
    final state = context.read<DashboardCubit>().state;

    final List<PaymentTrendItem> list = state.statsResponse!.data.paymentTrend
        .where((e) => e.summa != 0)
        .toList();

    return list;
  }

  Future<List<PechatTrendItem>> pechat() async {
    final state = context.read<DashboardCubit>().state;
    final List<PechatTrendItem> list = state.statsResponse!.data.pechatTrend
        .where((e) => e.summa != 0)
        .toList();
    return list;
  }

  int paymentIndex() {
    final state = context.read<DashboardCubit>().state;
    final paymentTrend = state.statsResponse!.data.paymentTrend;

    final int ortacha = paymentTrend.isEmpty
        ? 0
        : (paymentTrend.fold<int>(0, (sum, item) => sum + item.pechatCount) /
        paymentTrend.length)
        .round();
    return ortacha;
  }

  int pechatIndex() {
    final state = context.read<DashboardCubit>().state;
    final pechatTrend = state.statsResponse!.data.pechatTrend;

    final int ortachaPechat = pechatTrend.isEmpty
        ? 0
        : (pechatTrend.fold<int>(0, (sum, item) => sum + item.count) /
        pechatTrend.length)
        .round();
    return ortachaPechat;
  }

  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        final data = state.statsResponse!.data;
        final isPechat = state.statisticsBool;
        final Color mainColor = isPechat
            ?myTheme.phonColor: myTheme.globalColor;

        final List<int> pichatIndex = AuthRepository.findPeakIndexes(
          data.pechatTrend,
          data.paymentTrend,
        );
        final List<int> peyIndex = AuthRepository.findPaymentPeakIndexes(
          data.paymentTrend,
          data.pechatTrend,
        );

        String peakText = "--";
        if (isPechat) {
          if (pichatIndex.isNotEmpty) {
            final e = data.pechatTrend[pichatIndex[0]];
            peakText = "${e.label} (${e.count} ta)";
          }
        } else {
          if (peyIndex.isNotEmpty) {
            final e = data.paymentTrend[peyIndex[0]];
            peakText = "${e.label} (${e.pechatCount} ta)";
          }
        }

        return Container(
          padding: .symmetric(vertical: 14.h, horizontal: 14.w),
          decoration: AppTextFormStyle.container(
            color: myTheme.textColor,
            shadow: true,
            shadowColor: myTheme.text,
          ),
          child: Column(
            children: [
              // ---------- Sarlavha ----------
              ListTileWidget(
                peding: true,
                selected: Text(
                  "24 soatlik dinamika",
                  style: AppTextStyles.style14.copyWith(
                    color: myTheme.text,
                    fontWeight: .bold,
                  ),
                ),
                unselected: Text(
                  "Smena soatlari bo'yicha tahlil",
                  style: AppTextStyles.style10.copyWith(color: myTheme.text),
                ),
                leading: ContainerWidget(
                  vertical: 46.h,
                  horizontal: 44.w,
                  assets: "assets/img.png",
                  assetsHorizontal: 16.75,
                  assetsVertical: 17.5,
                  assetsColor: myTheme.globalColor,
                  boxDecoration: AppTextFormStyle.container(
                    borderColor: myTheme.globalColor.withValues(alpha: 0.1),
                    color: myTheme.globalColor.withValues(alpha: 0.1),
                  ),
                ),
                trailing: Container(
                  padding: .symmetric(vertical: 5.h, horizontal: 10.h),
                  decoration: AppTextFormStyle.container(
                    color: myTheme.unselctedColor.withValues(alpha: 0.1),
                  ),
                  child: Row(
                    mainAxisSize: .min,
                    children: [
                      Icon(Icons.access_time, color: myTheme.text, size: 14.w),
                      SizedBox(width: 2.w),
                      Text(
                        "${state.filiallPagel[state.index].shift1Start.substring(0, 5)}-${state.filiallPagel[state.index].shift2End.substring(0, 5)}",
                        style: AppTextStyles.style10.copyWith(
                          color: myTheme.text,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ---------- Pechatlash / Naqdlashtirish tugmalari ----------
              Container(
                padding: .symmetric(vertical: 3.h, horizontal: 3.w),
                margin: .symmetric(vertical: 10.h),
                decoration: AppTextFormStyle.container(
                  color: myTheme.unselctedCardColor.withValues(alpha: 0.7),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 48.h,
                        child: ElevatedButton(
                          style: AppTextFormStyle.buttonStyleBorder(
                            button: true,
                            padding: true,
                            background: state.statisticsBool
                                ? myTheme.globalColor.withValues(alpha: 0.1)
                                : myTheme.unselctedCardColor.withValues(
                              alpha: 0.6,
                            ),
                            foreground: state.statisticsBool
                                ? myTheme.globalColor
                                : myTheme.text,
                          ),
                          onPressed: () {
                            context.read<DashboardCubit>().statisticsPage(true);
                          },
                          child: Row(
                            mainAxisSize: .min,
                            children: [
                              Image.asset(
                                "assets/stamp.png",
                                width: 16.w,
                                color: state.statisticsBool
                                    ? myTheme.globalColor
                                    : myTheme.text,
                              ),
                              Text(
                                " Pechatlash",
                                style: AppTextStyles.style12.copyWith(
                                  color: state.statisticsBool
                                      ? myTheme.globalColor
                                      : myTheme.text,
                                ),
                              ),
                              SizedBox(width: 5.w),
                              Container(
                                decoration: BoxDecoration(
                                  color: myTheme.phonColor.withValues(
                                    alpha: 0.1,
                                  ),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                padding: .symmetric(
                                  vertical: 5.h,
                                  horizontal: 10.w,
                                ),
                                child: Text(
                                  data.summary.count.toString(),
                                  style: AppTextStyles.style12.copyWith(
                                    color: myTheme.phonColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 48.h,
                        child: ElevatedButton(
                          style: AppTextFormStyle.buttonStyleBorder(
                            button: true,
                            padding: true,
                            background: state.statisticsBool
                                ? myTheme.unselctedCardColor.withValues(
                              alpha: 0.6,
                            )
                                : myTheme.globalColor.withValues(alpha: 0.1),
                            foreground: state.statisticsBool
                                ? myTheme.text
                                : myTheme.globalColor,
                          ),
                          onPressed: () {
                            context.read<DashboardCubit>().statisticsPage(
                              false,
                            );
                          },
                          child: Row(
                            mainAxisSize: .min,
                            children: [
                              Image.asset(
                                "assets/money.png",
                                width: 16.w,
                                color: state.statisticsBool
                                    ? myTheme.text
                                    : myTheme.globalColor,
                              ),
                              Flexible(
                                child: Text(
                                  maxLines: 1,
                                  overflow: .ellipsis,
                                  " Naqdlashtirish",
                                  style: AppTextStyles.style12,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                data.summary.paymentPechatCount.toString(),
                                style: AppTextStyles.style12.copyWith(
                                  color: myTheme.logUot.withValues(alpha: 0.7),
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
              SizedBox(height: 7.h),

              // ---------- Sarlavha va Pik ----------
              Row(
                crossAxisAlignment: .center,
                mainAxisAlignment: .spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: .center,
                    mainAxisSize: .min,
                    children: [
                      CircleAvatar(backgroundColor: mainColor, radius: 8.r),
                      SizedBox(width: 4.w),
                      Text(
                        isPechat
                            ? "Soatbay berilgan muhrlar"
                            : "Soatbay naqdlashtirilgan muhrlar",
                        style: AppTextStyles.style12.copyWith(
                          color: myTheme.text,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: .symmetric(horizontal: 8.w, vertical: 8.h),
                    decoration: AppTextFormStyle.container(
                      color: mainColor.withValues(alpha: 0.1),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.trending_up, size: 14.w, color: mainColor),
                        SizedBox(width: 2.w),
                        Text(
                          "Pik: $peakText",
                          style: AppTextStyles.style10.copyWith(
                            color: mainColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14.h),

              // ---------- Diagramma ----------
              Container(
                decoration: AppTextFormStyle.container(
                  color: myTheme.unselctedColor.withValues(alpha: 0.2),
                ),
                padding: .symmetric(vertical: 10.h, horizontal: 10.w),
                child: const PechatBarChart(),
              ),
            ],
          ),
        );
      },
    );
  }
}
