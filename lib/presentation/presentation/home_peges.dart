import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/style/text_form_style.dart';
import '../../data/style/text_style.dart';
import '../../data/theme/theme_class.dart';
import '../../logon/tasks/tasks_cubit.dart';
import 'componets/taxis_widget.dart';

class HomePeges extends StatefulWidget {
  const HomePeges({super.key});

  @override
  State<HomePeges> createState() => _HomePegesState();
}

class _HomePegesState extends State<HomePeges> {
  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myTheme.globalBackgroundColor,
        title: Row(
          crossAxisAlignment: .center,
          mainAxisAlignment: .start,
          mainAxisSize: .min,
          children: [
            Image.asset("assets/icons/logo_p_p.png", height: 45.h, width: 45.w),
            SizedBox(width: 5.w),
            Column(
              mainAxisAlignment: .start,
              crossAxisAlignment: .start,
              mainAxisSize: .min,
              children: [
                Text(
                  textAlign: .start,
                  "PechatPay",
                  style: AppTextStyles.style18.copyWith(
                    fontWeight: .bold,
                    color: myTheme.text,
                  ),
                ),
                Text(
                  textAlign: .start,
                  "Chilonzor filiali",
                  style: AppTextStyles.style10.copyWith(
                    fontWeight: .w400,
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
            padding: .symmetric(horizontal: 16.w),
            sliver: SliverMainAxisGroup(
              slivers: [
                SliverToBoxAdapter(
                  child: Form(
                    child: SizedBox(
                      height: 44.h,
                      width: 358.w,
                      child: TextFormField(
                        decoration: AppTextFormStyle.sorchText(
                          color: myTheme.text.withValues(alpha: 0.9),
                          text:
                              "Haydovchi qidirish (ism, tel, davlat raqam)...",
                          icon: Icon(Icons.search, size: 19.w),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 14.h)),
                SliverToBoxAdapter(
                  child: BlocBuilder<TasksCubit, TasksState>(
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: .spaceBetween,
                        children: [
                          Text(
                            "HAYDOVCHILAR RO'YXATI",
                            style: AppTextStyles.style12.copyWith(
                              color: myTheme.text.withValues(alpha: 0.9),
                              fontWeight: .w500,
                            ),
                          ),

                          Container(
                            decoration: AppTextFormStyle.container(
                              color: myTheme.globalColor.withValues(alpha: 0.1),
                            ),
                            padding: .symmetric(vertical: 5.h, horizontal: 6.w),
                            child: Text(
                              "6 ta topildi",
                              style: AppTextStyles.style12.copyWith(
                                color: myTheme.globalColor,
                                fontWeight: .bold,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 10.h)),
                SliverList.separated(
                  itemBuilder: (ctx, index) {
                    return TaxisWidget(key: ValueKey(index),);
                  },
                  itemCount: 12,
                  separatorBuilder: (ctx, index) => SizedBox(height: 12.h,key: ValueKey(index),),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
