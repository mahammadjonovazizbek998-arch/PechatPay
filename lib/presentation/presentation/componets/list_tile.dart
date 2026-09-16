import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pechat_pay/data/style/text_style.dart';

// ignore: must_be_immutable
class ListTileWidget extends StatefulWidget {
  final Color backgroundColor;
  Icon? icon;
  final String selected;
  String? unselected;
  VoidCallback? onTap;
  String? assets;

  ListTileWidget({
    super.key,
    required this.backgroundColor,
    this.icon,
    this.unselected,
    required this.selected,
    this.onTap,
    this.assets,
  });

  @override
  State<ListTileWidget> createState() => _ListTileWidgetState();
}

class _ListTileWidgetState extends State<ListTileWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      titleAlignment: .center,
      leading: CircleAvatar(
        radius: 22.r,
        child: widget.backgroundColor == Colors.red
            ? widget.icon != null
                  ? widget.icon!
                  : Image.asset(
                      widget.assets!,
                      width: 28.w,
                      color: Colors.white,
                    )
            : ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [
                    Color(0xFF0601B4), // Asosiy to'q ko'k
                    Color(0xFF3B82F6), // Yorqin ko'k (Blue)
                    Color(0xFF06B6D4),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ).createShader(bounds),
                child: widget.icon != null
                    ? widget.icon!
                    : Image.asset(
                        widget.assets!,
                        width: 28.w,
                        color: Colors.white,
                      ),
              ),
      ),
      // Container(
      //   width: 41.w,
      //   height: 40.h,
      //   alignment: .center,
      //   decoration: BoxDecoration(
      //     color: widget.backgroundColor,
      //     borderRadius: BorderRadius.circular(40.r),
      //   ),
      //   child: widget.icon != null ? widget.icon! : Image.asset(widget.assets!,width: 30,),
      // ),
      trailing: widget.onTap != null
          ? Icon(Icons.arrow_forward_ios, size: 17.w, color: Colors.grey)
          : null,
      subtitle: widget.unselected != null
          ? Text(widget.unselected!, style: AppTextStyles.style14)
          : null,
      title: Text(
        widget.selected,
        style: AppTextStyles.style16.copyWith(fontWeight: .bold),
      ),
    );
  }
}
