import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/style/text_form_style.dart';
import '../../../data/style/text_style.dart';
import '../../../data/theme/theme_class.dart';
import 'list_tile.dart';

class BranchComponets extends StatefulWidget {
  final bool myBranch;
  final bool isacctiv;

  const BranchComponets({
    super.key,
    this.myBranch = false,
    this.isacctiv = false,
  });

  @override
  State<BranchComponets> createState() => _BranchComponetsState();
}

class _BranchComponetsState extends State<BranchComponets> {
  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;
    return Container(
      padding: widget.isacctiv
          ? .symmetric(vertical: 0)
          : .symmetric(vertical: 10.h),
      width: 358.w,

      decoration: AppTextFormStyle.container(color: myTheme.cardColor),
      child: Column(
        mainAxisAlignment: .start,
        crossAxisAlignment: .start,
        children: [
          if (widget.isacctiv)
            Container(
              margin: .symmetric(horizontal: 2.5.w),
              height: 7.h,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: myTheme.globalColor,
                borderRadius: .only(
                  topLeft: .circular(15.r),
                  topRight: .circular(15.r),
                ),
              ),
            ),
          ListTileWidget(
            selected: Text(
              "PechatPay — Chilonzor",
              style: AppTextStyles.style16.copyWith(
                color: myTheme.text,
                fontWeight: .w900,
              ),
            ),
            unselected: Text(
              "+998 71 200 45 60",
              style: AppTextStyles.style12.copyWith(
                color: myTheme.text.withValues(alpha: 0.9),
              ),
            ),
            icon: Icon(
              Icons.phone_outlined,
              color: myTheme.globalColor,
              size: 16.w,
            ),
            leading: ContainerWidget(
              vertical: 74.h,
              horizontal: 60.w,
              assets: "assets/shop.png",
              assetsHorizontal: 28.w,
              assetsVertical: 30.79.h,
              boxDecoration:
                  AppTextFormStyle.container(color: myTheme.container).copyWith(
                    border: BoxBorder.all(
                      width: 0.5.w,
                      color: myTheme.globalColor,
                    ),
                  ),
              assetsColor: myTheme.globalColor,
            ),
          ),
          Padding(
            padding: .only(left: 16.w, right: 16.w),
            child: Container(
              padding: .symmetric(horizontal: 13.w, vertical: 4.h),
              height: 70.h,
              width: MediaQuery.of(context).size.width,
              decoration: AppTextFormStyle.container(
                color: widget.isacctiv
                    ? myTheme.globalColor.withValues(alpha: 0.1)
                    : myTheme.unselctedCardColor,
              ),
              child: Row(
                crossAxisAlignment: .center,
                children: [
                  ContainerWidget(
                    vertical: 47.h,
                    horizontal: 44.w,
                    assets: "assets/img_15.png",
                    assetsHorizontal: 30.w,
                    assetsVertical: 15.w,
                    boxDecoration: AppTextFormStyle.container(
                      color: myTheme.globalColor,
                    ).copyWith(),
                    assetsColor: myTheme.textColor,
                  ),
                  SizedBox(width: 12.w),
                  Column(
                    crossAxisAlignment: .start,
                    mainAxisAlignment: .center,
                    children: [
                      Text(
                        "1 ta muhr uchun to'lov stavkasi",
                        style: AppTextStyles.style10.copyWith(
                          color: myTheme.text.withValues(alpha: 0.9),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        // shart, aks holda ishlamaydi
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "50 000",
                            style: AppTextStyles.style22.copyWith(
                              color: myTheme.globalColor,
                            ),
                          ),
                          Text(" so'm / muhr", style: AppTextStyles.style16),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Padding(
            padding: .only(left: 16.w, right: 16.w),
            child: Row(
              children: [
                Icon(size: 18.w, Icons.access_time, color: myTheme.text),
                Text(
                  " SMENA ALMASHISH TARTIBI",
                  style: AppTextStyles.style12.copyWith(
                    color: myTheme.text.withValues(alpha: 0.9),
                    fontWeight: .w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 4.h),
          Padding(
            padding: .only(left: 16.w, right: 16.w),
            child: Row(
              children: [
                Container(
                  decoration: AppTextFormStyle.container(
                    color: myTheme.shiftColor.withValues(alpha: 0.06),
                  ),
                  padding: .symmetric(horizontal: 10.w, vertical: 10.h),
                  width: 159.w,
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.wb_sunny_outlined,
                            size: 15.sp,
                            color: myTheme.shiftColor,
                          ),
                          Text(
                            " Kunduzgi smena",
                            style: AppTextStyles.style10.copyWith(
                              color: myTheme.shiftColor.withValues(alpha: 0.8),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        textAlign: .start,
                        "08:00 — 20:00",
                        style: AppTextStyles.style14.copyWith(
                          fontWeight: .bold,
                          color: myTheme.text,
                        ),
                      ),
                      SizedBox(height: 3.h),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                Container(
                  decoration: AppTextFormStyle.container(
                    color: myTheme.globalColor.withValues(alpha: 0.05),
                  ),
                  padding: .symmetric(horizontal: 10.w, vertical: 10.h),
                  width: 159.w,
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            color: myTheme.globalColor.withValues(alpha: 0.5),
                            Icons.nights_stay_outlined,
                            size: 15.sp,
                          ),
                          Text(
                            " Tungi smena",
                            style: AppTextStyles.style10.copyWith(
                              color: myTheme.globalColor.withValues(alpha: 0.5),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        textAlign: .start,
                        "20:00 — 08:00",
                        style: AppTextStyles.style14.copyWith(
                          fontWeight: .bold,
                          color: myTheme.text,
                        ),
                      ),
                      SizedBox(height: 3.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Padding(
            padding: .only(left: 16.w, right: 16.w),
            child: widget.myBranch
                ? widget.isacctiv?Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 48.h,

                          child: ElevatedButton(
                            style: AppTextFormStyle.buttonStyleBorder(
                              background: myTheme.unselctedCardColor,
                              foreground: myTheme.text,
                              button: true,
                            ),
                            onPressed: () {},
                            child: Row(
                              mainAxisSize: .min,
                              children: [
                                Image.asset(
                                  "assets/img.png",
                                  width: 14.w,
                                  color: myTheme.text,
                                ),
                                Text(
                                  " Statistika",
                                  style: AppTextStyles.style14,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: SizedBox(
                          height: 48.h,
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
                                Icon(Icons.edit_outlined, size: 18.w),
                                Text(
                                  " tahrirlash",
                                  style: AppTextStyles.style14,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ):
            SizedBox(
              height: 48.h,
              width: MediaQuery.of(context).size.width,
              child:  ElevatedButton(
                style: AppTextFormStyle.buttonStyleBorder(
                  background: myTheme.unselctedCardColor,
                  foreground: myTheme.text,
                  button: true,
                ),
                onPressed: () {},
                child: Row(
                  mainAxisSize: .min,
                  children: [
                    Image.asset(
                      "assets/img.png",
                      width: 14.w,
                      color: myTheme.text,
                    ),
                    Text(
                      " Statistika",
                      style: AppTextStyles.style14,
                    ),
                  ],
                ),
              ),
            )
                : SizedBox(
                    height: 48.h,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: AppTextFormStyle.buttonStyleBorder(
                        background: myTheme.container,
                        foreground: myTheme.globalColor,
                      ),
                      onPressed: () {},
                      child: Row(
                        mainAxisSize: .min,
                        children: [
                          Icon(Icons.edit_outlined, size: 18.w),
                          Text(
                            " Filial ma'lumotlarini tahrirlash",
                            style: AppTextStyles.style14,
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
          SizedBox(height: 6.h),
        ],
      ),
    );
  }
}
