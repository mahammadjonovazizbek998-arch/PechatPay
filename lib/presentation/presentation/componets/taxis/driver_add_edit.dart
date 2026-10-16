import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pechat_pay/data/repository/auth.dart';
import 'package:pechat_pay/data/style/text_form_style.dart';
import 'package:pechat_pay/logon/tasks/tasks_cubit.dart';

import '../../../../data/style/text_style.dart';
import '../../../../data/style/validaor.dart';
import '../../../../data/theme/theme_class.dart';
import '../list_tile.dart';

class DriverAddEdit extends StatefulWidget {
  final String? driverName;
  final String? driverPhoneNumber;
  final String? licensePlate;
  final int? id;
  final String? unpaidPechatsCount;
  final String? unpaidPechatsSum;

  const DriverAddEdit({
    super.key,
    this.driverName,
    this.driverPhoneNumber,
    this.licensePlate,
    this.id,
    this.unpaidPechatsSum,
    this.unpaidPechatsCount,
  });

  @override
  State<DriverAddEdit> createState() => _DriverAddEditState();
}

class _DriverAddEditState extends State<DriverAddEdit> {
  final formKey = GlobalKey<FormState>();

  String? name;
  String? phone;
  String? carNumber;

  bool isLoadingShown = false;

  double get shortestSide => MediaQuery.sizeOf(context).shortestSide;

  bool get isPhone => shortestSide < 600;

  bool get isSmallTablet => shortestSide >= 600 && shortestSide < 840;

  bool get isTablet => shortestSide >= 840;

  Future<void> onTap() async {
    if (!formKey.currentState!.validate()) return;

    formKey.currentState!.save();

    if (widget.licensePlate != carNumber ||
        widget.driverName != name ||
        widget.driverPhoneNumber != phone ||
        (widget.driverName == null &&
            widget.driverPhoneNumber == null &&
            widget.licensePlate == null)) {
      setState(() => isLoadingShown = true);

      try {
        final ok = await context.read<TasksCubit>().createUpdateDriver(
          name!,
          phone!,
          carNumber!,
          widget.id,
        );

        if (!mounted) return;

        if (ok) {
          Navigator.pop(context);
        }
      } finally {
        if (mounted) {
          setState(() => isLoadingShown = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            surfaceTintColor: Colors.transparent,
            scrolledUnderElevation: 0,
            elevation: 0,
            backgroundColor: myTheme.globalBackgroundColor,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.driverName != null
                      ? "Haydovchini tahrirlash"
                      : "Haydovchi qo'shish",
                  textAlign: TextAlign.start,
                  style: AppTextStyles.style18.copyWith(
                    fontWeight: FontWeight.bold,
                    color: myTheme.text,
                  ),
                ),
                Text(
                  widget.driverName != null
                      ? "Haydovchi shaxsiy va avtomobil ma'lumotlarini yangilash"
                      : "PechatPay tizimiga yangi haydovchi ro'yxatdan o'tkazish",
                  maxLines: 2,
                  textAlign: TextAlign.start,
                  style: AppTextStyles.style12.copyWith(
                    color: myTheme.text,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ],
            ),
            toolbarHeight: 70.h,
          ),

          body:SafeArea(
            child: Form(
              key: formKey,
              child: Builder(
                builder: (context) {
                  if (isPhone) {
                    return IsPhoneDriverAddEdit(
                      driverName: widget.driverName,
                      driverPhoneNumber: widget.driverPhoneNumber,
                      licensePlate: widget.licensePlate,
                      id: widget.id,
                      unpaidPechatsCount: widget.unpaidPechatsCount,
                      unpaidPechatsSum: widget.unpaidPechatsSum,
                      onTap: onTap,
                    );
                  } else if (isSmallTablet) {
                    return IsSmallTabletDriverAddEdit(
                      driverName: widget.driverName,
                      driverPhoneNumber: widget.driverPhoneNumber,
                      licensePlate: widget.licensePlate,
                      id: widget.id,
                      unpaidPechatsCount: widget.unpaidPechatsCount,
                      unpaidPechatsSum: widget.unpaidPechatsSum,
                      onTap: onTap,
                    );
                  } else {
                    return IsTabletDriverAddEdit(
                      driverName: widget.driverName,
                      driverPhoneNumber: widget.driverPhoneNumber,
                      licensePlate: widget.licensePlate,
                      id: widget.id,
                      unpaidPechatsCount: widget.unpaidPechatsCount,
                      unpaidPechatsSum: widget.unpaidPechatsSum,
                      onTap: onTap,
                    );
                  }
                },
              ),
            ),
          )
        ),

        if (isLoadingShown)
          Positioned.fill(
            child: ColoredBox(
              color: Colors.black87.withValues(alpha: 0.7),
              child: Center(
                child: CircularProgressIndicator(color: myTheme.globalColor),
              ),
            ),
          ),
      ],
    );
  }
}

// ============================================================
// TELEFON BODY
// ============================================================

class IsPhoneDriverAddEdit extends StatelessWidget {
  final String? driverName;
  final String? driverPhoneNumber;
  final String? licensePlate;
  final int? id;
  final String? unpaidPechatsCount;
  final String? unpaidPechatsSum;
  final VoidCallback onTap;

  const IsPhoneDriverAddEdit({
    super.key,
    this.driverName,
    this.driverPhoneNumber,
    this.licensePlate,
    this.id,
    this.unpaidPechatsCount,
    this.unpaidPechatsSum,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;

    return BlocBuilder<TasksCubit, TasksState>(
  builder: (context, state) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
          sliver: SliverMainAxisGroup(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 16.h,
                    horizontal: 16.w,
                  ),
                  decoration: AppTextFormStyle.container(
                    color: myTheme.textColor,
                    shadow: true,
                    borderColor: myTheme.unselctedColor.withValues(alpha: 0.5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                          Expanded(
                            child: Text(
                              "HAYDOVCHI IDENTIFIKATORLARI",
                              maxLines: 2,
                              textAlign: TextAlign.start,
                              style: AppTextStyles.style12.copyWith(
                                color: myTheme.text,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "Haydovchi F.I.SH",
                        style: AppTextStyles.style13.copyWith(
                          color: myTheme.text,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      TextFormField(
                        initialValue: driverName,
                        onSaved: (saved) => {},
                        style: AppTextStyles.style14.copyWith(
                          color: myTheme.text,
                        ),
                        decoration: AppTextFormStyle.textFormFild(
                          errorText:
                              state is TasksError &&
                                  state.tokenErorrModel.data != null &&
                                  state.tokenErorrModel.data!.name.isNotEmpty
                              ? state.tokenErorrModel.data!.name[0]
                              : null,
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
                        validator: (value) =>
                            AppValidator.branchName(value: value),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "Aloqa telefon raqami",
                        style: AppTextStyles.style13.copyWith(
                          color: myTheme.text,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      TextFormField(
                        initialValue: driverPhoneNumber?.substring(
                          4,
                          driverPhoneNumber?.length,
                        ),
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.phone,
                        style: AppTextStyles.style14.copyWith(
                          color: myTheme.text,
                        ),
                        decoration: AppTextFormStyle.textFormFild(
                          errorText:
                              state is TasksError &&
                                  state.tokenErorrModel.data != null &&
                                  state.tokenErorrModel.data!.phone.isNotEmpty
                              ? state.tokenErorrModel.data!.phone[0]
                              : null,
                          color: myTheme.unselctedColor,
                          text: "90 123 45 67",
                          prefix: Padding(
                            padding: EdgeInsets.only(left: 12.w, right: 8.w),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
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
                        validator: (value) => AppValidator.phone(value: value),
                      ),
                    ],
                  ),
                ),
              ),

              SliverToBoxAdapter(child: SizedBox(height: 16.h)),

              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 16.h,
                    horizontal: 16.w,
                  ),
                  decoration: AppTextFormStyle.container(
                    color: myTheme.textColor,
                    shadow: true,
                    borderColor: myTheme.unselctedColor.withValues(alpha: 0.5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                          Expanded(
                            child: Text(
                              "AVTOMOBIL PARAMETRLARI",
                              maxLines: 2,
                              style: AppTextStyles.style12.copyWith(
                                color: myTheme.text,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "Avtomobil davlat raqami",
                        style: AppTextStyles.style13.copyWith(
                          color: myTheme.text,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Container(
                        decoration: AppTextFormStyle.container(
                          color: myTheme.text.withValues(alpha: 0.09),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 6.h,
                          horizontal: 6.w,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                initialValue: AuthRepository.formatPlate(
                                  licensePlate,
                                ),
                                keyboardType: TextInputType.visiblePassword,
                                textCapitalization:
                                    TextCapitalization.characters,
                                textAlign: TextAlign.center,
                                textAlignVertical: TextAlignVertical.center,
                                inputFormatters: [PlateFormatter()],
                                style: AppTextStyles.style14.copyWith(
                                  color: myTheme.text,
                                ),
                                decoration: AppTextFormStyle.licensePlate(
                                  color: myTheme.unselctedColor,
                                  text: '40 A777AA',
                                  errorText:
                                      state is TasksError &&
                                          state.tokenErorrModel.data != null &&
                                          state
                                              .tokenErorrModel
                                              .data!
                                              .carNumber
                                              .isNotEmpty
                                      ? state.tokenErorrModel.data!.carNumber[0]
                                      : null,
                                ),
                                validator: (value) =>
                                    AppValidator.licensePlate(value: value),
                                onSaved: (value) {},
                              ),
                            ),
                            SizedBox(width: 6.w),
                            Container(
                              alignment: Alignment.center,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.question_mark,
                            size: 12.w,
                            color: myTheme.unselctedColor,
                          ),
                          Expanded(
                            child: Text(
                              "Tizimda avtomashinani tezkor qidirish va "
                              "identifikatsiya qilish uchun xizmat qiladi",
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
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 16.h,
                    horizontal: 16.w,
                  ),
                  decoration: AppTextFormStyle.container(
                    color: myTheme.textColor,
                    shadow: true,
                    borderColor: myTheme.unselctedColor.withValues(alpha: 0.5),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 16.h,
                      horizontal: 16.w,
                    ),
                    decoration: AppTextFormStyle.container(
                      color: myTheme.globalColor.withValues(alpha: 0.03),
                      borderColor: myTheme.globalColor.withValues(alpha: 0.4),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ContainerWidget(
                          vertical: 40.h,
                          horizontal: 38.w,
                          assets: driverName == null
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                driverName == null
                                    ? "Boshlang'ich balans: 0 ta muhr"
                                    : "Joriy balans: $unpaidPechatsCount ta muhr "
                                          "(${AuthRepository.formatSum(unpaidPechatsSum.toString())} so'm)",
                                style: AppTextStyles.style13.copyWith(
                                  color: myTheme.globalColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                driverName == null
                                    ? "Haydovchi qo'shilgandan so'ng, qidiruv "
                                          "orqali unga har bir mijoz tashrifi "
                                          "uchun zudlik bilan birinchi muhr "
                                          "berishingiz mumkin."
                                    : "Haydovchi ma'lumotlari yangilanganda "
                                          "to'plangan muhrlar va operatsiyalar "
                                          "tarixi saqlanib qoladi.",
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
                  width: double.infinity,
                  child: ElevatedButton(
                    style: AppTextFormStyle.buttonStyleBorder(
                      background: myTheme.globalColor,
                      foreground: myTheme.textColor,
                    ),
                    onPressed: onTap,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          "assets/img_25.png",
                          width: 15.w,
                          color: myTheme.textColor,
                        ),
                        Text(
                          driverName == null
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
                  width: double.infinity,
                  child: ElevatedButton(
                    style: AppTextFormStyle.buttonStyleBorder(
                      button: true,
                      background: Colors.transparent,
                      foreground: myTheme.text,
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Text("Bekor qilish", style: AppTextStyles.style14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  },
);
  }
}


class IsSmallTabletDriverAddEdit extends StatelessWidget {
  final String? driverName;
  final String? driverPhoneNumber;
  final String? licensePlate;
  final int? id;
  final String? unpaidPechatsCount;
  final String? unpaidPechatsSum;
  final VoidCallback onTap;

  const IsSmallTabletDriverAddEdit({
    super.key,
    this.driverName,
    this.driverPhoneNumber,
    this.licensePlate,
    this.id,
    this.unpaidPechatsCount,
    this.unpaidPechatsSum,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;

    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) {
        return CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 30.w),
              sliver: SliverMainAxisGroup(
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 16.h,
                        horizontal: 16.w,
                      ),
                      decoration: AppTextFormStyle.container(
                        color: myTheme.textColor,
                        shadow: true,
                        borderColor: myTheme.unselctedColor.withValues(alpha: 0.5),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                              Expanded(
                                child: Text(
                                  "HAYDOVCHI IDENTIFIKATORLARI",
                                  maxLines: 2,
                                  textAlign: TextAlign.start,
                                  style: AppTextStyles.style12.copyWith(
                                    color: myTheme.text,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            "Haydovchi F.I.SH",
                            style: AppTextStyles.style13.copyWith(
                              color: myTheme.text,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          TextFormField(
                            initialValue: driverName,
                            onSaved: (saved) => {},
                            style: AppTextStyles.style14.copyWith(
                              color: myTheme.text,
                            ),
                            decoration: AppTextFormStyle.textFormFild(
                              errorText:
                              state is TasksError &&
                                  state.tokenErorrModel.data != null &&
                                  state.tokenErorrModel.data!.name.isNotEmpty
                                  ? state.tokenErorrModel.data!.name[0]
                                  : null,
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
                            validator: (value) =>
                                AppValidator.branchName(value: value),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            "Aloqa telefon raqami",
                            style: AppTextStyles.style13.copyWith(
                              color: myTheme.text,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          TextFormField(
                            initialValue: driverPhoneNumber?.substring(
                              4,
                              driverPhoneNumber?.length,
                            ),
                            textAlign: TextAlign.start,
                            keyboardType: TextInputType.phone,
                            style: AppTextStyles.style14.copyWith(
                              color: myTheme.text,
                            ),
                            decoration: AppTextFormStyle.textFormFild(
                              errorText:
                              state is TasksError &&
                                  state.tokenErorrModel.data != null &&
                                  state.tokenErorrModel.data!.phone.isNotEmpty
                                  ? state.tokenErorrModel.data!.phone[0]
                                  : null,
                              color: myTheme.unselctedColor,
                              text: "90 123 45 67",
                              prefix: Padding(
                                padding: EdgeInsets.only(left: 12.w, right: 8.w),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
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
                            validator: (value) => AppValidator.phone(value: value),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SliverToBoxAdapter(child: SizedBox(height: 16.h)),

                  SliverToBoxAdapter(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 16.h,
                        horizontal: 16.w,
                      ),
                      decoration: AppTextFormStyle.container(
                        color: myTheme.textColor,
                        shadow: true,
                        borderColor: myTheme.unselctedColor.withValues(alpha: 0.5),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                              Expanded(
                                child: Text(
                                  "AVTOMOBIL PARAMETRLARI",
                                  maxLines: 2,
                                  style: AppTextStyles.style12.copyWith(
                                    color: myTheme.text,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            "Avtomobil davlat raqami",
                            style: AppTextStyles.style13.copyWith(
                              color: myTheme.text,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Container(
                            decoration: AppTextFormStyle.container(
                              color: myTheme.text.withValues(alpha: 0.09),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 6.h,
                              horizontal: 6.w,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    initialValue: AuthRepository.formatPlate(
                                      licensePlate,
                                    ),
                                    keyboardType: TextInputType.visiblePassword,
                                    textCapitalization:
                                    TextCapitalization.characters,
                                    textAlign: TextAlign.center,
                                    textAlignVertical: TextAlignVertical.center,
                                    inputFormatters: [PlateFormatter()],
                                    style: AppTextStyles.style14.copyWith(
                                      color: myTheme.text,
                                    ),
                                    decoration: AppTextFormStyle.licensePlate(
                                      color: myTheme.unselctedColor,
                                      text: '40 A777AA',
                                      errorText:
                                      state is TasksError &&
                                          state.tokenErorrModel.data != null &&
                                          state
                                              .tokenErorrModel
                                              .data!
                                              .carNumber
                                              .isNotEmpty
                                          ? state.tokenErorrModel.data!.carNumber[0]
                                          : null,
                                    ),
                                    validator: (value) =>
                                        AppValidator.licensePlate(value: value),
                                    onSaved: (value) {},
                                  ),
                                ),
                                SizedBox(width: 6.w),
                                Container(
                                  alignment: Alignment.center,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.question_mark,
                                size: 12.w,
                                color: myTheme.unselctedColor,
                              ),
                              Expanded(
                                child: Text(
                                  "Tizimda avtomashinani tezkor qidirish va "
                                      "identifikatsiya qilish uchun xizmat qiladi",
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
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 16.h,
                        horizontal: 16.w,
                      ),
                      decoration: AppTextFormStyle.container(
                        color: myTheme.textColor,
                        shadow: true,
                        borderColor: myTheme.unselctedColor.withValues(alpha: 0.5),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 16.h,
                          horizontal: 16.w,
                        ),
                        decoration: AppTextFormStyle.container(
                          color: myTheme.globalColor.withValues(alpha: 0.03),
                          borderColor: myTheme.globalColor.withValues(alpha: 0.4),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ContainerWidget(
                              vertical: 40.h,
                              horizontal: 38.w,
                              assets: driverName == null
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    driverName == null
                                        ? "Boshlang'ich balans: 0 ta muhr"
                                        : "Joriy balans: $unpaidPechatsCount ta muhr "
                                        "(${AuthRepository.formatSum(unpaidPechatsSum.toString())} so'm)",
                                    style: AppTextStyles.style13.copyWith(
                                      color: myTheme.globalColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    driverName == null
                                        ? "Haydovchi qo'shilgandan so'ng, qidiruv "
                                        "orqali unga har bir mijoz tashrifi "
                                        "uchun zudlik bilan birinchi muhr "
                                        "berishingiz mumkin."
                                        : "Haydovchi ma'lumotlari yangilanganda "
                                        "to'plangan muhrlar va operatsiyalar "
                                        "tarixi saqlanib qoladi.",
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
                      width: double.infinity,
                      child: ElevatedButton(
                        style: AppTextFormStyle.buttonStyleBorder(
                          background: myTheme.globalColor,
                          foreground: myTheme.textColor,
                        ),
                        onPressed: onTap,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              "assets/img_25.png",
                              width: 15.w,
                              color: myTheme.textColor,
                            ),
                            Text(
                              driverName == null
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
                      width: double.infinity,
                      child: ElevatedButton(
                        style: AppTextFormStyle.buttonStyleBorder(
                          button: true,
                          background: Colors.transparent,
                          foreground: myTheme.text,
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: Text("Bekor qilish", style: AppTextStyles.style14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class IsTabletDriverAddEdit extends StatelessWidget {
  final String? driverName;
  final String? driverPhoneNumber;
  final String? licensePlate;
  final int? id;
  final String? unpaidPechatsCount;
  final String? unpaidPechatsSum;

  final VoidCallback onTap;

  const IsTabletDriverAddEdit({
    super.key,
    this.driverName,
    this.driverPhoneNumber,
    this.licensePlate,
    this.id,
    this.unpaidPechatsCount,
    this.unpaidPechatsSum,

    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;

    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) {
        return CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
              sliver: SliverMainAxisGroup(
                slivers: [
                  SliverToBoxAdapter(child: Row(children: [ Flexible(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 16.h,
                        horizontal: 16.w,
                      ),
                      decoration: AppTextFormStyle.container(
                        color: myTheme.textColor,
                        shadow: true,
                        borderColor: myTheme.unselctedColor.withValues(alpha: 0.5),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                              Expanded(
                                child: Text(
                                  "HAYDOVCHI IDENTIFIKATORLARI",
                                  maxLines: 2,
                                  textAlign: TextAlign.start,
                                  style: AppTextStyles.style12.copyWith(
                                    color: myTheme.text,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            "Haydovchi F.I.SH",
                            style: AppTextStyles.style13.copyWith(
                              color: myTheme.text,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          TextFormField(
                            initialValue: driverName,
                            onSaved: (saved) => {},
                            style: AppTextStyles.style14.copyWith(
                              color: myTheme.text,
                            ),
                            decoration: AppTextFormStyle.textFormFild(
                              errorText:
                              state is TasksError &&
                                  state.tokenErorrModel.data != null &&
                                  state.tokenErorrModel.data!.name.isNotEmpty
                                  ? state.tokenErorrModel.data!.name[0]
                                  : null,
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
                            validator: (value) =>
                                AppValidator.branchName(value: value),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            "Aloqa telefon raqami",
                            style: AppTextStyles.style13.copyWith(
                              color: myTheme.text,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          TextFormField(
                            initialValue: driverPhoneNumber?.substring(
                              4,
                              driverPhoneNumber?.length,
                            ),
                            textAlign: TextAlign.start,
                            keyboardType: TextInputType.phone,
                            style: AppTextStyles.style14.copyWith(
                              color: myTheme.text,
                            ),
                            decoration: AppTextFormStyle.textFormFild(
                              errorText:
                              state is TasksError &&
                                  state.tokenErorrModel.data != null &&
                                  state.tokenErorrModel.data!.phone.isNotEmpty
                                  ? state.tokenErorrModel.data!.phone[0]
                                  : null,
                              color: myTheme.unselctedColor,
                              text: "90 123 45 67",
                              prefix: Padding(
                                padding: EdgeInsets.only(left: 12.w, right: 8.w),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
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
                            validator: (value) => AppValidator.phone(value: value),
                          ),
                        ],
                      ),
                    ),
                  ), SizedBox(width: 16.h,),Flexible(child:  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 24.h,
                      horizontal: 16.w,
                    ),
                    decoration: AppTextFormStyle.container(
                      color: myTheme.textColor,
                      shadow: true,
                      borderColor: myTheme.unselctedColor.withValues(alpha: 0.5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                            Expanded(
                              child: Text(
                                "AVTOMOBIL PARAMETRLARI",
                                maxLines: 2,
                                style: AppTextStyles.style12.copyWith(
                                  color: myTheme.text,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          "Avtomobil davlat raqami",
                          style: AppTextStyles.style13.copyWith(
                            color: myTheme.text,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Container(
                          decoration: AppTextFormStyle.container(
                            color: myTheme.text.withValues(alpha: 0.09),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 6.h,
                            horizontal: 6.w,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  initialValue: AuthRepository.formatPlate(
                                    licensePlate,
                                  ),
                                  keyboardType: TextInputType.visiblePassword,
                                  textCapitalization:
                                  TextCapitalization.characters,
                                  textAlign: TextAlign.center,
                                  textAlignVertical: TextAlignVertical.center,
                                  inputFormatters: [PlateFormatter()],
                                  style: AppTextStyles.style14.copyWith(
                                    color: myTheme.text,
                                  ),
                                  decoration: AppTextFormStyle.licensePlate(
                                    color: myTheme.unselctedColor,
                                    text: '40 A777AA',
                                    errorText:
                                    state is TasksError &&
                                        state.tokenErorrModel.data != null &&
                                        state
                                            .tokenErorrModel
                                            .data!
                                            .carNumber
                                            .isNotEmpty
                                        ? state.tokenErorrModel.data!.carNumber[0]
                                        : null,
                                  ),
                                  validator: (value) =>
                                      AppValidator.licensePlate(value: value),
                                  onSaved: (value) {},
                                ),
                              ),
                              SizedBox(width: 6.w),
                              Container(
                                alignment: Alignment.center,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.question_mark,
                              size: 12.w,
                              color: myTheme.unselctedColor,
                            ),
                            Expanded(
                              child: Text(
                                "Tizimda avtomashinani tezkor qidirish va "
                                    "identifikatsiya qilish uchun xizmat qiladi",
                                style: AppTextStyles.style12.copyWith(
                                  color: myTheme.unselctedColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),)],),),
                  

                  SliverToBoxAdapter(child: SizedBox(height: 16.h)),

                  SliverToBoxAdapter(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 16.h,
                        horizontal: 16.w,
                      ),
                      decoration: AppTextFormStyle.container(
                        color: myTheme.textColor,
                        shadow: true,
                        borderColor: myTheme.unselctedColor.withValues(alpha: 0.5),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 16.h,
                          horizontal: 16.w,
                        ),
                        decoration: AppTextFormStyle.container(
                          color: myTheme.globalColor.withValues(alpha: 0.03),
                          borderColor: myTheme.globalColor.withValues(alpha: 0.4),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ContainerWidget(
                              vertical: 40.h,
                              horizontal: 38.w,
                              assets: driverName == null
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    driverName == null
                                        ? "Boshlang'ich balans: 0 ta muhr"
                                        : "Joriy balans: $unpaidPechatsCount ta muhr "
                                        "(${AuthRepository.formatSum(unpaidPechatsSum.toString())} so'm)",
                                    style: AppTextStyles.style13.copyWith(
                                      color: myTheme.globalColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    driverName == null
                                        ? "Haydovchi qo'shilgandan so'ng, qidiruv "
                                        "orqali unga har bir mijoz tashrifi "
                                        "uchun zudlik bilan birinchi muhr "
                                        "berishingiz mumkin."
                                        : "Haydovchi ma'lumotlari yangilanganda "
                                        "to'plangan muhrlar va operatsiyalar "
                                        "tarixi saqlanib qoladi.",
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
                      width: double.infinity,
                      child: ElevatedButton(
                        style: AppTextFormStyle.buttonStyleBorder(
                          background: myTheme.globalColor,
                          foreground: myTheme.textColor,
                        ),
                        onPressed: onTap,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              "assets/img_25.png",
                              width: 15.w,
                              color: myTheme.textColor,
                            ),
                            Text(
                              driverName == null
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
                      width: double.infinity,
                      child: ElevatedButton(
                        style: AppTextFormStyle.buttonStyleBorder(
                          button: false,
                          background: Colors.transparent,
                          foreground: myTheme.text,
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: Text("Bekor qilish", style: AppTextStyles.style14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}


class PlateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var raw = newValue.text
        .replaceAll(RegExp(r'[^a-zA-Z0-9]'), '')
        .toUpperCase();

    if (raw.length > 8) {
      raw = raw.substring(0, 8);
    }

    final head = raw.length >= 2 ? raw.substring(0, 2) : raw;

    if (!RegExp(r'^\d*$').hasMatch(head)) {
      return oldValue;
    }

    final text = raw.length <= 2
        ? raw
        : '${raw.substring(0, 2)} ${raw.substring(2)}';

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
