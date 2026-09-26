import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pechat_pay/data/style/text_form_style.dart';

import '../../../../data/style/text_style.dart';
import '../../../../data/theme/theme_class.dart';
import '../list_tile.dart';

class DriverAddEdit extends StatefulWidget {
  final String? driverName;
  final String? driverPhoneNumber;
  final String? licensePlate;

  const DriverAddEdit({
    super.key,
    this.driverName,
    this.driverPhoneNumber,
    this.licensePlate,
  });

  @override
  State<DriverAddEdit> createState() => _DriverAddEditState();
}

class _DriverAddEditState extends State<DriverAddEdit> {
  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .start,
          children: [
            Text(
              textAlign: .start,
              widget.driverName != null
                  ? "Haydovchini tahrirlash"
                  : "Haydovchi qo'shish",
              style: AppTextStyles.style18.copyWith(
                fontWeight: .bold,
                color: myTheme.text,
              ),
            ),
            Text(
              maxLines: 2,
              textAlign: .start,
              widget.driverName != null
                  ? "Haydovchi shaxsiy va avtomobil ma'lumotlarini yangilash"
                  : "PechatPay tizimiga yangi haydovchi ro'yxatdan o'tkazish",
              style: AppTextStyles.style12.copyWith(
                color: myTheme.text,
                fontWeight: .w100,
              ),
            ),
          ],
        ),
        toolbarHeight: 70.h,
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
                            "HAYDOVCHI IDENTIFIKATORLARI",
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
                        "Haydovchi F.I.SH",
                        style: AppTextStyles.style13.copyWith(
                          color: myTheme.text,
                          fontWeight: .bold,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      TextFormField(
                        initialValue: widget.driverName,
                        style: AppTextStyles.style14.copyWith(
                          color: myTheme.text,
                        ),
                        decoration: AppTextFormStyle.textFormFild(
                          color: myTheme.unselctedColor,
                          text: "Masalan: Jasur Olimov",
                          prefix: Padding(
                            padding: EdgeInsets.only(left: 12.w, right: 8.w),
                            child: Icon(
                              Icons.person_outline,
                              size: 20.w,
                              color: myTheme.unselctedColor,
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
                        initialValue: widget.driverPhoneNumber,
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
                            assets: "assets/img_21.png",
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
                            "AVTOMOBIL PARAMETRLARI",
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
                        "Avtomobil davlat raqami",
                        style: AppTextStyles.style13.copyWith(
                          color: myTheme.text,
                          fontWeight: .bold,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Container(
                        decoration: AppTextFormStyle.container(
                          color: myTheme.text.withValues(alpha: 0.09),
                        ),
                        padding: .symmetric(vertical: 6.h, horizontal: 6.w),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 40.h,
                              width: 60.w,
                              child: TextFormField(
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(2),
                                ],
                                maxLines: 2,
                                textAlignVertical: .center,
                                textAlign: .center,
                                keyboardType: .number,
                                initialValue: widget.licensePlate?.substring(
                                  0,
                                  2,
                                ),
                                style: AppTextStyles.style14.copyWith(
                                  color: myTheme.text,
                                ),
                                decoration: AppTextFormStyle.textFormFild(
                                  licensePlate: true,
                                  color: myTheme.unselctedColor,
                                  text: "01",
                                  prefix: null,
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Ismni kiriting";
                                  }
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ),
                            SizedBox(width: 6.w),
                            SizedBox(
                              height: 40.h,
                              width: 180.w,
                              child: TextFormField(
                                textAlignVertical: .center,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(6),
                                ],
                                textAlign: .center,

                                initialValue: widget.licensePlate?.substring(
                                  2,
                                  widget.licensePlate?.length,
                                ),
                                style: AppTextStyles.style14.copyWith(
                                  color: myTheme.text,
                                ),
                                decoration: AppTextFormStyle.textFormFild(
                                  licensePlate: true,
                                  color: myTheme.unselctedColor,
                                  text: "A777AA",
                                  prefix: null,
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Ismni kiriting";
                                  }
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ),
                            SizedBox(width: 6.w),
                            Container(
                              alignment: .center,
                              height: 37.h,
                              width: 60.w,
                              decoration: AppTextFormStyle.container(
                                borderColor: myTheme.text,
                                color: myTheme.textColor,
                              ),
                              child: Text(
                                "uz",
                                style: AppTextStyles.style16.copyWith(
                                  color: myTheme.globalColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Row(
                        mainAxisAlignment: .start,
                        crossAxisAlignment: .start,
                        children: [
                          Icon(
                            Icons.question_mark,
                            size: 12.w,
                            color: myTheme.unselctedColor,
                          ),
                          Text(
                            textAlign: .start,
                            "Tizimda avtomashinani tezkor qidirish va \nidentifikatsiya qilish uchun xizmat qiladi",
                            style: AppTextStyles.style12.copyWith(
                              color: myTheme.unselctedColor,
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
                child: Container(
                  padding: .symmetric(vertical: 16.h, horizontal: 16.w),
                  decoration: AppTextFormStyle.container(
                    color: myTheme.textColor,
                    shadow: true,
                    borderColor: myTheme.unselctedColor.withValues(alpha: 0.5),
                  ),
                  child: Container(
                    padding: .symmetric(vertical: 16.h, horizontal: 16.w),
                    decoration: AppTextFormStyle.container(
                      color: myTheme.globalColor.withValues(alpha: 0.03),
                      borderColor: myTheme.globalColor.withValues(alpha: 0.4),
                    ),
                    child: Row(
                      crossAxisAlignment: .start,
                      mainAxisAlignment: .start,
                      children: [
                        ContainerWidget(
                          vertical: 40.h,
                          horizontal: 38.w,
                          assets: widget.driverName == null
                              ? "assets/img_30.png"
                              : "assets/img_31.png",
                          assetsHorizontal: 20.w,
                          assetsVertical: 20.h,
                          assetsColor: myTheme.globalColor,
                          boxDecoration: AppTextFormStyle.container(
                            color: myTheme.globalColor.withValues(alpha: 0.1),
                          ),
                        ),
                        SizedBox(width: 5.w),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: .start,
                            crossAxisAlignment: .start,
                            children: [
                              Text(
                                maxLines: 2,
                                textAlign: .start,
                                widget.driverName == null
                                    ? "Boshlang'ich balans: 0 ta muhr"
                                    : "Joriy balans: 4 ta muhr (200 000 so'm)",
                                style: AppTextStyles.style13.copyWith(
                                  color: myTheme.globalColor,
                                  fontWeight: .bold,
                                ),
                              ),
                              Text(
                                textAlign: .start,
                                widget.driverName == null
                                    ? "Haydovchi qo'shilgandan so'ng, qidiruv orqali unga har bir mijoz tashrifi uchun zudlik bilanbirinchi muhr berishingiz mumkin."
                                    : "Haydovchi ma'lumotlari yangilanganda to'plangan muhrlar va operatsiyalar tarixi saqlanib qoladi.",
                                style: AppTextStyles.style12.copyWith(
                                  color: myTheme.text,
                                ),
                              ),
                            ],
                          ),
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
                          widget.driverName == null
                              ? " Haydovchini saqlash"
                              : " O'zgarishlarni saqlash",
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
