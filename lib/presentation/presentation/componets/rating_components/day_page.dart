import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pechat_pay/data/style/text_form_style.dart';
import 'package:pechat_pay/data/style/text_style.dart';

import 'package:pechat_pay/logon/dashboard/dashboard_cubit.dart';

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
                children: [
                  ListTile(
                    title: Text(
                      "Smenalar tahlili (Kunduzgi vs Tungi)",
                      style: AppTextStyles.style14.copyWith(
                        color: myTheme.text,
                      ),
                    ),
                    leading: Icon(
                      Icons.compare_arrows,
                      color: myTheme.text,
                      size: 18.w,
                    ),
                    contentPadding: .zero,
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
