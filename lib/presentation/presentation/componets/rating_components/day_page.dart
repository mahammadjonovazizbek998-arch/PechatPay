import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pechat_pay/data/style/text_form_style.dart';
import 'package:pechat_pay/data/style/text_style.dart';
import 'package:pechat_pay/logon/dashboard/dashboard_cubit.dart';
import 'package:pechat_pay/presentation/presentation/componets/rating_components/all_time_unpaid_pechats.dart';
import 'package:pechat_pay/presentation/presentation/componets/rating_components/pay_conterin_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../data/repository/auth.dart';
import '../../../../data/theme/theme_class.dart';

import '../../../../logon/dashboard/dashboard_state.dart';
import 'conterin_widget.dart';

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
        final data = state.statsResponse?.data;

        // API dan kelgan count qiymatlari
        final double shift1Val = (data?.shift1?.count ?? 0).toDouble();

        final double shift2Val = (data?.shift2?.count ?? 0).toDouble();

        // Jami muhrlar
        final double jami = shift1Val + shift2Val;

        // Foizlar
        final double shift1Foiz = jami == 0 ? 0 : shift1Val / jami * 100;

        final double shift2Foiz = jami == 0 ? 0 : shift2Val / jami * 100;

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(child: ConterinWidget()),
                SizedBox(width: 12.w),
                Flexible(child: PayConterinWidget()),
              ],
            ),

            SizedBox(height: 14.h),

            AllTimeUnpaidPechats(),

            SizedBox(height: 14.h),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
              decoration: AppTextFormStyle.container(
                color: myTheme.textColor,
                shadow: true,
                shadowColor: myTheme.text,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text(
                      'Smenalar tahlili (Kunduzgi vs Tungi)',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: AppTextStyles.style14.copyWith(
                        color: myTheme.text,
                      ),
                    ),
                    leading: Icon(
                      Icons.compare_arrows,
                      color: myTheme.globalColor,
                      size: 19.w,
                      fontWeight: FontWeight.bold,
                    ),
                    trailing: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 5.h,
                      ),
                      decoration: AppTextFormStyle.container(
                        color: myTheme.unselctedColor.withValues(alpha: 0.1),
                      ),
                      child: Text(
                        '24 soat',
                        style: AppTextStyles.style10.copyWith(
                          color: myTheme.text,
                        ),
                      ),
                    ),
                    minLeadingWidth: 0,
                    horizontalTitleGap: 10.w,
                    contentPadding: EdgeInsets.zero,
                  ),

                  // Ikki rangli foizli grafik
                  SizedBox(
                    height: 30.h,
                    child: jami == 0
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12.r),
                            child: Container(
                              color: myTheme.unselctedColor.withValues(
                                alpha: 0.15,
                              ),
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(12.r),
                            child: SfCartesianChart(
                              margin: EdgeInsets.zero,
                              plotAreaBorderWidth: 0,
                              primaryXAxis: const CategoryAxis(
                                isVisible: false,
                              ),
                              primaryYAxis: const NumericAxis(isVisible: false),
                              series: <CartesianSeries>[
                                StackedBar100Series<_ChartData, String>(
                                  dataSource: [
                                    _ChartData('Jami', shift1Val, shift2Val),
                                  ],
                                  xValueMapper: (d, _) => d.nomi,
                                  yValueMapper: (d, _) => d.kunduz,
                                  color: Colors.indigoAccent,
                                  width: 0.8,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12.r),
                                    bottomLeft: Radius.circular(12.r),
                                  ),
                                ),
                                StackedBar100Series<_ChartData, String>(
                                  dataSource: [
                                    _ChartData('Jami', shift1Val, shift2Val),
                                  ],
                                  xValueMapper: (d, _) => d.nomi,
                                  yValueMapper: (d, _) => d.tungi,
                                  color: Colors.blue,
                                  width: 0.8,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(12.r),
                                    bottomRight: Radius.circular(12.r),
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),

                  SizedBox(height: 8.h),

                  // Foiz ko'rsatkichlari
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 10.w,
                            height: 10.h,
                            decoration: BoxDecoration(
                              color: Colors.indigoAccent,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            'Kunduzgi '
                            '${shift1Foiz.toStringAsFixed(0)}%',
                            style: AppTextStyles.style10.copyWith(
                              color: myTheme.text,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 10.w,
                            height: 10.h,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            'Tungi '
                            '${shift2Foiz.toStringAsFixed(0)}%',
                            style: AppTextStyles.style10.copyWith(
                              color: myTheme.text,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 10.h,
                            horizontal: 10.w,
                          ),
                          decoration: AppTextFormStyle.container(
                            color: myTheme.unselctedColor.withValues(
                              alpha: 0.1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 1-smena vaqti
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.wb_sunny_outlined,
                                        size: 15.sp,
                                        color: myTheme.globalColor,
                                      ),
                                      SizedBox(width: 4.w),
                                      Text(
                                        "1-smena",
                                        style: AppTextStyles.style10.copyWith(
                                          color: myTheme.text,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${state.filiallPagel[state.index].shift1Start.substring(0, 5)}–"
                                    "${state.filiallPagel[state.index].shift1End.substring(0, 5)}",
                                    style: AppTextStyles.style10.copyWith(
                                      color: myTheme.text,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 8.h),

                              // Berilgan muhrlar
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Berilgan:",
                                    style: AppTextStyles.style10.copyWith(
                                      color: myTheme.text,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "${state.statsResponse!.data.shift1!.count} ta",
                                        style: AppTextStyles.style12.copyWith(
                                          color: myTheme.text,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "(${AuthRepository.formatSum(state.statsResponse!.data.shift1!.summa.toString())} so'm)",
                                        style: AppTextStyles.style10.copyWith(
                                          color: myTheme.globalColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              SizedBox(height: 6.h),

                              // Haydovchilar soni
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Haydovchilar:",
                                    style: AppTextStyles.style10.copyWith(
                                      color: myTheme.text,
                                    ),
                                  ),
                                  Text(
                                    "${state.statsResponse!.data.shift1!.uniqueDriversCount} ta",
                                    style: AppTextStyles.style12.copyWith(
                                      color: myTheme.text,
                                    ),
                                  ),
                                ],
                              ),

                              Divider(
                                height: 16.h,
                                color: myTheme.text.withValues(alpha: 0.1),
                              ),

                              // Naqdlashtirilgan muhrlar
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      "Naqdlashtirilgan:",
                                      style: AppTextStyles.style10.copyWith(
                                        color: myTheme.text,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "${state.statsResponse!.data.shift1!.paymentPechatCount} ta",
                                        style: AppTextStyles.style12.copyWith(
                                          color: myTheme.logUot,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "(${AuthRepository.formatSum(state.statsResponse!.data.shift1!.paymentSumma.toString())} so'm)",
                                        style: AppTextStyles.style10.copyWith(
                                          color: myTheme.logUot,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              SizedBox(height: 6.h),

                              // To'lovlar soni
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "To'lovlar soni:",
                                    style: AppTextStyles.style10.copyWith(
                                      color: myTheme.text,
                                    ),
                                  ),
                                  Text(
                                    "${state.statsResponse!.data.shift1!.paymentCount} ta",
                                    style: AppTextStyles.style12.copyWith(
                                      color: myTheme.text,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 6.h),

                              // To'lov qilgan noyob haydovchilar
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Noyob haydchilar:",
                                    style: AppTextStyles.style10.copyWith(
                                      color: myTheme.text,
                                    ),
                                  ),
                                  Text(
                                    "${state.statsResponse!.data.shift1!.paymentUniqueDriversCount} ta",
                                    style: AppTextStyles.style12.copyWith(
                                      color: myTheme.text,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),

                      Flexible(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 10.h,
                            horizontal: 10.w,
                          ),
                          decoration: AppTextFormStyle.container(
                            color: myTheme.unselctedColor.withValues(
                              alpha: 0.1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // 2-smena vaqti
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.nights_stay_outlined,
                                        size: 15.sp,
                                        color: myTheme.globalColor,
                                      ),
                                      SizedBox(width: 4.w),
                                      Text(
                                        "2-smena",
                                        style: AppTextStyles.style10.copyWith(
                                          color: myTheme.text,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${state.filiallPagel[state.index].shift2Start.substring(0, 5)}-"
                                    "${state.filiallPagel[state.index].shift2End.substring(0, 5)}",
                                    style: AppTextStyles.style10.copyWith(
                                      color: myTheme.text,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 8.h),

                              // Berilgan muhrlar
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Berilgan:",
                                    style: AppTextStyles.style10.copyWith(
                                      color: myTheme.text,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "${state.statsResponse!.data.shift2!.count} ta",
                                        style: AppTextStyles.style12.copyWith(
                                          color: myTheme.text,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "(${AuthRepository.formatSum(state.statsResponse!.data.shift2!.summa.toString())} so'm)",
                                        style: AppTextStyles.style10.copyWith(
                                          color: myTheme.globalColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              SizedBox(height: 6.h),

                              // Haydovchilar
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Haydovchilar:",
                                    style: AppTextStyles.style10.copyWith(
                                      color: myTheme.text,
                                    ),
                                  ),
                                  Text(
                                    "${state.statsResponse!.data.shift2!.uniqueDriversCount} ta",
                                    style: AppTextStyles.style12.copyWith(
                                      color: myTheme.text,
                                    ),
                                  ),
                                ],
                              ),

                              Divider(
                                height: 16.h,
                                color: myTheme.text.withValues(alpha: 0.1),
                              ),

                              // Naqdlashtirilgan
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Naqdlashtirilgan:",
                                      style: AppTextStyles.style10.copyWith(
                                        color: myTheme.text,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "${state.statsResponse!.data.shift2!.paymentPechatCount} ta",
                                        style: AppTextStyles.style12.copyWith(
                                          color: myTheme.logUot,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "(${AuthRepository.formatSum(state.statsResponse!.data.shift2!.paymentSumma.toString())} so'm)",
                                        style: AppTextStyles.style10.copyWith(
                                          color: myTheme.logUot,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              SizedBox(height: 6.h),

                              // To'lovlar soni
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "To'lovlar soni:",
                                    style: AppTextStyles.style10.copyWith(
                                      color: myTheme.text,
                                    ),
                                  ),
                                  Text(
                                    "${state.statsResponse!.data.shift2!.paymentCount} ta",
                                    style: AppTextStyles.style12.copyWith(
                                      color: myTheme.text,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 6.h),

                              // Noyob haydovchilar
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Noyob haydchilar:",
                                    style: AppTextStyles.style10.copyWith(
                                      color: myTheme.text,
                                    ),
                                  ),
                                  Text(
                                    "${state.statsResponse!.data.shift2!.paymentUniqueDriversCount} ta",
                                    style: AppTextStyles.style12.copyWith(
                                      color: myTheme.text,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
