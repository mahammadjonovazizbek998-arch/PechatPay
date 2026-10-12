import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/repository/auth.dart';
import '../../../../data/style/text_style.dart';
import '../../../../data/theme/theme_class.dart';
import '../../../../logon/dashboard/dashboard_cubit.dart';
import '../../../../logon/dashboard/dashboard_state.dart';

class _Bar {
  final String label;
  final int value;
  const _Bar(this.label, this.value);
}

/// Soatbay diagramma. Hamma narsani DashboardCubit state'idan oladi:
///  - statisticsBool == true  -> Pechat       -> pechat_trend  (rang: phonColor)
///  - statisticsBool == false -> Naqdlashtirish -> payment_trend (rang: globalColor)
///  - summa == 0 bo'lgan soatlar chiqarilmaydi
///  - kunduzgi = shift1Start -> shift2Start, qolgani tungi
class PechatBarChart extends StatelessWidget {
  const PechatBarChart({super.key});

  static int _min(TimeOfDay t) => t.hour * 60 + t.minute;

  /// true -> kunduzgi, false -> tungi
  static bool _isDay(
      String label,
      String? s1Str,
      String? e1Str,
      String? s2Str,
      String? e2Str,
      ) {
    final h = int.tryParse(label.split(':').first) ?? 0;
    final m = h * 60;

    final s1 = AuthRepository.parse(s1Str, const TimeOfDay(hour: 6, minute: 0));
    final e1 = AuthRepository.parse(e1Str, const TimeOfDay(hour: 18, minute: 0));
    final s2 = AuthRepository.unset(s2Str, e2Str)
        ? e1
        : AuthRepository.parse(s2Str, e1);

    final a = _min(s1);
    final b = _min(s2);
    if (a == b) return true;
    return a < b ? (m >= a && m < b) : (m >= a || m < b);
  }

  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;

    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        final data = state.statsResponse!.data;
        final isPechat = state.statisticsBool;
        final f = state.filiallPagel[state.index];

        // 1) Ma'lumotni tanlash va summa == 0 larni olib tashlash
        final List<_Bar> items = isPechat
            ? data.pechatTrend
            .where((e) => e.summa != 0)
            .map((e) => _Bar(e.label, e.count))
            .toList()
            : data.paymentTrend
            .where((e) => e.summa != 0)
            .map((e) => _Bar(e.label, e.pechatCount))
            .toList();

        if (items.isEmpty) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: Center(
              child: Text(
                "Ma'lumot yo'q",
                style: AppTextStyles.style12.copyWith(color: myTheme.text),
              ),
            ),
          );
        }

        // 2) Pik: asl ro'yxatdan topiladi, so'ng label bo'yicha qidiriladi
        String? peakLabel;
        if (isPechat) {
          final p = AuthRepository.findPeakIndexes(
            data.pechatTrend,
            data.paymentTrend,
          );
          if (p.isNotEmpty) peakLabel = data.pechatTrend[p[0]].label;
        } else {
          final p = AuthRepository.findPaymentPeakIndexes(
            data.paymentTrend,
            data.pechatTrend,
          );
          if (p.isNotEmpty) peakLabel = data.paymentTrend[p[0]].label;
        }
        final peakIndex = items.indexWhere((e) => e.label == peakLabel);

        // 3) Hisob-kitoblar
        final maxCount =
        items.map((e) => e.value).reduce((a, b) => a > b ? a : b);
        final total = items.fold<int>(0, (s, e) => s + e.value);
        final avg = total / items.length;

        bool isDay(String l) => _isDay(
          l,
          f.shift1Start,
          f.shift1End,
          f.shift2Start,
          f.shift2End,
        );

        // Kunduzgi / Tungi qiymatlari serverdan keladi:
        //  shift_1 -> kunduzgi, shift_2 -> tungi
        //  pechat tabi: count, naqdlashtirish tabi: payment_pechat_count
        // shift_1 / shift_2 kelmasa (masalan "Barchasi"), soatlardan hisoblanadi.
        final calcDay = items
            .where((e) => isDay(e.label))
            .fold<int>(0, (s, e) => s + e.value);
        final calcNight = total - calcDay;

        final shift1 = data.shift1;
        final shift2 = data.shift2;

        final day = shift1 != null
            ? (isPechat ? shift1.count : shift1.paymentPechatCount)
            : calcDay;
        final night = shift2 != null
            ? (isPechat ? shift2.count : shift2.paymentPechatCount)
            : calcNight;

        // 4) Ranglar: pechat -> phonColor, naqdlashtirish -> globalColor
        final mainColor = isPechat ? myTheme.phonColor : myTheme.globalColor;
        final dayColor = mainColor;
        final nightColor = mainColor.withValues(alpha: 0.5);

        final chartH = 110.h;
        final step = (items.length / 8).ceil().clamp(1, 24);

        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "O'rtacha: ~${avg.round()} ta / soat",
                  style: AppTextStyles.style10.copyWith(color: myTheme.text),
                ),
                Text(
                  "Maksimum: $maxCount ta / soat",
                  style: AppTextStyles.style10.copyWith(
                    color: myTheme.text,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),

            SizedBox(
              height: chartH + 20.h,
              child: Stack(
                children: [
                  if (maxCount > 0)
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: chartH * (avg / maxCount),
                      child: Divider(
                        height: 1,
                        thickness: 1,
                        color: myTheme.text.withValues(alpha: 0.25),
                      ),
                    ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: List.generate(items.length, (i) {
                      final item = items[i];
                      final isPeak = i == peakIndex;
                      final h = maxCount == 0
                          ? 0.0
                          : chartH * item.value / maxCount;
                      return Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "${item.value}",
                              style: AppTextStyles.style10.copyWith(
                                color: isPeak ? mainColor : myTheme.text,
                                fontWeight: isPeak
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Container(
                              height: h,
                              margin: EdgeInsets.symmetric(horizontal: 1.5.w),
                              decoration: BoxDecoration(
                                color: isDay(item.label)
                                    ? dayColor
                                    : nightColor,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(3.r),
                                ),
                                border: isPeak
                                    ? Border.all(color: mainColor, width: 2)
                                    : null,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
            SizedBox(height: 6.h),

            Row(
              children: List.generate(items.length, (i) {
                final show = i % step == 0 || i == peakIndex;
                final label = items[i].label;
                return Expanded(
                  child: Text(
                    show && label.length >= 2 ? label.substring(0, 2) : '',
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.visible,
                    style: AppTextStyles.style10.copyWith(
                      color: i == peakIndex
                          ? mainColor
                          : myTheme.text.withValues(alpha: 0.6),
                      fontWeight: i == peakIndex
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                );
              }),
            ),
            Divider(height: 20.h, color: myTheme.text.withValues(alpha: 0.1)),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _legend(dayColor, "Kunduzgi:", "$day ta", myTheme),
                _legend(nightColor, "Tungi:", "$night ta", myTheme),
              ],
            ),

          ],
        );
      },
    );
  }

  Widget _legend(Color color, String title, String value, ThemeClass t) {
    return Row(
      children: [
        CircleAvatar(backgroundColor: color, radius: 6.r),
        SizedBox(width: 6.w),
        Text(title, style: AppTextStyles.style12.copyWith(color: t.text)),
        SizedBox(width: 4.w),
        Text(
          value,
          style: AppTextStyles.style12.copyWith(
            color: t.text,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
