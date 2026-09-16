import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pechat_pay/data/style/text_style.dart';

import '../../data/theme/theme_class.dart';
import '../../logon/login/login_cubit.dart';
import 'componets/list_tile.dart';

class ProfilePeges extends StatefulWidget {
  const ProfilePeges({super.key});

  @override
  State<ProfilePeges> createState() => _ProfilePegesState();
}

class _ProfilePegesState extends State<ProfilePeges> {
  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;

    return Scaffold(
      body: BlocBuilder<LoginCubit, LoginState>(
        builder: (ctx, state) {
          return SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: .symmetric(horizontal: 15.h),
                  sliver: SliverMainAxisGroup(
                    slivers: [
                      SliverToBoxAdapter(child: SizedBox(height: 40.h)),
                      SliverToBoxAdapter(
                        child: Image.asset(
                          "assets/man.png",
                          height: 108.h,
                          width: 108.w,
                        ),
                      ),
                      SliverToBoxAdapter(child: SizedBox(height: 15.h)),
                      SliverToBoxAdapter(
                        child: Row(
                          mainAxisAlignment: .center,
                          children: [
                            Text(
                              "Pechat Pay Demo 1",
                              style: AppTextStyles.style24.copyWith(
                                fontWeight: .bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SliverToBoxAdapter(child: SizedBox(height: 25.h)),
                      SliverToBoxAdapter(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: .circular(15.r),
                            color: myTheme.cardColor,
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 6.h),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 6.h),
                                child: ListTileWidget(
                                  onTap: () {},
                                  backgroundColor: const Color(0xFFFFFFFF),
                                  icon: Icon(
                                    Icons.perm_identity,
                                    weight: 30.w,
                                    color: Colors.white,
                                  ),
                                  selected: "Mening hisobim",
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 6.h),
                                child: ListTileWidget(
                                  onTap: () {},
                                  backgroundColor: const Color(0xFFDAD9E3),

                                  selected: "Filiallar",assets:"assets/branch.png",
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 6.h),
                                child: ListTileWidget(
                                  onTap: () {},
                                  backgroundColor: const Color(0xFFDAD9E3),
                                  assets: "assets/economy.png",
                                  selected: "Faoliyat statistikasi",
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 6.h),
                                child: ListTileWidget(
                                  onTap: () {},
                                  backgroundColor: const Color(0xFFDAD9E3),
                                  icon: Icon(
                                    Icons.edit_outlined,
                                    weight: 28.w,
                                    color: Colors.white,
                                  ),
                                  selected: "Faol bo'lmagan haydovchilar",
                                ),
                              ),
                              SizedBox(height: 3.h),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 6.h),
                                child: ListTileWidget(
                                  onTap: () {},
                                  backgroundColor:  Colors.red,
                                  icon: Icon(
                                    Icons.logout,
                                  weight: 28.w,
                                    color: Colors.red,
                                  ),
                                  selected: "Tizimdan chiqish",
                                ),
                              ),
                              SizedBox(height: 6.h),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

//Padding(
//             padding: .only(left: 10.w, right: 10.w),
//             child: Column(
//               children: [
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width,
//                   height: 100.w,
//                 ),
//                 CircleAvatar(
//                   backgroundColor: myTheme.globalColor,
//                   foregroundColor: myTheme.textColor,
//                   radius: 60.r,
//                   child: Row(
//                     mainAxisAlignment: .center,
//                     children: [
//                       Text(
//                         state.token!.name
//                             .toString()
//                             .split(" ")[0]
//                             .substring(0, 1),
//                         style: AppTextStyles.style20.copyWith(
//                           fontWeight: .w600,
//                         ),
//                       ),
//                       if (state.token!.name.toString().split(" ").length >= 2)
//                         Text(
//                           state.token!.name
//                               .toString()
//                               .split(" ")[1]
//                               .substring(0, 1),
//                           style: AppTextStyles.style20.copyWith(
//                             fontWeight: .w600,
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 10.h),
//                 Row(
//                   mainAxisAlignment: .center,
//                   children: [
//                     Text(state.token!.name, style: AppTextStyles.style20),
//                   ],
//                 ),
//
//                 SizedBox(height: 30.h),
//                 DecoratedBox(
//                   decoration: BoxDecoration(
//                     color: myTheme.cardColor,
//                     borderRadius: .circular(15.r),
//                   ),
//                   child: SizedBox(
//                     width: MediaQuery.of(context).size.width,
//                     child: Column(
//                       children: [
//                         ListTile(
//                           title: Text(
//                             "Foydalnuchi nomi",
//                             style: AppTextStyles.style16,
//                           ),
//                           subtitle: Text(
//                             state.token!.name,
//                             style: AppTextStyles.style13,
//                           ),
//                           leading: Icon(Icons.person, size: 24.w),
//                         ),
//                         ListTile(
//                           title: Text(
//                             "Telfon raqami",
//                             style: AppTextStyles.style16,
//                           ),
//                           subtitle: Text(
//                             state.token!.phone,
//                             style: AppTextStyles.style13,
//                           ),
//                           leading: Icon(Icons.person, size: 24.w),
//                         ),
//                         ListTile(
//                           title: Text(
//                             "Tizmdan chiqshi",
//                             style: AppTextStyles.style16,
//                           ),
//                           subtitle: Text(
//                             state.token!.phone,
//                             style: AppTextStyles.style13,
//                           ),
//                           leading: Icon(Icons.person, size: 24.w),
//                         ),
//                         ListTile(
//                           title: Text(
//                             "Profil malumtlarni taxtilsh",
//                             style: AppTextStyles.style16,
//                           ),
//                           subtitle: Text(
//                             state.token!.phone,
//                             style: AppTextStyles.style13,
//                           ),
//                           leading: Icon(Icons.person, size: 24.w),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//
//
//               ],
//             ),
//           );
