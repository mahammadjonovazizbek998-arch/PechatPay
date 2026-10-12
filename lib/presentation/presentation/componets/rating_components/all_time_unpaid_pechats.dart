import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pechat_pay/data/style/text_form_style.dart';
import 'package:pechat_pay/data/style/text_style.dart';
import 'package:pechat_pay/data/theme/theme_class.dart';
import 'package:pechat_pay/logon/dashboard/dashboard_cubit.dart';
import 'package:pechat_pay/logon/dashboard/dashboard_state.dart';

import '../list_tile.dart';

class AllTimeUnpaidPechats extends StatelessWidget {
  const AllTimeUnpaidPechats({super.key});

  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        final unpaid = state.statsResponse?.data.allTimeUnpaidPechats;
        final count = unpaid?.count ?? 0;
        final summa = unpaid?.summa ?? 0;

        return Container(
          decoration: AppTextFormStyle.container(
            color: myTheme.textColor,
            shadow: true,
            borderColor: myTheme.text.withValues(alpha: 0.5),
          ),

          child: ListTileWidget2(
            leading: ContainerWidget(
              vertical: 46.h,
              horizontal: 44.w,
              assets: "assets/img_40.png",
              assetsHorizontal: 16.75,
              assetsVertical: 17.5,
              assetsColor: myTheme.phonColor,
              boxDecoration: AppTextFormStyle.container(
                color: myTheme.unselctedCardColor,
              ),
            ),
            title: Text(
              "Barcha to'lanmagan muhrlar qarzdorligi",
              style: AppTextStyles.style12.copyWith(color: myTheme.text),
            ),
            subtitle: Row(
              children: [
                Row(
                  children: [
                    Text(
                      "$count ta muhr",
                      style: AppTextStyles.style18.copyWith(
                        color: myTheme.text,
                        fontWeight: .bold,
                      ),
                    ),
                    Text(
                      "($summa so'm)",
                      style: AppTextStyles.style12.copyWith(
                        color: myTheme.globalColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
