import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pechat_pay/data/style/validaor.dart';
import 'package:pechat_pay/logon/login/login_cubit.dart';
import 'package:pechat_pay/logon/profil/profil_cubit.dart';

import '../../../../data/style/text_form_style.dart';
import '../../../../data/style/text_style.dart';
import '../../../../data/theme/theme_class.dart';
import '../../../../data/token_model/token_model.dart';
import '../list_tile.dart';

class BranchAddEdi extends StatefulWidget {
  final bool ediAdd;
  final TokenModelApiUserModel? tokenModelApiUserModel;

  const BranchAddEdi({
    super.key,
    this.ediAdd = false,
    this.tokenModelApiUserModel,
  });

  @override
  State<BranchAddEdi> createState() => _BranchAddEdiState();
}

class _BranchAddEdiState extends State<BranchAddEdi> {
  late final TextEditingController passwordController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  Future<void> onTap() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if (widget.ediAdd && widget.tokenModelApiUserModel==null) {
        await context.read<ProfilCubit>().meUpdate(
          name,
          phone,
          currentPassword!,
          passwordConfirmation,
          stampPrice,
          passwordController.text,
        );
      }else{
        await context.read<ProfilCubit>().filiallUpdate(
          name,
          phone,
          currentPassword,
          passwordConfirmation,
          stampPrice,
          passwordController.text,
          widget.tokenModelApiUserModel?.id
        );
      }
    }
  }

   String name="";
   String phone="";
   String? currentPassword;
   String passwordConfirmation="";
   String stampPrice="";

  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (contx, holat) {
        return Scaffold(
          appBar: AppBar(
            title: Column(
              mainAxisAlignment: .start,
              crossAxisAlignment: .start,
              mainAxisSize: .min,
              children: [
                Text(
                  textAlign: .start,
                  !widget.ediAdd
                      ? "Yangi filial qo'shish"
                      : "Filialni tahrirlash",
                  style: AppTextStyles.style18.copyWith(
                    fontWeight: .bold,
                    color: myTheme.text,
                  ),
                ),
                Text(
                  textAlign: .start,

                  widget.ediAdd
                      ? "PechatPay filial ma'lumotlarini yangilash"
                      : "Yangi filial parametrlarini kiriting va yarating",
                  style: AppTextStyles.style10.copyWith(
                    fontWeight: .w400,
                    color: myTheme.text.withValues(alpha: 0.9),
                  ),
                ),
              ],
            ),
          ),
          body: Form(
            key: formKey,
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
                        borderColor: myTheme.unselctedColor.withValues(
                          alpha: 0.5,
                        ),
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
                          BlocBuilder<ProfilCubit, ProfilState>(
                            builder: (context, state) {
                              return TextFormField(
                                onSaved: (saved) {
                                  name = saved!;
                                },
                                initialValue: widget.ediAdd
                                    ? widget.tokenModelApiUserModel != null
                                          ? widget.tokenModelApiUserModel!.name
                                          : holat.token?.name
                                    : null,
                                style: AppTextStyles.style14.copyWith(
                                  color: myTheme.text,
                                ),
                                decoration: AppTextFormStyle.textFormFild(
                                  errorText: state is ProfilError
                                      ? state.tokenErorrModel.data != null
                                            ? state
                                                      .tokenErorrModel
                                                      .data!
                                                      .name
                                                      .isNotEmpty
                                                  ? state
                                                        .tokenErorrModel
                                                        .data!
                                                        .name[0]
                                                  : null
                                            : null
                                      : null,
                                  color: myTheme.unselctedColor,
                                  text: "Masalan, PechatPay — Yunusobod",
                                  prefix: Padding(
                                    padding: EdgeInsets.only(
                                      left: 12.w,
                                      right: 8.w,
                                    ),
                                    child: Image.asset(
                                      "assets/shop.png",
                                      width: 16.w,
                                      color: myTheme.text,
                                    ),
                                  ),
                                ),
                                validator: (value) =>
                                    AppValidator.branchName(value: value),
                                onChanged: (value) {},
                              );
                            },
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
                          BlocBuilder<ProfilCubit, ProfilState>(
                            builder: (context, state) {
                              return TextFormField(
                                onSaved: (saved) {
                                  phone = saved!;
                                },
                                textAlign: .start,
                                keyboardType: .phone,
                                initialValue: widget.ediAdd
                                    ? widget.tokenModelApiUserModel != null
                                          ? widget.tokenModelApiUserModel!.phone
                                                .substring(
                                                  4,
                                                  widget
                                                      .tokenModelApiUserModel!
                                                      .phone
                                                      .length,
                                                )
                                          : holat.token?.phone.substring(
                                              4,
                                              holat.token?.phone.length,
                                            )
                                    : null,
                                style: AppTextStyles.style14.copyWith(
                                  color: myTheme.text,
                                ),
                                decoration: AppTextFormStyle.textFormFild(
                                  errorText: state is ProfilError
                                      ? state.tokenErorrModel.data != null
                                            ? state
                                                      .tokenErorrModel
                                                      .data!
                                                      .phone
                                                      .isNotEmpty
                                                  ? state
                                                        .tokenErorrModel
                                                        .data!
                                                        .phone[0]
                                                  : null
                                            : null
                                      : null,
                                  color: myTheme.unselctedColor,
                                  text: "90 123 45 67",
                                  prefix: Padding(
                                    padding: EdgeInsets.only(
                                      left: 12.w,
                                      right: 8.w,
                                    ),
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
                                validator: (value) =>
                                    AppValidator.phone(value: value),

                                onChanged: (value) {},
                              );
                            },
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
                        borderColor: myTheme.unselctedColor.withValues(
                          alpha: 0.5,
                        ),
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
                            onSaved: (saved) {
                              stampPrice = saved!;
                            },
                            initialValue: widget.ediAdd
                                ? widget.tokenModelApiUserModel != null
                                      ? widget
                                            .tokenModelApiUserModel!
                                            .stampPrice
                                            .toString()
                                      : holat.token?.stampPrice.toString()
                                : null,
                            style: AppTextStyles.style14.copyWith(
                              color: myTheme.text,
                            ),
                            decoration: AppTextFormStyle.textFormFild(
                              suffix: Container(
                                width: 90.w,
                                height: 38.h,
                                alignment: .center,
                                margin: .symmetric(
                                  horizontal: 5.w,
                                  vertical: 5.h,
                                ),
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
                              text: "Masalan, 50 000",
                              prefix: Padding(
                                padding: EdgeInsets.only(
                                  left: 12.w,
                                  right: 8.w,
                                ),
                                child: Image.asset(
                                  "assets/img_15.png",
                                  width: 16.w,
                                  color: myTheme.text,
                                ),
                              ),
                            ),
                            validator: (value) =>
                                AppValidator.summa(value: value),
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
                        borderColor: myTheme.unselctedColor.withValues(
                          alpha: 0.5,
                        ),
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
                              trailing: BlocBuilder<ProfilCubit, ProfilState>(
                                builder: (context, state) {
                                  return GestureDetector(
                                    child: Container(
                                      width: 90.w,
                                      decoration: AppTextFormStyle.container(
                                        color: myTheme.textColor,
                                      ),
                                      padding: .symmetric(
                                        vertical: 8.h,
                                        horizontal: 6.w,
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            widget.ediAdd
                                                ? state.shift1End != null &&
                                                          state.shift1Start !=
                                                              null
                                                      ? "${state.shift1Start!.substring(0, 5)} - ${state.shift1End!.substring(0, 5)}"
                                                      : "${holat.token!.shift1Start.substring(0, 5)} - ${holat.token!.shift1End.substring(0, 5)}"
                                                : "08:00 - 20:00",
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () async {
                                      TimeOfDay? tanlanganVaqt = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                        helpText: "Kunduzgi smenani boshlanish vaqtni tanlang",
                                        barrierColor: myTheme.globalBackgroundColor,
                                      );
                                      if (!context.mounted) return;
                                      TimeOfDay? tanlanganVaqt1 = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                        helpText: "Kunduzgi smenani tugash vaqtni tanlang",
                                        barrierColor: myTheme.globalBackgroundColor,
                                      );
                                      if (!context.mounted) return;
                                      if (tanlanganVaqt != null && tanlanganVaqt1 != null) {
                                        String vaqtFormat(TimeOfDay vaqt) =>
                                            "${vaqt.hour.toString().padLeft(2, '0')}:${vaqt.minute.toString().padLeft(2, '0')}:00";

                                        context.read<ProfilCubit>().itmeOfDay(
                                          state.shift2Start,
                                          state.shift2End,
                                          vaqtFormat(tanlanganVaqt),
                                          vaqtFormat(tanlanganVaqt1),
                                          state.stampPauseHours,
                                        );
                                      }
                                    },
                                  );
                                },
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
                                  color: myTheme.shiftColor.withValues(
                                    alpha: 0.1,
                                  ),
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
                              trailing: BlocBuilder<ProfilCubit, ProfilState>(
                                builder: (context, state) {
                                  return GestureDetector(
                                    child: Container(
                                      width: 90.w,
                                      decoration: AppTextFormStyle.container(
                                        color: myTheme.textColor,
                                      ),
                                      padding: .symmetric(
                                        vertical: 8.h,
                                        horizontal: 6.w,
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            widget.ediAdd
                                                ? state.shift2End != null &&
                                                          state.shift2Start !=
                                                              null
                                                      ? "${state.shift2Start!.substring(0, 5)} - ${state.shift2End!.substring(0, 5)}"
                                                      : "${holat.token!.shift2Start.substring(0, 5)} - ${holat.token!.shift2End.substring(0, 5)}"
                                                : "20:00 - 08:00",
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () async {
                                      {
                                        TimeOfDay? tanlanganVaqt = await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                          helpText: "Tungi smenani boshlanish vaqtni tanlang",
                                          barrierColor: myTheme.globalBackgroundColor,
                                        );
                                        if (!context.mounted) return;
                                        TimeOfDay? tanlanganVaqt1 = await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                          helpText: "Tungi smenani tugash vaqtni tanlang",
                                          barrierColor: myTheme.globalBackgroundColor,
                                        );
                                        if (!context.mounted) return;
                                        if (tanlanganVaqt != null && tanlanganVaqt1 != null) {
                                          String vaqtFormat(TimeOfDay vaqt) =>
                                              "${vaqt.hour.toString().padLeft(2, '0')}:${vaqt.minute.toString().padLeft(2, '0')}";
                                          context.read<ProfilCubit>().itmeOfDay(
                                            vaqtFormat(tanlanganVaqt),
                                            vaqtFormat(tanlanganVaqt1),
                                            state.shift1Start,
                                            state.shift1End,
                                            state.stampPauseHours,
                                          );
                                        }
                                      }
                                    },
                                  );
                                },
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
                                  color: myTheme.globalColor.withValues(
                                    alpha: 0.1,
                                  ),
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
                        borderColor: myTheme.unselctedColor.withValues(
                          alpha: 0.5,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          Row(
                            children: [
                              ContainerWidget(
                                vertical: 40.h,
                                horizontal: 38.w,
                                assets: "assets/img_36.png",
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
                                "QAYTA MUHR BERISH CHEKLOVI (ANTISPAM)",
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
                            "Qayta muhr berish cheklovi (antispam)",
                            style: AppTextStyles.style12.copyWith(
                              color: myTheme.text,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Container(
                            decoration: AppTextFormStyle.container(
                              color: myTheme.text.withValues(alpha: 0.1),
                            ),
                            child: BlocBuilder<ProfilCubit, ProfilState>(
                              builder: (context, state) {
                                return Row(
                                  mainAxisAlignment: .spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(width: 14.w),
                                        ContainerWidget(
                                          vertical: 40.h,
                                          horizontal: 38.w,
                                          assets: "assets/img_37.png",
                                          assetsHorizontal: 16.75,
                                          assetsVertical: 17.5,
                                          assetsColor: myTheme.globalColor,
                                          boxDecoration:
                                              AppTextFormStyle.container(
                                                color: myTheme.globalColor
                                                    .withValues(alpha: 0.1),
                                              ),
                                        ),
                                        SizedBox(width: 14.w),
                                        Text(
                                          textAlign: .start,
                                          state.stampPauseHours.toString(),
                                          style: AppTextStyles.style14.copyWith(
                                            fontWeight: .bold,
                                            color: myTheme.text,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Column(
                                          mainAxisAlignment: .center,
                                          children: [
                                            GestureDetector(
                                              child: Icon(
                                                Icons.keyboard_arrow_up,
                                                size: 20.w,
                                              ),
                                              onTap: () {
                                                context
                                                    .read<ProfilCubit>()
                                                    .itmeOfDay(
                                                      state.shift2Start,
                                                      state.shift2End,
                                                      state.shift1Start,
                                                      state.shift1End,
                                                      state.stampPauseHours < 24
                                                          ? state.stampPauseHours +
                                                                1
                                                          : state
                                                                .stampPauseHours,
                                                    );
                                              },
                                            ),

                                            GestureDetector(
                                              child: Icon(
                                                Icons.keyboard_arrow_down,
                                                size: 20.w,
                                              ),
                                              onTap: () {
                                                context
                                                    .read<ProfilCubit>()
                                                    .itmeOfDay(
                                                      state.shift2Start,
                                                      state.shift2End,
                                                      state.shift1Start,
                                                      state.shift1End,
                                                      state.stampPauseHours > 0
                                                          ? state.stampPauseHours -
                                                                1
                                                          : state
                                                                .stampPauseHours,
                                                    );
                                              },
                                            ),
                                          ],
                                        ),

                                        Container(
                                          padding: .symmetric(
                                            vertical: 10.h,
                                            horizontal: 10.w,
                                          ),
                                          margin: .symmetric(
                                            vertical: 10.h,
                                            horizontal: 10.w,
                                          ),
                                          decoration:
                                              AppTextFormStyle.container(
                                                color: myTheme.textColor,
                                              ),
                                          child: Text(
                                            "soat",
                                            style: AppTextStyles.style12
                                                .copyWith(
                                                  color: myTheme.globalColor,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Container(
                            padding: .symmetric(
                              vertical: 14.h,
                              horizontal: 14.h,
                            ),
                            decoration: AppTextFormStyle.container(
                              color: myTheme.text.withValues(alpha: 0.09),
                            ),
                            child: Row(
                              mainAxisAlignment: .start,
                              crossAxisAlignment: .start,
                              children: [
                                Image.asset(
                                  "assets/img_38.png",
                                  width: 12.w,
                                  color: myTheme.text,
                                ),
                                SizedBox(width: 5.w),
                                Flexible(
                                  child: Text(
                                    maxLines: 5,
                                    textAlign: .start,
                                    "Haydovchi bir filialda yoki tarmoqdagi boshqa filialda muhr olgandan so‘ng, belgilangan soatdavomida unga takroriy muhr berish bloklanadi (firibgarlikdan himoya). 0 kiritilsa cheklov o‘chiriladi.",
                                    style: AppTextStyles.style12.copyWith(
                                      color: myTheme.text,
                                    ),
                                  ),
                                ),
                              ],
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
                        borderColor: myTheme.unselctedColor.withValues(
                          alpha: 0.5,
                        ),
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
                          if (widget.ediAdd) SizedBox(height: 10.h),
                          if (widget.ediAdd)
                            Text(
                              maxLines: 2,
                              textAlign: .start,
                              "Joriy (eski) parol",
                              style: AppTextStyles.style13.copyWith(
                                color: myTheme.text,
                              ),
                            ),
                          if (widget.ediAdd) SizedBox(height: 5.h),
                          if (widget.ediAdd)
                            BlocBuilder<ProfilCubit, ProfilState>(
                              builder: (context, state) {
                                return TextFormField(
                                  onSaved: (saved) {
                                    currentPassword = saved;
                                  },
                                  obscureText: state.password1,
                                  style: AppTextStyles.style14.copyWith(
                                    color: myTheme.text,
                                  ),
                                  decoration: AppTextFormStyle.textFormFild(
                                    errorText: state is ProfilError
                                        ? state.tokenErorrModel.data != null
                                              ? state
                                                        .tokenErorrModel
                                                        .data!
                                                        .currentPassword
                                                        .isNotEmpty
                                                    ? state
                                                          .tokenErorrModel
                                                          .data!
                                                          .currentPassword[0]
                                                    : null
                                              : null
                                        : null,
                                    color: myTheme.unselctedColor,
                                    text: "Masalan, Password",
                                    prefix: Padding(
                                      padding: EdgeInsets.only(
                                        left: 12.w,
                                        right: 8.w,
                                      ),
                                      child: Icon(
                                        Icons.lock_open,
                                        size: 18.w,
                                        color: myTheme.text,
                                      ),
                                    ),
                                    suffix: GestureDetector(
                                      child: Icon(
                                        !state.password1
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        size: 22.w,
                                        color: myTheme.text,
                                      ),
                                      onTap: () =>
                                          context.read<ProfilCubit>().onTap(
                                            !state.password1,
                                            state.password2,
                                            state.password3,
                                          ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (widget.ediAdd) {
                                      return AppValidator.password(
                                        name: "Joriy parol",
                                        value: value,
                                      );
                                    } else {
                                      return null;
                                    }
                                  },
                                  onChanged: (value) {},
                                );
                              },
                            ),
                          SizedBox(height: 10.h),
                          Text(
                            maxLines: 2,
                            textAlign: .start,
                            widget.ediAdd
                                ? "Yangi filial paroli"
                                : "Filial kirish paroli",
                            style: AppTextStyles.style13.copyWith(
                              color: myTheme.text,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          BlocBuilder<ProfilCubit, ProfilState>(
                            builder: (context, state) {
                              return TextFormField(
                                obscureText: state.password2,
                                controller: passwordController,
                                style: AppTextStyles.style14.copyWith(
                                  color: myTheme.text,
                                ),
                                decoration: AppTextFormStyle.textFormFild(
                                  errorText: state is ProfilError
                                      ? state.tokenErorrModel.data != null
                                            ? state
                                                      .tokenErorrModel
                                                      .data!
                                                      .password
                                                      .isNotEmpty
                                                  ? state
                                                        .tokenErorrModel
                                                        .data!
                                                        .password[0]
                                                  : null
                                            : null
                                      : null,
                                  color: myTheme.unselctedColor,
                                  text: widget.ediAdd
                                      ? "Yangi parolni kiriting"
                                      : "Filial uchun parol o'ylab toping",
                                  prefix: Padding(
                                    padding: EdgeInsets.only(
                                      left: 12.w,
                                      right: 8.w,
                                    ),
                                    child: Icon(
                                      widget.ediAdd
                                          ? Icons.key
                                          : Icons.lock_outline,
                                      size: 18.w,
                                      color: myTheme.text,
                                    ),
                                  ),
                                  suffix: GestureDetector(
                                    child: Icon(
                                      !state.password2
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      size: 22.w,
                                      color: myTheme.text,
                                    ),
                                    onTap: () =>
                                        context.read<ProfilCubit>().onTap(
                                          state.password1,
                                          !state.password2,
                                          state.password3,
                                        ),
                                  ),
                                ),
                                validator: (value) => AppValidator.password(
                                  name: widget.ediAdd ? "Yangi parol" : "Parol",
                                  value: value,
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            maxLines: 2,
                            textAlign: .start,
                            widget.ediAdd
                                ? "Yangi parolni tasdiqlash"
                                : "Parolni tasdiqlash",
                            style: AppTextStyles.style13.copyWith(
                              color: myTheme.text,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          BlocBuilder<ProfilCubit, ProfilState>(
                            builder: (context, state) {
                              return TextFormField(
                                obscureText: state.password3,
                                style: AppTextStyles.style14.copyWith(
                                  color: myTheme.text,
                                ),
                                decoration: AppTextFormStyle.textFormFild(
                                  errorText: state is ProfilError
                                      ? state.tokenErorrModel.data != null
                                            ? state
                                                      .tokenErorrModel
                                                      .data!
                                                      .passwordConfirmation
                                                      .isNotEmpty
                                                  ? state
                                                        .tokenErorrModel
                                                        .data!
                                                        .passwordConfirmation[0]
                                                  : null
                                            : null
                                      : null,
                                  color: myTheme.unselctedColor,
                                  text: widget.ediAdd
                                      ? "Yangi parolni kiriting"
                                      : "Parolni qayta kiriting",
                                  prefix: Padding(
                                    padding: EdgeInsets.only(
                                      left: 12.w,
                                      right: 8.w,
                                    ),
                                    child: Image.asset(
                                      !widget.ediAdd
                                          ? "assets/img_25.png"
                                          : "assets/img_26.png",
                                      width: 18.w,
                                      color: myTheme.text,
                                    ),
                                  ),
                                  suffix: GestureDetector(
                                    child: Icon(
                                      !state.password3
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      size: 22.w,
                                      color: myTheme.text,
                                    ),
                                    onTap: () =>
                                        context.read<ProfilCubit>().onTap(
                                          state.password1,
                                          state.password2,
                                          !state.password3,
                                        ),
                                  ),
                                ),
                                validator: (value) => AppValidator.password(
                                  name: widget.ediAdd
                                      ? "Yangi parolni tasdiqsh"
                                      : "Parol tasdiqsh",
                                  value: value,
                                  newPassword: passwordController.text,
                                ),
                                onSaved: (saved) {
                                  passwordConfirmation = saved!;
                                },
                              );
                            },
                          ),
                          SizedBox(height: 10.h),
                          Container(
                            padding: .symmetric(
                              vertical: 14.h,
                              horizontal: 14.h,
                            ),
                            decoration: AppTextFormStyle.container(
                              color: myTheme.text.withValues(alpha: 0.09),
                            ),
                            child: Row(
                              mainAxisAlignment: .start,
                              crossAxisAlignment: .start,
                              children: [
                                Image.asset(
                                  "assets/img_14.png",
                                  width: 16.w,
                                  color: myTheme.text,
                                ),
                                SizedBox(width: 5.w),
                                Flexible(
                                  child: Text(
                                    maxLines: 2,
                                    textAlign: .start,
                                    widget.ediAdd
                                        ? "Parol o'zgartirilganda barcha tizimga qaayta kirishga kerak bo'ladi"
                                        : "Ushbu parol filial ma'murlari tizimga kirishi uchun ishlatiladi",
                                    style: AppTextStyles.style12.copyWith(
                                      color: myTheme.text,
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
                      child: BlocConsumer<ProfilCubit, ProfilState>(
                        builder: (context, state) {
                          return ElevatedButton(
                            style: AppTextFormStyle.buttonStyleBorder(
                              background: myTheme.globalColor,
                              foreground: myTheme.textColor,
                            ),
                            onPressed: onTap,
                            child: state is ProfilLoding
                                ? SizedBox(width: 20.w,height: 20.h,
                                  child: Center(
                                      child: CircularProgressIndicator(
                                        color: myTheme.textColor,

                                      ),
                                    ),
                                )
                                : Row(
                                    mainAxisSize: .min,
                                    children: [
                                      Image.asset(
                                        "assets/img_25.png",
                                        width: 15.w,
                                        color: myTheme.textColor,
                                      ),
                                      Text(
                                        widget.ediAdd
                                            ? " O'zgarishlarni saqlash"
                                            : " Filialni ro'yxatdan o'tkazish",
                                        style: AppTextStyles.style14,
                                      ),
                                    ],
                                  ),
                          );
                        },
                        listener: (context, state) {
                          if (state is ProfilFinish) {

                            Navigator.pop(context);
                          }
                        },
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
                          button: true,
                          background: Colors.transparent,
                          foreground: myTheme.text,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Row(
                          mainAxisSize: .min,
                          children: [
                            Text("Bekor qilish", style: AppTextStyles.style14),
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
      },
    );
  }
}
