import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'text_style.dart';

class AppTextFormStyle {
  static InputDecoration style({
    required Color color,
    required String text,
    required bool visibilityOff,
    bool eye = false,
    bool state = false,
    VoidCallback? onTap,
    String? errorText,
  }) {
    final border = OutlineInputBorder(
      borderSide: BorderSide(color: color, width: 0.5.w),
      borderRadius: BorderRadius.circular(15.r),
    );
    return InputDecoration(
      constraints: BoxConstraints(minHeight: 47.h, maxHeight: 62.h),

      suffixIcon: visibilityOff
          ? eye
                ? IconButton(
                    onPressed: onTap,
                    icon: Icon(
                      size: 24.w,
                      state ? Icons.visibility_off : Icons.visibility,
                      color: color,
                    ),
                  )
                : null
          : null,
      errorStyle: AppTextStyles.style12.copyWith(color: Colors.red),
      hintStyle: AppTextStyles.style16.copyWith(color: color),
      hintText: text,
      errorText: errorText,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      errorBorder: border,
      focusedErrorBorder: border,
      enabledBorder: border,
      focusedBorder: border,
    );
  }
  static InputDecoration licensePlate({
    required Color color,
    required String text,
    String? errorText,
  }) {
    final border = OutlineInputBorder(
      borderSide: BorderSide(color: color, width: 0.5.w),
      borderRadius: BorderRadius.circular(15.r),
    );

    return InputDecoration(
      isDense: true,
      // suffix/prefix yo'q, shuning uchun matn aniq markazda turadi
      contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
      constraints: BoxConstraints(minHeight: 40.h),
      filled: true,
      fillColor: Colors.white,
      hintText: text,
      hintStyle: AppTextStyles.style16.copyWith(color: color),
      errorText: errorText,
      errorStyle: AppTextStyles.style12.copyWith(color: Colors.red),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      counterText: "",
      border: border,
      enabledBorder: border,
      focusedBorder: border,
      errorBorder: border,
      focusedErrorBorder: border,
    );
  }
  static InputDecoration textFormFild({
    required Color color,
    required String text,
    VoidCallback? onTap,
    String? errorText,
    required Widget? prefix,
    bool licensePlate = false,
    Widget? suffix,
  }) {
    final border = OutlineInputBorder(
      borderSide: BorderSide(color: color, width: 0.5.w),
      borderRadius: BorderRadius.circular(15.r),
    );
    return InputDecoration(
      prefixIcon: prefix,
      suffixIcon: Align(alignment: .center,heightFactor: 1,widthFactor: 1,
          child: suffix),
      prefixIconConstraints: BoxConstraints(minWidth: 36.w, minHeight: 36.h),
      isDense: true,
      contentPadding: licensePlate
          ? EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w)
          : EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
      filled: true,
      fillColor: Colors.white,
      constraints: BoxConstraints(minHeight: 40.h,),
      errorStyle: AppTextStyles.style12.copyWith(color: Colors.red),
      hintStyle: licensePlate
          ? AppTextStyles.style16.copyWith(color: color)
          : AppTextStyles.style14.copyWith(color: color),
      hintText: text,
      errorText: errorText,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      errorBorder: border,
      focusedErrorBorder: border,
      enabledBorder: border,
      focusedBorder: border,
      counterText: "",
    );
  }

  static ButtonStyle buttonStyle({
    required Color background,
    required Color foreground,
  }) {
    return ElevatedButton.styleFrom(
      backgroundColor: background,
      foregroundColor: foreground,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
    );
  }

  static ButtonStyle buttonStyleBorder({
    required Color background,
    required Color foreground,
    bool button = false,
    bool? padding = false,
  }) {
    return ElevatedButton.styleFrom(
      backgroundColor: background,
      foregroundColor: foreground,
      surfaceTintColor: Colors.transparent,
      alignment: .center,
      elevation: 0,
      padding: padding != null
          ? padding
                ? .symmetric(horizontal: 14, vertical: 8)
                : EdgeInsets.symmetric(horizontal: 24, vertical: 8)
          : EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.r),
        side: button
            ? BorderSide(color: Colors.transparent, width: 0)
            : BorderSide(color: foreground.withValues(alpha: 0.1), width: 1.w),
      ),
    );
  }

  static BoxDecoration container({
    required Color color,
    Color? borderColor,
    bool shadow = false,
    Color? shadowColor, // agar berilmasa — neytral qora ishlatiladi
  }) {
    return BoxDecoration(
      border: borderColor != null
          ? BoxBorder.all(color: borderColor, width: 0.3)
          : null,
      borderRadius: BorderRadius.circular(15.r),
      color: color,
      boxShadow: shadow
          ? [
              BoxShadow(
                color: (shadowColor ?? Colors.black).withValues(alpha: 0.10),
                blurRadius: 6,
                offset: Offset(0, 1.h),
              ),
              BoxShadow(
                color: (shadowColor ?? Colors.black).withValues(alpha: 0.05),
                blurRadius: 10,
                offset: Offset(0, 2.h),
              ),
            ]
          : null,
    );
  }

  static InputDecoration sorchText({
    required Color color,
    required String text,
    VoidCallback? onTap,
    String? errorText,
    required Icon icon,
  }) {
    final border = OutlineInputBorder(
      borderSide: BorderSide(color: color, width: 0.5.w),
      borderRadius: BorderRadius.circular(15.r),
    );
    return InputDecoration(
      prefixIcon: icon,
      contentPadding: .all(0),
      constraints: BoxConstraints(minHeight: 40.h),
      errorStyle: AppTextStyles.style10.copyWith(color: color),
      hintStyle: AppTextStyles.style12.copyWith(color: color),
      hintText: text,
      errorText: errorText,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      errorBorder: border,
      focusedErrorBorder: border,
      enabledBorder: border,
      focusedBorder: border,
    );
  }
}
