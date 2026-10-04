import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pechat_pay/data/driver_model/pechat.dart';
import 'package:pechat_pay/data/repository/auth.dart';

import '../../../../data/style/text_form_style.dart';
import '../../../../data/style/text_style.dart';
import '../../../../data/theme/theme_class.dart';

class StampDialog extends StatelessWidget {
  final PechatCreateResponse response;

  const StampDialog({super.key, required this.response});

  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;
    final data = response.data;
    
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 24.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      alignment: .center,
      icon: DecoratedBox(
        decoration: BoxDecoration(
          border: BoxBorder.all(color: myTheme.phonColor, width: 0.3),
          shape: .circle,
          boxShadow: [
            BoxShadow(
              color: myTheme.phonColor.withValues(alpha: 0.1),
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),
        child: CircleAvatar(
          backgroundColor: myTheme.phonColor.withValues(alpha: 0.09),
          radius: 32.r,
          child: Image.asset(
            "assets/img_25.png",
            width: 22.5.w,
            color: myTheme.phonColor,
          ),
        ),
      ),
      title: Column(
        children: [
          Text(
            "Muhr muvaffaqiyatli berildi!",
            textAlign: .center,
            style: AppTextStyles.style18.copyWith(
              fontWeight: .bold,
              color: myTheme.text,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            textAlign: .center,
            "Operatsiya tasdiqlandi va hisobga yozildi",
            style: AppTextStyles.style12.copyWith(
              fontWeight: .w500,
              color: myTheme.unselctedColor,
            ),
          ),
        ],
      ),
      content: Container(
        height: 150.h,
        decoration: AppTextFormStyle.container(
          color: myTheme.unselctedColor.withValues(alpha: 0.1),
          borderColor: myTheme.unselctedColor,
        ),
        padding: .symmetric(vertical: 14.h, horizontal: 14.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(
                  textAlign: .center,
                  "Haydovchi:",
                  style: AppTextStyles.style12.copyWith(
                    fontWeight: .w500,
                    color: myTheme.unselctedColor,
                  ),
                ),
                Text(
                  textAlign: .center,
                  data?.driverName ?? "Noma'lum",
                  style: AppTextStyles.style12.copyWith(
                    fontWeight: .bold,
                    color: myTheme.text,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(
                  textAlign: .center,
                  "Avtomobil raqami:",
                  style: AppTextStyles.style12.copyWith(
                    fontWeight: .w500,
                    color: myTheme.unselctedColor,
                  ),
                ),
                Container(
                  height: 28.h,
                  width: 110.w,
                  decoration: BoxDecoration(
                    borderRadius: .circular(8.r),
                    border: .all(width: 2.w, color: myTheme.text),
                  ),
                  child: Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Container(
                        alignment: .center,
                        height: 28.h,
                        width: 30.w,
                        decoration: BoxDecoration(
                          color: myTheme.unselctedColor.withValues(
                            alpha: 0.3,
                          ),
                          border: .fromLTRB(
                            right: BorderSide(
                              color: myTheme.unselctedColor,
                            ),
                          ),
                        ),
                        child: Text(
                          data?.carNumber.substring(0, 2) ?? "xx",
                          style: AppTextStyles.style12.copyWith(
                            color: myTheme.text,
                            fontWeight: .bold,
                          ),
                        ),
                      ),
                      Text(
                        AuthRepository.formatUzbekCarNumber(
                          data?.carNumber ?? "A777AA",
                        ),
                        style: AppTextStyles.style12.copyWith(
                          color: myTheme.text,
                          fontWeight: .bold,
                        ),
                      ),
                      Text(
                        textAlign: .left,
                        "uz",
                        style: AppTextStyles.style12.copyWith(
                          color: myTheme.globalColor,
                          fontWeight: .bold,
                        ),
                      ),
                      SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(
                  textAlign: .center,
                  data?.type == "nasiya"
                      ? "Berilgan muhr:"
                      : "Berilgan summa:",
                  style: AppTextStyles.style12.copyWith(
                    fontWeight: .w500,
                    color: myTheme.unselctedColor,
                  ),
                ),
                Container(
                  decoration: AppTextFormStyle.container(
                    color: myTheme.phonColor.withValues(alpha: 0.1),
                  ),
                  padding: .symmetric(vertical: 5.h, horizontal: 6.w),
                  child: data?.type == "nasiya"
                      ? Row(
                          mainAxisSize: .min,
                          children: [
                            Image.asset(
                              "assets/img_28.png",
                              width: 10.w,
                              color: myTheme.phonColor,
                            ),
                            SizedBox(width: 2.w),
                            Text(
                              "${data?.pechatCount ?? "1"} ta muhr",
                              style: AppTextStyles.style12.copyWith(
                                color: myTheme.phonColor,
                                fontWeight: .bold,
                              ),
                            ),
                          ],
                        )
                      : Text(
                          "${AuthRepository.formatSum(data?.stampPrice.toString() ?? "0")} so'm",
                          style: AppTextStyles.style12.copyWith(
                            color: myTheme.phonColor,
                            fontWeight: .bold,
                          ),
                        ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(
                  textAlign: .center,
                  "Yangi balans:",
                  style: AppTextStyles.style12.copyWith(
                    fontWeight: .w500,
                    color: myTheme.unselctedColor,
                  ),
                ),
                Text(
                  textAlign: .center,
                  "${data?.unpaidPechatsCount} ta muhr (${data?.unpaidPechatsSum} so'm)",
                  style: AppTextStyles.style12.copyWith(
                    fontWeight: .bold,
                    color: myTheme.globalColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actionsAlignment: .center,
      actions: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 40.h,
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: AppTextFormStyle.buttonStyle(
              background: myTheme.globalColor.withValues(alpha: 0.8),
              foreground: myTheme.textColor,
            ),
            child: Text("Davom etish", style: AppTextStyles.style14),
          ),
        ),
        SizedBox(height: 10.h),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 44.h,
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: AppTextFormStyle.buttonStyle(
              background: myTheme.unselctedColor.withValues(alpha: 0.5),
              foreground: myTheme.text,
            ),
            child: Text("Bosh sahifa", style: AppTextStyles.style14),
          ),
        ),
      ],
    );
  }
}
