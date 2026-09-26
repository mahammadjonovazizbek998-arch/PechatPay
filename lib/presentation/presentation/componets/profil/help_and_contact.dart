import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pechat_pay/data/style/text_form_style.dart';

import '../../../../data/style/text_style.dart';
import '../../../../data/theme/theme_class.dart';
import '../list_tile.dart';

class HelpAndContact extends StatefulWidget {
  const HelpAndContact({super.key});

  @override
  State<HelpAndContact> createState() => _HelpAndContactState();
}

class _HelpAndContactState extends State<HelpAndContact> {
  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: .start,
          crossAxisAlignment: .start,
          mainAxisSize: .min,
          children: [
            Text(
              textAlign: .start,
              "Yordam va aloqa",
              style: AppTextStyles.style18.copyWith(
                fontWeight: .bold,
                color: myTheme.text,
              ),
            ),
            Text(
              textAlign: .start,
              "Texnik ko'mak & Dasturchilar",
              style: AppTextStyles.style10.copyWith(
                fontWeight: .w400,
                color: myTheme.text.withValues(alpha: 0.9),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: .symmetric(horizontal: 16.h),
        child: Column(
          mainAxisAlignment: .start,
          crossAxisAlignment: .start,
          children: [
            SizedBox(height: 16.h),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: AppTextFormStyle.container(
                color: myTheme.globalColor,shadow: true
              ),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0.h,
                    right: 0.w,
                    child: Image.asset(
                      "assets/img_8.png",
                      width: 91.67.w,
                      height: 80.33.h,
                    ),
                  ),
                  Padding(
                    padding: .symmetric(vertical: 16.h),
                    child: ListTileWidget(
                      color: myTheme.unselctedColor,
                      selected: Text(
                        textAlign: .start,
                        "PechatPay Dev Team",
                        style: AppTextStyles.style16.copyWith(
                          fontWeight: .bold,
                          color: myTheme.textColor,
                        ),
                      ),
                      unselected: Text(
                        textAlign: .start,
                        "Tizim xatoliklari, yangi takliflar va API integratsiyalari bo'yicha to'g'ridan-to'g'ri bog'laning.",
                        style: AppTextStyles.style12.copyWith(
                          fontWeight: .w500,
                          color: myTheme.textColor.withValues(alpha: 0.8),
                        ),
                      ),
                      leading: ContainerWidget(
                        vertical: 50.h,
                        horizontal: 48.w,
                        assets: "assets/img_9.png",
                        assetsHorizontal: 19.75.w,
                        assetsVertical: 20.5.h,
                        assetsColor: myTheme.textColor,
                        boxDecoration: AppTextFormStyle.container(
                          borderColor: myTheme.textColor,
                          color: myTheme.globalColor.withValues(alpha: 0.01),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: AppTextFormStyle.container(color: myTheme.cardColor,shadow: true),
              child: Column(
                mainAxisAlignment: .start,
                crossAxisAlignment: .start,
                children: [
                  SizedBox(height: 16.h),
                  Padding(
                    padding: .symmetric(horizontal: 12.w),
                    child: Row(
                      children: [
                        Image.asset("assets/img_10.png", width: 13.w),
                        Text(
                          " DASTURCHI BILAN TO'G'RIDAN-TO'G'RI ALOQA",
                          style: AppTextStyles.style12.copyWith(
                            color: myTheme.text.withValues(alpha: 0.9),
                            fontWeight: .w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Padding(
                    padding:.symmetric(horizontal: 12.w,),
                    child: DecoratedBox(decoration: AppTextFormStyle.container(color: myTheme.globalBackgroundColor.withValues(alpha: 0.7)),
                      child:  ListTileWidget(peding: true,
                        color: myTheme.unselctedColor,
                        onTap: () {},

                        selected: Text(
                          textAlign: .start,
                          "Dasturchi bilan bog'lanish",
                          style: AppTextStyles.style14.copyWith(
                            fontWeight: .bold,
                            color: myTheme.text,
                          ),
                        ),
                        unselected: Text(
                          maxLines: 1,
                          overflow: .ellipsis,
                          textAlign: .start,
                          "@pechatpay_dev • Shaxsiy chat & tezkor aloqa",
                          style: AppTextStyles.style13.copyWith(
                            fontWeight: .w500,
                            color: myTheme.text.withValues(alpha: 0.8),
                          ),
                        ),
                        leading: ContainerWidget(
                          vertical: 46.h,
                          horizontal: 44.w,
                          assets: "assets/img_11.png",
                          assetsHorizontal: 16.75.w,
                          assetsVertical: 17.5.h,
                          assetsColor: myTheme.globalColor,
                          boxDecoration: AppTextFormStyle.container(
                            color: myTheme.globalColor.withValues(alpha: 0.09),
                          ),
                        ),
                      ),)),
                  SizedBox(height: 8.h),
                  Padding(
                    padding:.symmetric(horizontal: 12.w,),
                    child: DecoratedBox(decoration: AppTextFormStyle.container(color: myTheme.globalBackgroundColor.withValues(alpha: 0.7)),
                      child: ListTileWidget(peding: true,
                        color: myTheme.unselctedColor,
                        onTap: () {},

                        selected: Text(
                          textAlign: .start,
                          "+998 71 200 45 60",
                          style: AppTextStyles.style14.copyWith(
                            fontWeight: .bold,
                            color: myTheme.text,
                          ),
                        ),
                        unselected: Text(
                          maxLines: 1,
                          overflow: .ellipsis,
                          textAlign: .start,
                          "Kassirlar & Filiallar maxsus liniyasi",
                          style: AppTextStyles.style13.copyWith(
                            fontWeight: .w500,
                            color: myTheme.text.withValues(alpha: 0.8),
                          ),
                        ),
                        leading: ContainerWidget(
                          vertical: 46.h,
                          horizontal: 44.w,
                          assets: "assets/img_12.png",
                          assetsHorizontal: 16.75.w,
                          assetsVertical: 17.5.h,
                          assetsColor: myTheme.phonColor,
                          boxDecoration: AppTextFormStyle.container(
                            color: myTheme.phonColor.withValues(alpha: 0.09),
                          ),
                        ),
                      ),)),
                  SizedBox(height: 8.h),
                  Padding(
                    padding:.symmetric(horizontal: 12.w,),
                    child: DecoratedBox(decoration: AppTextFormStyle.container(color: myTheme.globalBackgroundColor.withValues(alpha: 0.7)),
                      child: ListTileWidget(peding: true,
                        color: myTheme.unselctedColor,
                        onTap: () {},

                        selected: Text(
                          textAlign: .start,
                          "support@pechatpay.uz",
                          style: AppTextStyles.style14.copyWith(
                            fontWeight: .bold,
                            color: myTheme.text,
                          ),
                        ),
                        unselected: Text(
                          maxLines: 1,
                          overflow: .ellipsis,
                          textAlign: .start,
                          "Texnik hujjatlar va takliflar",
                          style: AppTextStyles.style13.copyWith(
                            fontWeight: .w500,
                            color: myTheme.text.withValues(alpha: 0.8),
                          ),
                        ),
                        leading: ContainerWidget(
                          vertical: 46.h,
                          horizontal: 44.w,
                          assets: "assets/img_13.png",
                          assetsHorizontal: 16.75.w,
                          assetsVertical: 17.5.h,
                          assetsColor: myTheme.globalColor,
                          boxDecoration: AppTextFormStyle.container(
                            color: myTheme.globalColor.withValues(alpha: 0.09),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: AppTextFormStyle.container(color: myTheme.cardColor,shadow: true),
              child: Column(
                mainAxisAlignment: .start,
                crossAxisAlignment: .start,
                children: [
                  SizedBox(height: 16.h),

                  Padding(
                    padding: .symmetric(horizontal: 12.w),
                    child: Row(
                      children: [
                        Image.asset("assets/img_14.png", width: 13.w),
                        Text(
                          " TIZIM PARAMETRLARI",
                          style: AppTextStyles.style12.copyWith(
                            color: myTheme.text.withValues(alpha: 0.9),
                            fontWeight: .w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Padding(
                    padding: .symmetric(horizontal: 12.w),
                    child: Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        Text(
                          maxLines: 1,
                          overflow: .ellipsis,
                          textAlign: .start,
                          "Dastur versiyasi",
                          style: AppTextStyles.style13.copyWith(
                            fontWeight: .w500,
                            color: myTheme.text.withValues(alpha: 0.8),
                          ),
                        ),
                        Text(
                          textAlign: .start,
                          "v1.0.4 (Build 240)",
                          style: AppTextStyles.style14.copyWith(
                            fontWeight: .bold,
                            color: myTheme.text,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
