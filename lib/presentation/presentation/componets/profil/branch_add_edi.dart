import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/style/text_form_style.dart';
import '../../../../data/style/text_style.dart';
import '../../../../data/theme/theme_class.dart';
import '../list_tile.dart';

class BranchAddEdi extends StatefulWidget {
  final String? branchName;
  final String? phon;
  final String? amount;
  final String? daytimeStart;
  final String? daytimeEnd;
  final String? nightStart;
  final String? nightEnd;

  const BranchAddEdi({
    super.key,
    this.branchName,
    this.phon,
    this.amount,
    this.daytimeStart,
    this.daytimeEnd,
    this.nightStart,
    this.nightEnd,
  });

  @override
  State<BranchAddEdi> createState() => _BranchAddEdiState();
}

class _BranchAddEdiState extends State<BranchAddEdi> {
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
              widget.branchName == null
                  ? "Yangi filial qo'shish"
                  : "Filialni tahrirlash",
              style: AppTextStyles.style18.copyWith(
                fontWeight: .bold,
                color: myTheme.text,
              ),
            ),
            Text(
              textAlign: .start,
              widget.branchName == null
                  ? "Yangi filial parametrlarini kiriting va yarating"
                  : "PechatPay filial ma'lumotlarini yangilash",
              style: AppTextStyles.style10.copyWith(
                fontWeight: .w400,
                color: myTheme.text.withValues(alpha: 0.9),
              ),
            ),
          ],
        ),
      ),
      body: Form(
        child: Padding(
          padding: .symmetric(vertical: 16.h, horizontal: 16.w),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  padding: .symmetric(vertical: 16.h, horizontal: 16.w),
                  decoration: AppTextFormStyle.container(
                    color: myTheme.textColor,
                    shadow: true,
                    borderColor: myTheme.unselctedColor.withValues(alpha: 0.5),
                  ),
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Row(
                        children: [
                          ContainerWidget(
                            vertical: 40.h,
                            horizontal: 38.w,
                            assets: "assets/img_29.png",
                            assetsHorizontal: 20.w,
                            assetsVertical: 20.h,
                            assetsColor: myTheme.globalColor,
                            boxDecoration: AppTextFormStyle.container(
                              color: myTheme.globalColor.withValues(
                                alpha: 0.09,
                              ),
                            ),
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            maxLines: 2,
                            textAlign: .start,
                            "ASOSIY IDENTIFIKATORLAR",
                            style: AppTextStyles.style12.copyWith(
                              color: myTheme.text,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        maxLines: 2,
                        textAlign: .start,
                        "Filial nomi",
                        style: AppTextStyles.style13.copyWith(
                          color: myTheme.text,
                          fontWeight: .bold,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      TextFormField(
                        initialValue: widget.branchName,
                        style: AppTextStyles.style14.copyWith(
                          color: myTheme.text,
                        ),
                        decoration: AppTextFormStyle.textFormFild(
                          color: myTheme.unselctedColor,
                          text: "Masalan, PechatPay — Yunusobod",
                          prefix: Padding(
                            padding: EdgeInsets.only(left: 12.w, right: 8.w),
                            child: Image.asset(
                              "assets/shop.png",
                              width: 16.w,
                              color: myTheme.text,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Ismni kiriting";
                          }
                          return null;
                        },
                        onChanged: (value) {},
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        maxLines: 2,
                        textAlign: .start,
                        "Aloqa telefon raqamia",
                        style: AppTextStyles.style13.copyWith(
                          color: myTheme.text,
                          fontWeight: .bold,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      TextFormField(
                        textAlign: .start,
                        keyboardType: .phone,
                        initialValue: widget.phon,
                        style: AppTextStyles.style14.copyWith(
                          color: myTheme.text,
                        ),
                        decoration: AppTextFormStyle.textFormFild(
                          color: myTheme.unselctedColor,
                          text: "90 123 45 67",
                          prefix: Padding(
                            padding: EdgeInsets.only(left: 12.w, right: 8.w),
                            child: Row(
                              mainAxisSize: .min,
                              children: [
                                Icon(
                                  Icons.phone_outlined,
                                  size: 20.w,
                                  color: myTheme.unselctedColor,
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  "+998",
                                  style: AppTextStyles.style14.copyWith(
                                    color: myTheme.text,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Ismni kiriting";
                          }
                          return null;
                        },
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 16.h)),
              SliverToBoxAdapter(
                child: Container(
                  padding: .symmetric(vertical: 16.h, horizontal: 16.w),
                  decoration: AppTextFormStyle.container(
                    color: myTheme.textColor,
                    shadow: true,
                    borderColor: myTheme.unselctedColor.withValues(alpha: 0.5),
                  ),
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Row(
                        children: [
                          ContainerWidget(
                            vertical: 40.h,
                            horizontal: 38.w,
                            assets: "assets/img_20.png",
                            assetsHorizontal: 20.w,
                            assetsVertical: 20.h,
                            assetsColor: myTheme.globalColor,
                            boxDecoration: AppTextFormStyle.container(
                              color: myTheme.globalColor.withValues(
                                alpha: 0.09,
                              ),
                            ),
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            maxLines: 2,
                            textAlign: .start,
                            "PECHAT (MUHR) STAVKASI",
                            style: AppTextStyles.style12.copyWith(
                              color: myTheme.text,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        maxLines: 2,
                        textAlign: .start,
                        "1 ta muhr nominal hisob qiymati",
                        style: AppTextStyles.style13.copyWith(
                          color: myTheme.text,
                          fontWeight: .bold,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      TextFormField(
                        initialValue: widget.amount,
                        style: AppTextStyles.style14.copyWith(
                          color: myTheme.text,
                        ),
                        decoration: AppTextFormStyle.textFormFild(
                          suffix: Container(
                            width: 90.w,
                            height: 38.h,
                            alignment: .center,
                            margin: .symmetric(horizontal: 5.w, vertical: 5.h),
                            decoration: AppTextFormStyle.container(
                              color: myTheme.unselctedColor.withValues(
                                alpha: 0.1,
                              ),
                            ),
                            child: Text(
                              "UZS / MUHR",
                              style: AppTextStyles.style12.copyWith(
                                color: myTheme.globalColor,
                              ),
                            ),
                          ),
                          color: myTheme.unselctedColor,
                          text: "Masalan, PechatPay — Yunusobod",
                          prefix: Padding(
                            padding: EdgeInsets.only(left: 12.w, right: 8.w),
                            child: Image.asset(
                              "assets/img_15.png",
                              width: 16.w,
                              color: myTheme.text,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Ismni kiriting";
                          }
                          return null;
                        },
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 16.h)),
              SliverToBoxAdapter(
                child: Container(
                  padding: .symmetric(vertical: 16.h, horizontal: 16.w),
                  decoration: AppTextFormStyle.container(
                    color: myTheme.textColor,
                    shadow: true,
                    borderColor: myTheme.unselctedColor.withValues(alpha: 0.5),
                  ),
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Row(
                        children: [
                          ContainerWidget(
                            vertical: 40.h,
                            horizontal: 38.w,
                            assets: "assets/img_32.png",
                            assetsHorizontal: 20.w,
                            assetsVertical: 20.h,
                            assetsColor: myTheme.globalColor,
                            boxDecoration: AppTextFormStyle.container(
                              color: myTheme.globalColor.withValues(
                                alpha: 0.09,
                              ),
                            ),
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            maxLines: 2,
                            textAlign: .start,
                            "SMENALAR ALMASHISH VAQTLARI",
                            style: AppTextStyles.style12.copyWith(
                              color: myTheme.text,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Container(
                        decoration: AppTextFormStyle.container(
                          color: myTheme.text.withValues(alpha: 0.09),
                        ),
                        child: ListTileWidget(
                          icoBool: false,
                          peding: true,
                          color: myTheme.unselctedColor,
                          trailing: Container(
                            width: 90.w,
                            decoration: AppTextFormStyle.container(
                              color: myTheme.textColor,
                            ),
                            padding: .symmetric(vertical: 8.h, horizontal: 6.w),
                            child: Row(children: [Text("08:00 - 20:00")]),
                          ),
                          selected: Text(
                            textAlign: .start,
                            "Kunduzgi smena",
                            style: AppTextStyles.style14.copyWith(
                              fontWeight: .bold,
                              color: myTheme.text,
                            ),
                          ),
                          unselected: Text(
                            textAlign: .start,
                            "1-navbatchi guruhi",
                            style: AppTextStyles.style12.copyWith(
                              fontWeight: .w500,
                              color: myTheme.text.withValues(alpha: 0.8),
                            ),
                          ),
                          leading: ContainerWidget(
                            vertical: 46.h,
                            horizontal: 44.w,
                            assets: "assets/img_33.png",
                            assetsHorizontal: 16.75,
                            assetsVertical: 17.5,
                            assetsColor: myTheme.shiftColor,
                            boxDecoration: AppTextFormStyle.container(
                              color: myTheme.shiftColor.withValues(alpha: 0.1),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Container(
                        decoration: AppTextFormStyle.container(
                          color: myTheme.text.withValues(alpha: 0.09),
                        ),
                        child: ListTileWidget(
                          icoBool: false,
                          peding: true,
                          color: myTheme.unselctedColor,
                          trailing: Container(
                            width: 90.w,
                            decoration: AppTextFormStyle.container(
                              color: myTheme.textColor,
                            ),
                            padding: .symmetric(vertical: 8.h, horizontal: 6.w),
                            child: Row(children: [Text("20:00 - 08:00")]),
                          ),
                          selected: Text(
                            textAlign: .start,
                            "Tungi smena",
                            style: AppTextStyles.style14.copyWith(
                              fontWeight: .bold,
                              color: myTheme.text,
                            ),
                          ),
                          unselected: Text(
                            textAlign: .start,
                            "2-navbatchi guruhi",
                            style: AppTextStyles.style12.copyWith(
                              fontWeight: .w500,
                              color: myTheme.text.withValues(alpha: 0.8),
                            ),
                          ),
                          leading: ContainerWidget(
                            vertical: 46.h,
                            horizontal: 44.w,
                            assets: "assets/img_34.png",
                            assetsHorizontal: 16.75,
                            assetsVertical: 17.5,
                            assetsColor: myTheme.globalColor,
                            boxDecoration: AppTextFormStyle.container(
                              color: myTheme.globalColor.withValues(alpha: 0.1),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 16.h)),
              SliverToBoxAdapter(
                child: Container(
                  padding: .symmetric(vertical: 16.h, horizontal: 16.w),
                  decoration: AppTextFormStyle.container(
                    color: myTheme.textColor,
                    shadow: true,
                    borderColor: myTheme.unselctedColor.withValues(alpha: 0.5),
                  ),
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Row(
                        children: [
                          ContainerWidget(
                            vertical: 40.h,
                            horizontal: 38.w,
                            assets: "assets/img_35.png",
                            assetsHorizontal: 20.w,
                            assetsVertical: 20.h,
                            assetsColor: myTheme.globalColor,
                            boxDecoration: AppTextFormStyle.container(
                              color: myTheme.globalColor.withValues(
                                alpha: 0.09,
                              ),
                            ),
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            maxLines: 2,
                            textAlign: .start,
                            "XAVFSIZLIK VA KIRISH PAROLI",
                            style: AppTextStyles.style12.copyWith(
                              color: myTheme.text,
                            ),
                          ),
                        ],
                      ),
                      if (widget.branchName != null) SizedBox(height: 10.h),
                      if (widget.branchName != null)
                        Text(
                          maxLines: 2,
                          textAlign: .start,
                          "Joriy (eski) parol",
                          style: AppTextStyles.style13.copyWith(
                            color: myTheme.text,
                          ),
                        ),
                      if (widget.branchName != null) SizedBox(height: 5.h),
                      if (widget.branchName != null)
                        TextFormField(
                          style: AppTextStyles.style14.copyWith(
                            color: myTheme.text,
                          ),
                          decoration: AppTextFormStyle.textFormFild(
                            color: myTheme.unselctedColor,
                            text: "Masalan, Password",
                            prefix: Padding(
                              padding: EdgeInsets.only(left: 12.w, right: 8.w),
                              child: Icon(
                                Icons.lock_open,
                                size: 18.w,
                                color: myTheme.text,
                              ),
                            ),
                            suffix: Icon(
                              Icons.visibility_outlined,
                              size: 22.w,
                              color: myTheme.text,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Ismni kiriting";
                            }
                            return null;
                          },
                          onChanged: (value) {},
                        ),
                      SizedBox(height: 10.h),
                      Text(
                        maxLines: 2,
                        textAlign: .start,
                        widget.branchName != null
                            ? "Yangi filial paroli"
                            : "Filial kirish paroli",
                        style: AppTextStyles.style13.copyWith(
                          color: myTheme.text,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      TextFormField(
                        style: AppTextStyles.style14.copyWith(
                          color: myTheme.text,
                        ),
                        decoration: AppTextFormStyle.textFormFild(
                          color: myTheme.unselctedColor,
                          text: widget.branchName != null
                              ? "Yangi parolni kiriting"
                              : "Filial uchun parol o'ylab toping",
                          prefix: Padding(
                            padding: EdgeInsets.only(left: 12.w, right: 8.w),
                            child: Icon(
                              widget.branchName != null
                                  ? Icons.key
                                  : Icons.lock_outline,
                              size: 18.w,
                              color: myTheme.text,
                            ),
                          ),
                          suffix: Icon(
                            Icons.visibility_outlined,
                            size: 22.w,
                            color: myTheme.text,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Ismni kiriting";
                          }
                          return null;
                        },
                        onChanged: (value) {},
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        maxLines: 2,
                        textAlign: .start,
                        widget.branchName != null
                            ? "Yangi parolni tasdiqlash"
                            : "Parolni tasdiqlash",
                        style: AppTextStyles.style13.copyWith(
                          color: myTheme.text,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      TextFormField(
                        style: AppTextStyles.style14.copyWith(
                          color: myTheme.text,
                        ),
                        decoration: AppTextFormStyle.textFormFild(
                          color: myTheme.unselctedColor,
                          text: widget.branchName != null
                              ? "Yangi parolni kiriting"
                              : "Filial uchun parol o'ylab toping",
                          prefix: Padding(
                            padding: EdgeInsets.only(left: 12.w, right: 8.w),
                            child: Image.asset(
                              widget.branchName != null
                                  ? "assets/img_25.png"
                                  : "assets/img_26.png",
                              width: 18.w,
                              color: myTheme.text,
                            ),
                          ),
                          suffix: Icon(
                            Icons.visibility_outlined,
                            size: 22.w,
                            color: myTheme.text,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Ismni kiriting";
                          }
                          return null;
                        },
                        onChanged: (value) {},
                      ),
                      SizedBox(height: 10.h),
                      Row( mainAxisAlignment: .start,crossAxisAlignment: .start,
                        children: [
                          Image.asset(
                            "assets/img_14.png",
                            width: 16.w,
                            color: myTheme.unselctedColor,
                          ),
                          SizedBox(width: 5.w),
                          Flexible(
                            child: Text(
                              maxLines: 2,
                              textAlign: .start,
                              widget.branchName != null
                                  ? "Parol o'zgartirilganda barcha tizimga qaayta kirishga kerak bo'ladi"
                                  : "Ushbu parol filial ma'murlari tizimga kirishi uchun ishlatiladi",
                              style: AppTextStyles.style12.copyWith(
                                color: myTheme.unselctedColor,
                              ),
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 16.h)),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 48.h,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: AppTextFormStyle.buttonStyleBorder(
                      background: myTheme.globalColor,
                      foreground: myTheme.textColor,
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisSize: .min,
                      children: [
                        Image.asset(
                          "assets/img_25.png",
                          width: 15.w,
                          color: myTheme.textColor,
                        ),
                        Text(
                          widget.branchName == null
                              ? " O'zgarishlarni saqlash"
                              : " Filialni ro'yxatdan o'tkazish",
                          style: AppTextStyles.style14,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 16.h)),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 48.h,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: AppTextFormStyle.buttonStyleBorder(button: true,
                      background: Colors.transparent,
                      foreground: myTheme.text,
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisSize: .min,
                      children: [
                        Text(
                          "Bekor qilish",
                          style: AppTextStyles.style14,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
