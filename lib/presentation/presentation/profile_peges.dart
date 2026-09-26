import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pechat_pay/data/style/text_form_style.dart';
import 'package:pechat_pay/data/style/text_style.dart';
import 'package:pechat_pay/logon/bottom_navigation_bar/bottom_navigation_bar_cubit.dart';
import '../../data/theme/theme_class.dart';
import '../../logon/login/login_cubit.dart';
import 'componets/profil/branch_componets.dart';

import 'componets/dialog/logout_dialog.dart';
import 'componets/profil/profil_componets.dart';

class ProfilePeges extends StatefulWidget {
  const ProfilePeges({super.key});

  @override
  State<ProfilePeges> createState() => _ProfilePegesState();
}

class _ProfilePegesState extends State<ProfilePeges> {
  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (ctx, state) {
        return BlocBuilder<BottomNavigationBarCubit, BottomNavigationBarState>(
          builder: (context, holat) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: myTheme.globalBackgroundColor,
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/icons/logo_p_p.png",
                      height: 45.h,
                      width: 45.w,
                    ),
                    SizedBox(width: 5.w),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          textAlign: TextAlign.start,
                          "PechatPay",
                          style: AppTextStyles.style18.copyWith(
                            fontWeight: FontWeight.bold,
                            color: myTheme.text,
                          ),
                        ),
                        Text(
                          textAlign: TextAlign.start,
                          "Chilonzor filiali",
                          style: AppTextStyles.style10.copyWith(
                            fontWeight: FontWeight.w400,
                            color: myTheme.text.withValues(alpha: 0.9),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                toolbarHeight: 64.h,
              ),
              body: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 16.h),
                    sliver: SliverMainAxisGroup(
                      slivers: [
                        SliverToBoxAdapter(child: BranchComponets()),
                        SliverToBoxAdapter(child: SizedBox(height: 12.h)),
                        SliverToBoxAdapter(
                          child: Text(
                            "BOSHQARUV VA MONITORING",
                            style: AppTextStyles.style12.copyWith(
                              color: myTheme.text.withValues(alpha: 0.9),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(child: ProfilComponets()),
                        SliverToBoxAdapter(child: SizedBox(height: 12.h)),
                        SliverToBoxAdapter(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            width: 358.w,

                            decoration: AppTextFormStyle.container(shadow: true,
                              color: myTheme.cardColor,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 16.w, right: 16.w),
                              child: SizedBox(
                                height: 48.h,
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton(
                                  style: AppTextFormStyle.buttonStyleBorder(
                                    background: myTheme.logUot.withValues(
                                      alpha: 0.1,
                                    ),
                                    foreground: myTheme.logUot,
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) => LogoutDialog(),
                                    );
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.logout, size: 18.w),
                                      Text(
                                        " Filial tizimidan chiqish",
                                        style: AppTextStyles.style14,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(child: SizedBox(height: 30.h)),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
