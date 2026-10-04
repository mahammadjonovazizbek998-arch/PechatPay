import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pechat_pay/data/style/text_style.dart';

import '../../../../data/style/text_form_style.dart';
import '../../../../data/theme/theme_class.dart';
import '../../../../logon/bottom_navigation_bar/bottom_navigation_bar_cubit.dart';
import '../../../../logon/login/login_cubit.dart';
import 'branch_peges.dart';
import 'help_and_contact.dart';
import '../list_tile.dart';
import 'no_active_driver.dart';

class ProfilComponets extends StatefulWidget {
  const ProfilComponets({super.key});

  @override
  State<ProfilComponets> createState() => _ProfilComponetsState();
}

class _ProfilComponetsState extends State<ProfilComponets> {
  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (ctx, state) {
        return BlocBuilder<BottomNavigationBarCubit, BottomNavigationBarState>(
          builder: (context, holat) {
            return DecoratedBox(
              decoration:AppTextFormStyle.container( color: myTheme.cardColor,shadow: true),
              child: Column(
                children: [
                  ListTileWidget(
                    color: myTheme.unselctedColor,
                    onTap: () {
                      context.read<BottomNavigationBarCubit>().onTap(
                        holat.currentIndex,
                        AppProfilPeges.myAccount,
                      );
                    },

                    selected: Text(
                      textAlign: .start,
                      "Umumiy statistika",
                      style: AppTextStyles.style14.copyWith(
                        fontWeight: .bold,
                        color: myTheme.text,
                      ),
                    ),
                    unselected: Text(
                      textAlign: .start,
                      "Muhrlar aylanmasi, kassa hisoboti",
                      style: AppTextStyles.style13.copyWith(
                        fontWeight: .w500,
                        color: myTheme.text.withValues(alpha: 0.8),
                      ),
                    ),
                    leading: ContainerWidget(
                      vertical: 46.h,
                      horizontal: 44.w,
                      assets: "assets/img.png",
                      assetsHorizontal: 16.75,
                      assetsVertical: 17.5,
                      assetsColor: myTheme.globalColor,
                      boxDecoration: AppTextFormStyle.container(
                        color: myTheme.unselctedCardColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Divider(
                      color: myTheme.unselctedColor.withValues(alpha: 0.3),
                      height: 0.3.h,
                    ),
                  ),
                  ListTileWidget(
                    color: myTheme.unselctedColor,
                    onTap: () {

                    Navigator.push(context, MaterialPageRoute(builder: (_)=>BranchPeges()));
                    },

                    selected: Text(
                      textAlign: .start,
                      "Filiallar tarmog'i",
                      style: AppTextStyles.style14.copyWith(
                        fontWeight: .bold,
                        color: myTheme.text,
                      ),
                    ),
                    unselected: Text(
                      textAlign: .start,
                      "Filiallar va boshqaruv",
                      style: AppTextStyles.style13.copyWith(
                        fontWeight: .w500,
                        color: myTheme.text.withValues(alpha: 0.8),
                      ),
                    ),
                    leading: ContainerWidget(
                      vertical: 46.h,
                      horizontal: 44.w,
                      assets: "assets/img_1.png",
                      assetsHorizontal: 16.75,
                      assetsVertical: 17.5,
                      assetsColor: myTheme.globalColor,
                      boxDecoration: AppTextFormStyle.container(
                        color: myTheme.unselctedCardColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Divider(
                      color: myTheme.unselctedColor.withValues(alpha: 0.3),
                      height: 0.3.h,
                    ),
                  ),
                  ListTileWidget(
                    color: myTheme.unselctedColor,
                    onTap: () {
                     Navigator.push(context, MaterialPageRoute(builder: (_)=>NoActiveDriver()));
                    },

                    selected: Text(
                      textAlign: .start,
                      "Nofaol haydovchilar (7+ kun)",
                      style: AppTextStyles.style14.copyWith(
                        fontWeight: .bold,
                        color: myTheme.text,
                      ),
                    ),
                    unselected: Text(
                      maxLines: 1,
                      overflow: .ellipsis,
                      textAlign: .start,
                      "Uzoq mudat tashrif buyurmagan haydochilar",
                      style: AppTextStyles.style13.copyWith(
                        fontWeight: .w500,
                        color: myTheme.text.withValues(alpha: 0.8),
                      ),
                    ),
                    leading: ContainerWidget(
                      vertical: 46.h,
                      horizontal: 44.w,
                      assets: "assets/img_2.png",
                      assetsHorizontal: 16.75,
                      assetsVertical: 17.5,
                      assetsColor: myTheme.globalColor,
                      boxDecoration: AppTextFormStyle.container(
                        color: myTheme.unselctedCardColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Divider(
                      color: myTheme.unselctedColor.withValues(alpha: 0.3),
                      height: 0.3.h,
                    ),
                  ),
                  ListTileWidget(
                    color: myTheme.unselctedColor,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => HelpAndContact()),
                      );
                    },

                    selected: Text(
                      textAlign: .start,
                      "Yordam va aloqa",
                      style: AppTextStyles.style14.copyWith(
                        fontWeight: .bold,
                        color: myTheme.text,
                      ),
                    ),
                    unselected: Text(
                      textAlign: .start,
                      "Markaziy dispetcher (24/7 aloqa)",
                      style: AppTextStyles.style13.copyWith(
                        fontWeight: .w500,
                        color: myTheme.text.withValues(alpha: 0.8),
                      ),
                    ),
                    leading: ContainerWidget(
                      vertical: 46.h,
                      horizontal: 44.w,
                      assets: "assets/img_3.png",
                      assetsHorizontal: 16.75,
                      assetsVertical: 17.5,
                      assetsColor: myTheme.globalColor,
                      boxDecoration: AppTextFormStyle.container(
                        color: myTheme.unselctedCardColor,
                      ),
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
