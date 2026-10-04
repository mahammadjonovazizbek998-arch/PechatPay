import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pechat_pay/logon/login/login_cubit.dart';
import 'package:pechat_pay/logon/profil/profil_cubit.dart';

import '../../../../data/get_it/get_it.dart';
import '../../../../data/style/text_form_style.dart';
import '../../../../data/style/text_style.dart';
import '../../../../data/theme/theme_class.dart';
import 'branch_add_edi.dart';
import 'branch_componets.dart';

class BranchPeges extends StatefulWidget {
  const BranchPeges({super.key});

  @override
  State<BranchPeges> createState() => _BranchPegesState();
}

class _BranchPegesState extends State<BranchPeges> {
  @override
  void initState() {
    sl<ProfilCubit>().filiallPage();
    super.initState();
  }

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
              "Filiallar tarmog'i",
              style: AppTextStyles.style18.copyWith(
                fontWeight: .bold,
                color: myTheme.text,
              ),
            ),
            Text(
              textAlign: .start,
              "PechatPay tizim boshqaruvi",
              style: AppTextStyles.style10.copyWith(
                fontWeight: .w400,
                color: myTheme.text.withValues(alpha: 0.9),
              ),
            ),
          ],
        ),
      ),
      body: BlocBuilder<ProfilCubit, ProfilState>(
        builder: (context, state) {
          if (state is ProfilLoding) {
            return Center(
              child: CircularProgressIndicator(color: myTheme.globalColor),
            );
          } else {
            return BlocBuilder<LoginCubit, LoginState>(
              builder: (context, holat) {
                return CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: .symmetric(horizontal: 16.w, vertical: 16.h),
                      sliver: SliverMainAxisGroup(
                        slivers: [
                          if(holat.token!.role=="owner")
                          SliverToBoxAdapter(
                            child: SizedBox(
                              height: 48.h,
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                style: AppTextFormStyle.buttonStyleBorder(
                                  background: myTheme.globalColor,
                                  foreground: myTheme.textColor,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          BranchAddEdi(ediAdd: false),
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisSize: .min,
                                  children: [
                                    Icon(Icons.add, size: 18.w),
                                    Text(
                                      " Yangi filial qo'shish",
                                      style: AppTextStyles.style14,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          if(holat.token!.role=="owner")
                          SliverToBoxAdapter(child: SizedBox(height: 12.h)),
                          SliverToBoxAdapter(
                            child: Text(
                              "MAVJUD FILIALLAR RO'YXATI",
                              style: AppTextStyles.style12.copyWith(
                                color: myTheme.text.withValues(alpha: 0.9),
                                fontWeight: .w500,
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(child: SizedBox(height: 12.h)),
                          SliverList.separated(
                            itemCount: state.filiallPagel.length,
                            itemBuilder: (context, index) {
                              if (state.filiallPagel[index].id ==
                                  holat.token!.id) {
                                return BranchComponets(
                                  myBranch: true,
                                  isacctiv: true,
                                  tokenModelApiUserModel:
                                      state.filiallPagel[index],
                                );
                              } else {
                                return BranchComponets(
                                  myBranch: true,
                                  tokenModelApiUserModel:
                                      state.filiallPagel[index],
                                );
                              }
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                                  return SizedBox(height: 12.h);
                                },
                          ),
                          SliverToBoxAdapter(child: SizedBox(height: 12.h)),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
