import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class ListTileWidget extends StatefulWidget {
  final ContainerWidget? leading;
  Icon? icon;
  final Text selected;
  final Text? unselected;
  VoidCallback? onTap;
  String? assets;
  Color? color;
  bool peding;
  Widget? trailing;
  bool icoBool;
  bool widget;
  Widget? leading1;

  ListTileWidget({
    super.key,
    this.icon,
    this.unselected,
    required this.selected,
    this.onTap,
    this.assets,
    required this.leading,
    this.color,
    this.peding = false,
    this.trailing,
    this.icoBool = false,
    this.widget = true,
    this.leading1,
  });

  @override
  State<ListTileWidget> createState() => _ListTileWidgetState();
}

class _ListTileWidgetState extends State<ListTileWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: 0,
      titleAlignment: ListTileTitleAlignment.center,
      visualDensity: widget.peding
          ? const VisualDensity(vertical: -2)
          : const VisualDensity(vertical: 0),
      contentPadding: widget.peding
          ? EdgeInsets.symmetric(horizontal: 8.w)
          : EdgeInsets.symmetric(horizontal: 16.w),
      leading: widget.leading ?? widget.leading1,
      onTap: widget.onTap,
      subtitle: widget.unselected == null
          ? null
          : widget.icon != null
          ? Row(
              mainAxisAlignment: .start,
              children: [widget.icon!, widget.unselected!],
            )
          : widget.unselected,
      title: widget.selected,
      trailing: widget.widget
          ? widget.onTap != null
                ? widget.icoBool
                      ? Icon(
                          Icons.keyboard_arrow_down,
                          color: widget.color!.withValues(alpha: 0.8),
                        )
                      : Icon(
                          Icons.chevron_right,
                          color: widget.color!.withValues(alpha: 0.8),
                        )
                : widget.trailing
          : Row(mainAxisSize: .min,
              children: [
                widget.trailing!,
                Icon(
                  Icons.keyboard_arrow_down,
                  color: widget.color!.withValues(alpha: 0.8),
                ),
              ],
            ),
    );
  }
}

class ContainerWidget extends StatelessWidget {
  final double vertical;
  final double horizontal;
  final String? assets;
  final double? assetsHorizontal;
  final double? assetsVertical;
  final BoxDecoration boxDecoration;
  final Color? assetsColor;
  final Text? text;

  const ContainerWidget({
    super.key,
    required this.vertical,
    required this.horizontal,
    this.assets,
    this.assetsHorizontal,
    this.assetsVertical,
    required this.boxDecoration,
    this.assetsColor,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: .center,
      decoration: boxDecoration,
      width: horizontal.w,
      height: vertical.h,
      child:
          text ??
          Image.asset(
            assets!,
            color: assetsColor,
            height: assetsVertical!.h,
            width: assetsHorizontal!.w,
          ),
    );
  }
}
