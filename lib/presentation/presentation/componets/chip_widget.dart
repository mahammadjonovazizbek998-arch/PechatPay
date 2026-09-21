import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pechat_pay/data/style/text_style.dart';

import '../../../data/theme/theme_class.dart';

class ChipWidget extends StatefulWidget {
  final String name;
  final String? url;
  final bool isSelected;
  final VoidCallback onTap;

  const ChipWidget({
    super.key,
    required this.name,
    required this.url,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<ChipWidget> createState() => _ChipWidgetState();
}

class _ChipWidgetState extends State<ChipWidget> {
  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;
    return ActionChip(
      padding: .symmetric(vertical: 3.h, horizontal: 5.w),
      shape: RoundedRectangleBorder(borderRadius: .circular(16.r)),
      label: Text(
        textAlign: .center,
        widget.name,
        style: AppTextStyles.style12.copyWith(
          fontWeight: widget.isSelected ? .bold : .w500,
          color: widget.isSelected ? myTheme.textColor : myTheme.text,
        ),
      ),
      avatar: widget.url != null
          ? CircleAvatar(child: Image.asset(widget.url!))
          : null,
      backgroundColor: widget.isSelected
          ? myTheme.globalColor
          : myTheme.textColor,
      onPressed: widget.onTap,
    );
  }
}
