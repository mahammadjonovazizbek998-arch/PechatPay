import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pechat_pay/logon/dashboard/dashboard_cubit.dart';

import '../../../../data/repository/auth.dart';
import '../../../../data/style/text_form_style.dart';
import '../../../../data/style/text_style.dart';
import '../../../../data/theme/theme_class.dart';
import '../../../../logon/dashboard/dashboard_state.dart';
import '../list_tile.dart';

class PayConterinWidget extends StatelessWidget {
  const PayConterinWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;

    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        final data = state.statsResponse!.data;
        final summary = data.summary;
        final previous = data.previous!;

        final currentDrivers = summary.paymentUniqueDriversCount;
        final previousDrivers = previous.paymentUniqueDriversCount;
        final difference = currentDrivers - previousDrivers;

        return Container(
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
          decoration: AppTextFormStyle.container(
            color: myTheme.textColor,
            borderColor: myTheme.text,
            shadow: true,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ContainerWidget(
                    vertical: 46.h,
                    horizontal: 44.w,
                    assets: "assets/money.png",
                    assetsHorizontal: 16.75,
                    assetsVertical: 17.5,
                    assetsColor: myTheme.rejectionStampDialog,
                    boxDecoration: AppTextFormStyle.container(
                      color: myTheme.rejectionStampDialog.withValues(
                        alpha: 0.1,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 5.h,
                        horizontal: 5.w,
                      ),
                      decoration: BoxDecoration(
                        color: myTheme.rejectionStampDialog.withValues(
                          alpha: 0.1,
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        "${summary.paymentCount} ta to'lov",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.style12.copyWith(
                          color: myTheme.rejectionStampDialog,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 7.h),

              Text(
                "Naqdlashtirilgan",
                style: AppTextStyles.style12.copyWith(color: myTheme.text),
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    summary.paymentPechatCount.toString(),
                    style: AppTextStyles.style18.copyWith(color: myTheme.text),
                  ),
                  Text(
                    " ta",
                    style: AppTextStyles.style12.copyWith(color: myTheme.text),
                  ),
                ],
              ),

              Text(
                "${summary.paymentSumma < 0 ? '-' : '+'}"
                "${AuthRepository.formatSum(summary.paymentSumma.abs().toString())} so'm",
                style: AppTextStyles.style12.copyWith(
                  color: summary.paymentSumma < 0
                      ? Colors.red
                      : myTheme.phonColor,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Divider(color: myTheme.unselctedColor.withValues(alpha: 0.5)),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      "To'lovlar soni:",
                      style: AppTextStyles.style12.copyWith(
                        color: myTheme.text,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Text(
                    "${summary.paymentCount} ta",
                    style: AppTextStyles.style12.copyWith(
                      color: myTheme.text,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 8.h),

              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Noyob haydchilar:",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.style12.copyWith(
                        color: myTheme.text,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Text(
                    "$currentDrivers ta ",
                    style: AppTextStyles.style12.copyWith(
                      color: myTheme.text,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "(${difference > 0 ? '+' : ''}$difference)",
                    style: AppTextStyles.style10.copyWith(
                      color: difference < 0 ? Colors.red : myTheme.phonColor,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 8.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      "Oldingi kun:",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.style12.copyWith(
                        color: myTheme.text,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Text(
                    "$previousDrivers ta",
                    style: AppTextStyles.style12.copyWith(
                      color: myTheme.text,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 8.h),

              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "${AuthRepository.formatSum(previous.paymentSumma.toString())} so'm "
                  "(${previous.paymentCount} to'lov)",
                  textAlign: TextAlign.right,
                  style: AppTextStyles.style10.copyWith(color: myTheme.text),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
