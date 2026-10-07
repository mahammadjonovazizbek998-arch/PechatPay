
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../data/style/text_style.dart';
import '../../../data/theme/theme_class.dart';

class AppSmartRefresher extends StatelessWidget {
  const AppSmartRefresher({
    super.key,
    required this.child,
    required this.onLoading,
    required this.onRefresh,
    required this.controller,
  });

  final Widget child;
  final VoidCallback onLoading;
  final VoidCallback onRefresh;
  final RefreshController controller;

  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;

    Widget label(String text) => Text(
      text,
      style: AppTextStyles.style12.copyWith(
        color: myTheme.text.withValues(alpha: 0.9),
        fontWeight: FontWeight.w500,
      ),
    );

    return SmartRefresher(
      controller: controller,
      enablePullDown: true,
      enablePullUp: true,
      onRefresh: onRefresh,
      onLoading: onLoading,
      footer: CustomFooter(
        height: 60,
        builder: (context, mode) {
          final Widget body = switch (mode) {
            LoadStatus.loading => SizedBox(width: 15.w,height: 15.h,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: myTheme.globalColor,
              ),
            ),
            LoadStatus.failed => label("Xatolik, qayta urinib ko'ring"),
            LoadStatus.canLoading => label("Qo'yib yuboring"),
            LoadStatus.noMore => label("Ma'lumot tugadi"),
            _ => label("Yana yuklash uchun tepaga torting"),
          };
          return SizedBox(height: 60, child: Center(child: body));
        },
      ),
      child: child,
    );
  }
}
