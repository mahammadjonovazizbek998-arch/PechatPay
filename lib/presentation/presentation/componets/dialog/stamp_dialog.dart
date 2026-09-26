import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/style/text_form_style.dart';
import '../../../../data/style/text_style.dart';
import '../../../../data/theme/theme_class.dart';

class StampDialog extends StatefulWidget {
  const StampDialog({super.key});

  @override
  State<StampDialog> createState() => _StampDialogState();
}

class _StampDialogState extends State<StampDialog> {
  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 24.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      alignment: .center,
      icon: DecoratedBox(
        decoration: BoxDecoration(border: BoxBorder.all(color: myTheme.phonColor, width: 0.3),
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
      content: Container(height: 195.h,
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
                  "Farhod Nurmatov",
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
                          color: myTheme.unselctedColor.withValues(alpha: 0.3),
                          border: .fromLTRB(
                            right: BorderSide(color: myTheme.unselctedColor),
                          ),
                        ),
                        child: Text(
                          "01",
                          style: AppTextStyles.style12.copyWith(
                            color: myTheme.text,
                            fontWeight: .bold,
                          ),
                        ),
                      ),
                      Text(
                        "A777AA",
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
                  "Berilgan muhr:",
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
                  child: Row(
                    mainAxisSize: .min,
                    children: [
                      Image.asset(
                        "assets/img_28.png",
                        width: 17.w,
                        color: myTheme.phonColor,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        "1 ta muhr",
                        style: AppTextStyles.style12.copyWith(
                          color: myTheme.phonColor,
                          fontWeight: .bold,
                        ),
                      ),
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
                  "Yangi balans:",
                  style: AppTextStyles.style12.copyWith(
                    fontWeight: .w500,
                    color: myTheme.unselctedColor,
                  ),
                ),
                Text(
                  textAlign: .center,
                  "6 ta muhr (300 000 so'm)",
                  style: AppTextStyles.style12.copyWith(
                    fontWeight: .bold,
                    color: myTheme.globalColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.h),
            Divider(color: myTheme.unselctedColor.withValues(alpha: 0.3),),
            SizedBox(height: 5.h),
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(
                  textAlign: .center,
                  "Vaqt:",
                  style: AppTextStyles.style12.copyWith(
                    fontWeight: .w500,
                    color: myTheme.unselctedColor,
                  ),
                ),
                Text(
                  textAlign: .center,
                  "Hozir (Bugun, 15:42)",
                  style: AppTextStyles.style12.copyWith(
                    color: myTheme.text,
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
            child: Text("Bekor qilish", style: AppTextStyles.style14),
          ),
        ),
      ],
    );
  }
}
