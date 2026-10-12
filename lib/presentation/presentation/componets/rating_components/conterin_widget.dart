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

class ConterinWidget extends StatelessWidget {
  const ConterinWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;

    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        final response = state.statsResponse;

        if (response == null) {
          return const SizedBox.shrink();
        }

        final data = response.data;
        final summary = data.summary;
        final previous = data.previous;

        final currentDrivers = summary.uniqueDriversCount;
        final previousDrivers = previous?.uniqueDriversCount ?? 0;

        final difference = currentDrivers - previousDrivers;

        final double percentage = previousDrivers == 0
            ? (currentDrivers == 0 ? 0 : 100)
            : ((currentDrivers - previousDrivers) / previousDrivers) * 100;

        final bool increased = difference > 0;
        final bool decreased = difference < 0;

        final Color changeColor = decreased ? Colors.red : myTheme.phonColor;

        final String percentageText =
            '${percentage > 0 ? '+' : ''}${percentage.round()}%';

        final String differenceText = '${difference > 0 ? '+' : ''}$difference';

        return Container(
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
          width: 173.w,
          decoration: AppTextFormStyle.container(
            color: myTheme.textColor,
            borderColor: myTheme.text,
            shadow: true,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon va o'zgarish foizi
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ContainerWidget(
                    vertical: 46.h,
                    horizontal: 44.w,
                    assets: "assets/stamp.png",
                    assetsHorizontal: 16.75,
                    assetsVertical: 17.5,
                    assetsColor: myTheme.globalColor,
                    boxDecoration: AppTextFormStyle.container(
                      color: myTheme.globalColor.withValues(alpha: 0.1),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 5.h,
                        horizontal: 5.w,
                      ),
                      decoration: BoxDecoration(
                        color: changeColor.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            increased
                                ? Icons.arrow_upward
                                : decreased
                                ? Icons.arrow_downward
                                : Icons.remove,
                            color: changeColor,
                            size: 14.w,
                          ),
                          Flexible(
                            child: Text(
                              '$percentageText ($differenceText)',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.style10.copyWith(
                                color: changeColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 7.h),

              // Sarlavha
              Text(
                'Berilgan muhrlar',
                style: AppTextStyles.style12.copyWith(color: myTheme.text),
              ),

              SizedBox(height: 2.h),

              // Jami muhrlar
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    summary.count.toString(),
                    style: AppTextStyles.style18.copyWith(color: myTheme.text),
                  ),
                  Text(
                    ' ta',
                    style: AppTextStyles.style12.copyWith(color: myTheme.text),
                  ),
                ],
              ),

              // Jami summa
              Text(
                '${summary.summa < 0 ? '-' : '+'}'
                '${AuthRepository.formatSum(summary.summa.abs().toString())} so\'m',
                style: AppTextStyles.style12.copyWith(
                  color: summary.summa < 0 ? Colors.red : myTheme.phonColor,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Divider(color: myTheme.unselctedColor.withValues(alpha: 0.5)),

              // Bir dona muhr narxi
              _infoRow(
                title: '1 ta muhr:',
                value:
                    "${AuthRepository.formatSum(state.filiallPagel[state.index].stampPrice.toString())} so'm",
                myTheme: myTheme,
              ),

              SizedBox(height: 8.h),

              // Noyob haydovchilar
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Noyob hayd.:',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.style12.copyWith(
                        color: myTheme.text,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Text(
                    '$currentDrivers ta ',
                    style: AppTextStyles.style12.copyWith(
                      color: myTheme.text,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '($differenceText)',
                    style: AppTextStyles.style10.copyWith(
                      color: decreased ? Colors.red : myTheme.phonColor,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 8.h),

              // Oldingi kun haydovchilari
              _infoRow(
                title: 'Oldingi kun:',
                value: previous == null ? '-' : '$previousDrivers ta',
                myTheme: myTheme,
              ),

              SizedBox(height: 8.h),

              // Oldingi kun summasi
              if (previous != null)
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "${AuthRepository.formatSum(previous.summa.toString())} so'm",
                    textAlign: TextAlign.right,
                    style: AppTextStyles.style10.copyWith(
                      color: myTheme.text.withValues(alpha: 0.7),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _infoRow({
    required String title,
    required String value,
    required ThemeClass myTheme,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.style12.copyWith(
              color: myTheme.text,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SizedBox(width: 4.w),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.style12.copyWith(
              color: myTheme.text,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
