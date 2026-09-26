import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pechat_pay/logon/login/login_cubit.dart';

import '../../../data/style/text_style.dart';
import '../../../data/theme/theme_class.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return AppBar(
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
                    "PechatPay",
                    style: AppTextStyles.style18.copyWith(
                      fontWeight: FontWeight.bold,
                      color: myTheme.text,
                    ),
                  ),
                  if (state.token != null && state.token!.name.isNotEmpty)
                    Text(
                      state.token!.name,
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
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(64.h);
}
