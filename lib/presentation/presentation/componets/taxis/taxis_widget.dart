import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pechat_pay/data/driver_model/history_home_page.dart';
import 'package:pechat_pay/data/repository/auth.dart';
import 'package:pechat_pay/data/style/text_form_style.dart';
import 'package:pechat_pay/data/style/text_style.dart';
import 'package:pechat_pay/presentation/presentation/componets/list_tile.dart';
import '../../../../data/driver_model/driver_noactive_model.dart';
import '../../../../data/theme/theme_class.dart';

import '../../../../logon/home/homle_cubit.dart';
import '../dialog/stamp_dialog.dart';
import 'issuing_a_seal_peges.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaxisWidget extends StatefulWidget {
  final bool phone;
  final DriverNoactiveModel? driverNoactiveModel;
  final Driver? driver;

  const TaxisWidget({
    super.key,
    this.phone = false,
    this.driverNoactiveModel,
    this.driver,
  });

  @override
  State<TaxisWidget> createState() => _TaxisWidgetState();
}

class _TaxisWidgetState extends State<TaxisWidget> {
  bool _isRequesting = false; // Local so'rov holati

  @override
  void initState() {
    indexColorInst();
    super.initState();
  }

  AuthRepository authRepository = AuthRepository();
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
      decoration: AppTextFormStyle.container(
        color: myTheme.cardColor,
        shadow: true,
      ),

      child: Column(
        mainAxisSize: .min,
        children: [
          ListTileWidget(
            selected: Text(
              maxLines: 1,
              overflow: .clip,
              widget.driver != null && widget.driverNoactiveModel == null
                  ? widget.driver!.name
                  : widget.driverNoactiveModel!.name,
              style: AppTextStyles.style16.copyWith(
                color: myTheme.text,
                fontWeight: .w900,
              ),
            ),
            unselected: Text(
              AuthRepository.formatUzbekPhone(
                widget.driver != null && widget.driverNoactiveModel == null
                    ? widget.driver!.phone
                    : widget.driverNoactiveModel!.phone,
              ),
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
                widget.driver != null && widget.driverNoactiveModel == null
                    ? widget.driver!.name.split(" ").length > 1
                          ? "${widget.driver!.name.split(" ")[0].substring(0, 1)}${widget.driver!.name.split(" ")[1].substring(0, 1)}"
                          : widget.driver!.name
                                .split(" ")[0]
                                .substring(0, 2)
                                .toUpperCase()
                    : widget.driverNoactiveModel!.name.split(" ").length > 1
                    ? "${widget.driverNoactiveModel!.name.split(" ")[0].substring(0, 1)}${widget.driverNoactiveModel!.name.split(" ")[1].substring(0, 1)}"
                    : widget.driverNoactiveModel!.name
                          .split(" ")[0]
                          .substring(0, 2)
                          .toUpperCase(),
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
                  padding: .symmetric(vertical: 5.h, horizontal: 10.w),
                  child: Row(
                    mainAxisSize: .min,
                    children: [
                      Image.asset(
                        widget.driverNoactiveModel != null
                            ? "assets/rubber-stamp.png"
                            : widget.driver!.action == "pechat"
                            ? "assets/rubber-stamp.png"
                            : widget.driver!.action == "naqtlashtirish1"
                            ? "assets/money.png"
                            : "assets/add.png",
                        color: myTheme.globalColor,
                        width: 17.w,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        widget.driverNoactiveModel != null
                            ? " ${widget.driverNoactiveModel!.unpaidPechatsCount} muhr"
                            : widget.driver!.action == "naqtlashtirish1"
                            ? " naqd"
                            : " ${widget.driver!.action}",
                        style: AppTextStyles.style12.copyWith(
                          color: myTheme.globalColor,
                          fontWeight: .bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.h),

                widget.driverNoactiveModel != null
                    ? Text(
                        "${AuthRepository.formatSum(widget.driverNoactiveModel!.unpaidPechatsSum.toString())} so'm",
                        style: AppTextStyles.style12.copyWith(
                          color: myTheme.text.withValues(alpha: 0.9),
                        ),
                      )
                    : widget.driver!.actionData != null
                    ? Text(
                        "${AuthRepository.formatSum(widget.driver!.actionData!.summa.toString())} so'm",
                        style: AppTextStyles.style12.copyWith(
                          color: myTheme.text.withValues(alpha: 0.9),
                        ),
                      )
                    : SizedBox(),
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
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 16.w,
                      color: myTheme.text,
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      widget.driver != null &&
                              widget.driverNoactiveModel == null
                          ? widget.driver!.updatedAt.substring(0, 10)
                          : widget.driverNoactiveModel!.updatedAt.substring(
                              0,
                              10,
                            ),
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
                          widget.driver != null &&
                                  widget.driverNoactiveModel == null
                              ? widget.driver!.carNumber.substring(0, 2)
                              : widget.driverNoactiveModel!.carNumber.substring(
                                  0,
                                  2,
                                ),
                          style: AppTextStyles.style12.copyWith(
                            color: myTheme.text,
                            fontWeight: .bold,
                          ),
                        ),
                      ),
                      Text(
                        AuthRepository.formatUzbekCarNumber(
                          widget.driver != null &&
                                  widget.driverNoactiveModel == null
                              ? widget.driver!.carNumber
                              : widget.driverNoactiveModel!.carNumber,
                        ),
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
                    child: BlocConsumer<HomleCubit, HomleState>(
                      listener: (context, state) {
                        if (_isRequesting && state is HomleFinish &&
                            state.pechatCreateResponse != null) {
                          
                          final currentCar = widget.driver != null && widget.driverNoactiveModel == null
                              ? widget.driver!.carNumber
                              : widget.driverNoactiveModel!.carNumber;

                          if (state.pechatCreateResponse!.data?.carNumber.replaceAll(' ', '').toUpperCase() == 
                              currentCar.replaceAll(' ', '').toUpperCase()) {
                            
                            setState(() => _isRequesting = false);
                            
                            showDialog(
                              context: context,
                              builder: (dialogCtx) => StampDialog(response: state.pechatCreateResponse!),
                              barrierDismissible: false,
                            ).then((_) {
                              if (mounted) {
                                // ignore: use_build_context_synchronously
                                context.read<HomleCubit>().historyHomePage(1);
                                // ignore: use_build_context_synchronously
                                context.read<HomleCubit>().resetPechatResponse();
                              }
                            });
                          }
                        } else if (_isRequesting && state is HomeError) {
                          setState(() => _isRequesting = false);
                        }
                      },
                      builder: (context, state) {
                        return ElevatedButton(
                          style: AppTextFormStyle.buttonStyleBorder(
                            button: true,
                            background: myTheme.container,
                            foreground: myTheme.globalColor,
                          ),
                          onPressed: (state is HomeLoding && _isRequesting) ? null : () {
                            if (widget.phone) {
                                authRepository.callNumber(
                                    widget.driver != null &&
                                            widget.driverNoactiveModel == null
                                        ? widget.driver!.phone
                                        : widget.driverNoactiveModel!.phone,
                                  );
                            } else {
                                setState(() {
                                  _isRequesting = true;
                                });
                                context.read<HomleCubit>().pechat(
                                    widget.driver != null &&
                                            widget.driverNoactiveModel == null
                                        ? widget.driver!.id
                                        : widget.driverNoactiveModel!.id,
                                    "nasiya",
                                  );
                            }
                          },
                          child: (state is HomeLoding && _isRequesting) 
                            ? SizedBox(
                                width: 18.w,
                                height: 18.w,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: myTheme.globalColor,
                                ),
                              )
                            : Row(
                            mainAxisSize: .min,
                            children: [
                              Image.asset(
                                widget.phone
                                    ? "assets/img_23.png"
                                    : "assets/img_22.png",
                                width: 17.w,
                                color: myTheme.globalColor,
                              ),
                              Text(
                                widget.phone ? " Bog‘lanish" : " Muhr berish",
                                style: AppTextStyles.style14,
                              ),
                            ],
                          ),
                        );
                      },
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
                        // Cubitni saqlab qolamiz (Async gap bo'lgani uchun)
                        final homleCubit = context.read<HomleCubit>();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => IssuingASealPeges(
                              color: profileColors[colorIndex],
                              id: widget.driverNoactiveModel != null
                                  ? widget.driverNoactiveModel!.id
                                  : widget.driver!.id,
                            ),
                          ),
                        ).then((_) {
                          // Profil sahifasi yopilganda Home ma'lumotlarini yangilaymiz
                          homleCubit.historyHomePage(1);
                        });
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
