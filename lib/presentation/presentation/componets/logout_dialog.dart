import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pechat_pay/data/style/text_style.dart';

import '../../../data/style/text_form_style.dart';
import '../../../data/theme/theme_class.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      alignment: .center,
      icon: DecoratedBox(
        decoration: BoxDecoration(
          shape: .circle,
          boxShadow: [

            BoxShadow(
              color: myTheme.logUot.withValues(alpha: 0.01),
              blurRadius:8,
              spreadRadius: 2,
            ),
          ],
        ),
        child: CircleAvatar(backgroundColor: myTheme.logUot.withValues(alpha: 0.09),
          radius: 32.r,
          child: Icon(Icons.logout, color: myTheme.logUot, size: 22.5.w),
        ),
      ),
      title: Padding(
        padding: .symmetric(horizontal: 30.w),
        child: Text(
          "Filial tizimidan chiqishni tasdiqlaysizmi?",
          textAlign: .center,
          style: AppTextStyles.style18.copyWith(fontWeight: .bold),
        ),
      ),
      content: Text(
        textAlign: .center,
        "Haqiqatan ham filial tizimidan chiqmoqchimisiz? Qayta kirish uchun filial maxfiy paroli talab etiladi.",
        style: AppTextStyles.style12.copyWith(
          fontWeight: .w500,
          color: myTheme.unselctedColor,
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
              background: myTheme.logUot.withValues(alpha: 0.8),
              foreground: myTheme.textColor,
            ),
            child: Text("Ha, tizimdan chiqish", style: AppTextStyles.style14),
          ),
        ),
        SizedBox(height: 10.h,),
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
