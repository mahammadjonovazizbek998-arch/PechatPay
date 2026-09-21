import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pechat_pay/data/style/text_form_style.dart';
import 'package:pechat_pay/data/style/text_style.dart';
import 'package:pechat_pay/presentation/presentation/componets/list_tile.dart';

import '../../../data/theme/theme_class.dart';
import 'issuing_a_seal_peges.dart';

class TaxisWidget extends StatefulWidget {
  const TaxisWidget({super.key});

  @override
  State<TaxisWidget> createState() => _TaxisWidgetState();
}

class _TaxisWidgetState extends State<TaxisWidget> {
  @override
  void initState() {
    indexColorInst();
    // TODO: implement initState
    super.initState();
  }

  final List<Color> profileColors = [
    Color(0xFF104DE8),
    Color(0xFF1D4ED8),
    Color(0xFF2563EB),
    Color(0xFF1E40AF),
    Color(0xFF1E3A8A),
    Color(0xFF315FE8),
    Color(0xFF3B82F6),
    Color(0xFF2563EB),
    Color(0xFF0369A1),
    Color(0xFF075985),
    Color(0xFF0891B2),
    Color(0xFF0E7490),
    Color(0xFF4338CA),
    Color(0xFF4F46E5),
    Color(0xFF6366F1),
    Color(0xFF3730A3),
    Color(0xFF7C3AED),
    Color(0xFF6D28D9),
    Color(0xFF0F766E),
    Color(0xFF115E59),
  ];
  late int colorIndex;

  void indexColorInst() {
    colorIndex = Random().nextInt(19);
  }

  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;
    return Container(
      decoration: AppTextFormStyle.container(color: myTheme.cardColor),

      child: Column(
        mainAxisSize: .min,
        children: [
          ListTileWidget(
            selected: Text(
              "Jasur Olimov",
              style: AppTextStyles.style16.copyWith(
                color: myTheme.text,
                fontWeight: .w900,
              ),
            ),
            unselected: Text(
              "+998 97 845 12 34",
              style: AppTextStyles.style12.copyWith(
                color: myTheme.text.withValues(alpha: 0.9),
              ),
            ),
            icon: Icon(
              Icons.phone_outlined,
              color: myTheme.text.withValues(alpha: 0.9),
              size: 16.w,
            ),
            leading: ContainerWidget(
              vertical: 54.h,
              horizontal: 50.w,
              text: Text(
                "SR",
                style: AppTextStyles.style14.copyWith(
                  fontWeight: .bold,
                  color: myTheme.textColor,
                ),
              ),
              boxDecoration:
                  AppTextFormStyle.container(
                    color: profileColors[colorIndex],
                  ).copyWith(
                    border: BoxBorder.all(
                      width: 0.5.w,
                      color: profileColors[colorIndex],
                    ),
                    borderRadius: .circular(40.r),
                  ),
            ),
            trailing: Column(
              mainAxisAlignment: .center,
              crossAxisAlignment: .end,
              children: [
                Container(
                  decoration: AppTextFormStyle.container(
                    color: myTheme.globalColor.withValues(alpha: 0.1),
                  ),
                  padding: .symmetric(vertical: 5.h, horizontal: 6.w),
                  child: Row(
                    mainAxisSize: .min,
                    children: [
                      Image.asset("assets/img_20.png", width: 17.w),
                      SizedBox(width: 2.w),
                      Text(
                        "3 ta muhr",
                        style: AppTextStyles.style12.copyWith(
                          color: myTheme.globalColor,
                          fontWeight: .bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  "150 000 so'm",
                  style: AppTextStyles.style12.copyWith(
                    color: myTheme.text.withValues(alpha: 0.9),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: .symmetric(horizontal: 16.w),
            child: Divider(
              color: myTheme.text.withValues(alpha: 0.2),
              height: 0,
            ),
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: .symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: .spaceBetween,
              crossAxisAlignment: .center,
              children: [
                Row(
                  mainAxisSize: .min,
                  crossAxisAlignment: .start,
                  children: [
                    Image.asset("assets/img_21.png", width: 16.w),
                    SizedBox(width: 5.w),
                    Text(
                      "Chevrolet Lacetti / Gentra",
                      style: AppTextStyles.style12.copyWith(
                        color: myTheme.text.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 28.h,
                  width: 122.w,
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
          ),
          SizedBox(height: 12.h),
          Padding(
            padding: .symmetric(horizontal: 16.w),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40.h,
                    child: ElevatedButton(
                      style: AppTextFormStyle.buttonStyleBorder(
                        button: true,
                        background: myTheme.container,
                        foreground: myTheme.globalColor,
                      ),
                      onPressed: () {},
                      child: Row(
                        mainAxisSize: .min,
                        children: [
                          Image.asset(
                            "assets/img_22.png",
                            width: 13.w,
                            color: myTheme.globalColor,
                          ),
                          Text("  Muhr berish", style: AppTextStyles.style14),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: SizedBox(
                    height: 40.h,

                    child: ElevatedButton(
                      style: AppTextFormStyle.buttonStyleBorder(
                        background: myTheme.unselctedCardColor,
                        foreground: myTheme.text,
                        button: true,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => IssuingASealPeges(
                              color: profileColors[colorIndex],
                            ),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisSize: .min,
                        children: [
                          Image.asset(
                            "assets/img_7.png",
                            width: 14.w,
                            color: myTheme.text,
                          ),
                          Text("  Profil", style: AppTextStyles.style14),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
        ],
      ),
    );
  }
}
