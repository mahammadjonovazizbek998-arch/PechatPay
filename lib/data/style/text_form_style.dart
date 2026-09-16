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
      errorStyle: AppTextStyles.style12.copyWith(color: color),
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

  static ButtonStyle buttonStyle({
    required Color background,
    required Color foreground,
  }) {
    return ElevatedButton.styleFrom(
      backgroundColor: background,
      foregroundColor: foreground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
    );
  }
}
