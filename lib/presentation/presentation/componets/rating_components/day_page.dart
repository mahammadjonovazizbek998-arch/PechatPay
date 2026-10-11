import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pechat_pay/data/style/text_form_style.dart';
import 'package:pechat_pay/data/style/text_style.dart';

import 'package:pechat_pay/logon/dashboard/dashboard_cubit.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../data/theme/theme_class.dart';

import 'all_time_unpaid_pechats.dart';
import 'conterin_widget.dart';
import 'pay_conterin_widget.dart';

class DayPage extends StatefulWidget {
  const DayPage({super.key});

  @override
  State<DayPage> createState() => _DayPageState();
}

class _DayPageState extends State<DayPage> {
  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: .start,
          mainAxisSize: .min,
          crossAxisAlignment: .start,
          children: [
            Row(
              children: [
                ConterinWidget(),
                SizedBox(width: 12.w),
                PayConterinWidget(),
              ],
            ),
            SizedBox(height: 14.h),
            AllTimeUnpaidPechats(),
            SizedBox(height: 14.h),
            Container(
              padding: .symmetric(horizontal: 14.w, vertical: 14.h),
              decoration: AppTextFormStyle.container(
                color: myTheme.textColor,
                shadow: true,
                shadowColor: myTheme.text,
              ),
              child: Column(
                mainAxisAlignment: .start,
                crossAxisAlignment: .start,
                mainAxisSize: .min,
                children: [
                  ListTile(
                    title: Text(overflow: .ellipsis,
                      "Smenalar tahlili (Kunduzgi vs Tungi)",
                      maxLines: 1,
                      style: AppTextStyles.style14.copyWith(
                        color: myTheme.text,
                      ),
                    ),
                    leading: Icon(
                      Icons.compare_arrows,
                      color: myTheme.globalColor,
                      size: 19.w,
                      fontWeight: .bold,
                    ),
                    trailing: Container(
                      padding: .symmetric(horizontal: 10.w, vertical: 5.h),
                       decoration: AppTextFormStyle.container( color: myTheme.unselctedColor.withValues(alpha: 0.1),),
                      child: Text("24 soat",style: AppTextStyles.style10.copyWith(color: myTheme.text),),
                    ),
                    minLeadingWidth: 0,
                    horizontalTitleGap: 10.w,
                    contentPadding: .zero,
                  ),
                  SizedBox(
                    height: 35,
                    child: (() {
                      final double shift1Val = (state.statsResponse?.data.shift1?.count ?? 0).toDouble();
                      final double shift2Val = (state.statsResponse?.data.shift2?.count ?? 0).toDouble();

                      return SfCartesianChart(
                        margin: EdgeInsets.zero,
                        plotAreaBorderWidth: 0,
                        primaryXAxis: const CategoryAxis(
                          isVisible: false,
                        ),
                        primaryYAxis: const NumericAxis(
                          isVisible: false,
                        ),
                        series: <CartesianSeries>[
                          StackedBar100Series<_ChartData, String>(
                            dataSource: [_ChartData('Jami', shift1Val, shift2Val)],
                            xValueMapper: (data, _) => data.nomi,
                            yValueMapper: (data, _) => data.kunduz,
                            color: Colors.blue,
                            width: 0.8,
                          ),
                          StackedBar100Series<_ChartData, String>(
                            dataSource: [_ChartData('Jami', shift1Val, shift2Val)],
                            xValueMapper: (data, _) => data.nomi,
                            yValueMapper: (data, _) => data.tungi,
                            color: Colors.indigoAccent,
                            width: 0.8,
                          ),
                        ],
                      );
                    })(),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
class _ChartData {
  final String nomi;
  final double kunduz;
  final double tungi;

  _ChartData(this.nomi, this.kunduz, this.tungi);
}