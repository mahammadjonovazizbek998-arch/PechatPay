import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pechat_pay/data/style/text_form_style.dart';
import 'package:pechat_pay/logon/tasks/tasks_cubit.dart';
import 'package:pechat_pay/presentation/presentation/componets/filter_button.dart';
import '../../data/style/text_style.dart';
import '../../data/theme/theme_class.dart';
import 'componets/chip_widget.dart';
import 'componets/taxis_widget.dart';

class TasksPeges extends StatefulWidget {
  const TasksPeges({super.key});

  @override
  State<TasksPeges> createState() => _TasksPegesState();
}

class _TasksPegesState extends State<TasksPeges> {
  List<Map<String, String>> chip = [
    {"name": "Barchasi"},
    {"name": "Kam tashrif (7+ kun)"},
    {"name": "Eng faol"},
    {"name": "Yangi kelganlar"},
  ];

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
            padding: .symmetric(horizontal: 14.w),
            sliver: SliverMainAxisGroup(
              slivers: [
                SliverToBoxAdapter(
                  child: Form(
                    child: Row(
                      children: [
                        SizedBox(
                          height: 44.h,
                          width: 260.w,
                          child: TextFormField(
                            decoration: AppTextFormStyle.sorchText(
                              color: myTheme.text.withValues(alpha: 0.9),
                              text: "Ism, telefon yoki avtoraqam...",
                              icon: Icon(Icons.search, size: 19.w),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        SizedBox(
                          height: 44.h,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: AppTextFormStyle.buttonStyleBorder(
                              background: myTheme.globalColor,
                              foreground: myTheme.textColor,
                              padding: true,
                            ).copyWith(),
                            child: Row(
                              mainAxisSize: .min,
                              children: [
                                Icon(Icons.add, size: 14.w),
                                SizedBox(width: 4.w),
                                Text(
                                  "Qo'shish",
                                  style: AppTextStyles.style12.copyWith(
                                    fontWeight: .bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 10.h)),
              ],
            ),
          ),
          SliverPadding(
            padding: .only(left: 16.w),
            sliver: SliverMainAxisGroup(
              slivers: [
                SliverToBoxAdapter(
                  child: BlocBuilder<TasksCubit, TasksState>(
                    builder: (context, state) {
                      return SizedBox(
                        height: 35.h,
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            return SizedBox(
                              child: ChipWidget(
                                name: chip[index]["name"]!,
                                url: chip[index]["url"],
                                isSelected: state.index == index,
                                onTap: () => context.read<TasksCubit>().onTap(
                                  index,
                                  state.value,
                                    state.hidingData,state.rapidOperations,state.selectedIndex
                                ),
                              ),
                            );
                          },
                          scrollDirection: .horizontal,
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(width: 8.w);
                          },
                          itemCount: chip.length,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 10.h)),
          SliverPadding(
            padding: .symmetric(horizontal: 16.w),
            sliver: SliverMainAxisGroup(
              slivers: [
                SliverToBoxAdapter(
                  child: BlocBuilder<TasksCubit, TasksState>(
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: .spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: .min,
                            children: [
                              Text(
                                "HAYDOVCHILAR",
                                style: AppTextStyles.style12.copyWith(
                                  color: myTheme.text.withValues(alpha: 0.9),
                                  fontWeight: .w500,
                                ),
                              ),
                              SizedBox(width: 5.w),
                              Container(
                                decoration: AppTextFormStyle.container(
                                  color: myTheme.globalColor.withValues(
                                    alpha: 0.1,
                                  ),
                                ),
                                padding: .symmetric(
                                  vertical: 5.h,
                                  horizontal: 6.w,
                                ),
                                child: Text(
                                  "6 ta topildi",
                                  style: AppTextStyles.style12.copyWith(
                                    color: myTheme.globalColor,
                                    fontWeight: .bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          FilterButton(
                            onFilterSelected: (value) => context
                                .read<TasksCubit>()
                                .onTap(state.index, value,state.hidingData,state.rapidOperations,state.selectedIndex),
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
