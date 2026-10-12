import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/repository/auth.dart';
import '../../../../data/style/text_form_style.dart';
import '../../../../data/style/text_style.dart';
import '../../../../data/theme/theme_class.dart';
import '../../../../logon/dashboard/dashboard_cubit.dart';
import '../../../../logon/dashboard/dashboard_state.dart';

/// "Eng faol haydovchilar" kartasi (top_drivers ro'yxatidan).
class TopDriversCard extends StatelessWidget {
  final String subtitle;

  const TopDriversCard({
    super.key,
    this.subtitle = "Kunlik eng ko'p muhr olganlar",
  });

  /// 53U118RC -> 53 U 118 RC
  /// Viloyat kodi (53) + AuthRepository.formatUzbekCarNumber (U 118 RC)
  static String _plate(String raw) {
    final v = raw.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '').toUpperCase();
    // formatUzbekCarNumber kamida 8 belgi talab qiladi
    if (v.length < 8) return AuthRepository.formatPlate(raw);
    return '${v.substring(0, 2)} ${AuthRepository.formatUzbekCarNumber(v)}';
  }

  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;

    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        final drivers = state.statsResponse?.data.topDrivers ?? const [];
        if (drivers.isEmpty) return const SizedBox.shrink();

        final amber = myTheme.rejectionStampDialog; // to'q sariq
        final green = myTheme.phonColor; // yashil (so'm)

        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
          decoration: AppTextFormStyle.container(
            color: myTheme.textColor,
            shadow: true,
            shadowColor: myTheme.text,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------- Sarlavha ----------
              Row(
                children: [
                  Container(
                    width: 44.w,
                    height: 44.w,
                    decoration: BoxDecoration(
                      color: amber.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Icon(
                      Icons.workspace_premium_outlined,
                      color: amber,
                      size: 22.w,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Eng faol haydovchilar",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.style14.copyWith(
                            color: myTheme.text,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.style10.copyWith(
                            color: myTheme.text.withValues(alpha: 0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: amber.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: amber.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.military_tech_outlined,
                            size: 14.w, color: amber),
                        SizedBox(width: 3.w),
                        Text(
                          "Top ${drivers.length}",
                          style: AppTextStyles.style12.copyWith(
                            color: amber,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Divider(height: 1, color: myTheme.text.withValues(alpha: 0.1)),

              // ---------- Ro'yxat ----------
              ...List.generate(drivers.length, (i) {
                final d = drivers[i];
                final rank = i + 1;

                // reyting doirachasi ranglari
                final Color rankFg;
                final Color rankBg;
                Color? rankBorder;
                if (rank == 1) {
                  rankFg = amber;
                  rankBg = amber.withValues(alpha: 0.08);
                  rankBorder = amber.withValues(alpha: 0.4);
                } else if (rank == 3) {
                  rankFg = amber;
                  rankBg = amber.withValues(alpha: 0.08);
                  rankBorder = amber.withValues(alpha: 0.4);
                } else if (rank == 2) {
                  rankFg = amber;
                  rankBg = amber.withValues(alpha: 0.08);
                  rankBorder = amber.withValues(alpha: 0.4);
                } else {
                  rankFg = myTheme.text.withValues(alpha: 0.6);
                  rankBg = myTheme.unselctedColor.withValues(alpha: 0.12);
                }

                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 28.w,
                            height: 28.w,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: rankBg,
                              shape: BoxShape.circle,
                              border: rankBorder != null
                                  ? Border.all(color: rankBorder)
                                  : null,
                            ),
                            child: Text(
                              "$rank",
                              style: AppTextStyles.style12.copyWith(
                                color: rankFg,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  d.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.style14.copyWith(
                                    color: myTheme.text,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Wrap(
                                  spacing: 8.w,
                                  runSpacing: 4.h,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Text(
                                      d.phone,
                                      style: AppTextStyles.style10.copyWith(
                                        color: myTheme.text.withValues(
                                          alpha: 0.6,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 6.w,
                                        vertical: 3.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: myTheme.unselctedColor
                                            .withValues(alpha: 0.12),
                                        borderRadius:
                                        BorderRadius.circular(6.r),
                                      ),
                                      child: Text(
                                        _plate(d.carNumber),
                                        style: AppTextStyles.style10.copyWith(
                                          color: myTheme.text,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 6.h,
                                ),
                                decoration: BoxDecoration(
                                  color: myTheme.globalColor.withValues(
                                    alpha: 0.1,
                                  ),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Text(
                                  "${d.pechatCount} ta muhr",
                                  style: AppTextStyles.style12.copyWith(
                                    color: myTheme.globalColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: 6.h),
                              Text(
                                "${AuthRepository.formatSum(d.pechatSumma.toString())} so'm",
                                style: AppTextStyles.style12.copyWith(
                                  color: green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (i != drivers.length - 1)
                      Divider(
                        height: 1,
                        color: myTheme.text.withValues(alpha: 0.1),
                      ),
                  ],
                );
              }),
            ],
          ),
        );
      },
    );
  }
}