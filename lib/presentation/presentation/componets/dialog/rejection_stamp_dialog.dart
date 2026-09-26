
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/style/text_form_style.dart';
import '../../../../data/style/text_style.dart';
import '../../../../data/theme/theme_class.dart';

class RejectionStampDialog extends StatefulWidget {
  const RejectionStampDialog({super.key});

  @override
  State<RejectionStampDialog> createState() => _RejectionStampDialogState();
}

class _RejectionStampDialogState extends State<RejectionStampDialog> {
  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;
    return  AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 24.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      alignment: .center,
      icon: DecoratedBox(
        decoration: BoxDecoration(
          shape: .circle,border: BoxBorder.all(color: myTheme.rejectionStampDialog, width: 0.3),
          boxShadow: [
            BoxShadow(

              color: myTheme.rejectionStampDialog.withValues(alpha: 0.06),
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),
        child: CircleAvatar(
          backgroundColor: myTheme.rejectionStampDialog.withValues(alpha: 0.06),
          radius: 32.r,
          child: Image.asset(
            "assets/img_27.png",
            width: 22.5.w,
            color: myTheme.rejectionStampDialog,
          ),
        ),
      ),
      title: Column(
        children: [
          Text(
            "Muhr berish cheklangan!",
            textAlign: .center,
            style: AppTextStyles.style18.copyWith(
              fontWeight: .bold,
              color: myTheme.text,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            textAlign: .center,
            "Ushbu haydovchi oxirgi 2 soat ichida muhr olgan.\nQoidalarga ko'ra takroriy muhr berish taqiqlanadi.",
            style: AppTextStyles.style12.copyWith(
              fontWeight: .w500,
              color: myTheme.unselctedColor,
            ),
          ),
        ],
      ),
      content: Container(height: 130.h,
        decoration: AppTextFormStyle.container(
          color: myTheme.rejectionStampDialog.withValues(alpha: 0.06),
          borderColor: myTheme.rejectionStampDialog,
        ),
        padding: .symmetric(vertical: 14.h, horizontal: 14.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(
                  textAlign: .center,
                  "Oxirgi muhr vaqti:",
                  style: AppTextStyles.style12.copyWith(
                    fontWeight: .w500,
                    color: myTheme.unselctedColor,
                  ),
                ),
                Text(
                  textAlign: .center,
                  "14:30 (45 daqiqa oldin)",
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
                  "Filial:",
                  style: AppTextStyles.style12.copyWith(
                    fontWeight: .w500,
                    color: myTheme.unselctedColor,
                  ),
                ),
                Text(
                  textAlign: .center,
                  "PechatPay — Chilonzor",
                  style: AppTextStyles.style12.copyWith(
                    fontWeight: .bold,
                    color: myTheme.text,
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
                  "Qolgan kutish vaqti::",
                  style: AppTextStyles.style12.copyWith(
                    fontWeight: .w500,
                    color: myTheme.unselctedColor,
                  ),
                ),
                Container(
                  decoration: AppTextFormStyle.container(
                    color: myTheme.rejectionStampDialog,
                  ),
                  padding: .symmetric(vertical: 5.h, horizontal: 6.w),
                  child: Text(
                    "1 soat 15 daqiqa",
                    style: AppTextStyles.style12.copyWith(
                      color: myTheme.textColor,
                      fontWeight: .bold,
                    ),
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
              background: myTheme.text,
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
              background: Colors.transparent,
              foreground: myTheme.text,
            ),
            child: Text("Bekor qilish", style: AppTextStyles.style14),
          ),
        ),
      ],
    );
  }
}
