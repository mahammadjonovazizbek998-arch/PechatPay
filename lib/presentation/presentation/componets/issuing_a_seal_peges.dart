import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pechat_pay/logon/tasks/tasks_cubit.dart';
import 'package:pechat_pay/presentation/presentation/componets/repid_operations.dart';

import '../../../data/style/text_form_style.dart';
import '../../../data/style/text_style.dart';
import '../../../data/theme/theme_class.dart';
import 'cash.dart';
import 'history_of_operations.dart';
import 'list_tile.dart';

class IssuingASealPeges extends StatefulWidget {
  final Color color;

  const IssuingASealPeges({super.key, required this.color});

  @override
  State<IssuingASealPeges> createState() => _IssuingASealPegesState();
}

class _IssuingASealPegesState extends State<IssuingASealPeges> {
  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          textAlign: .start,
          "Haydovchi Profili",
          style: AppTextStyles.style18.copyWith(
            fontWeight: .bold,
            color: myTheme.text,
          ),
        ),
      ),
      body: BlocBuilder<TasksCubit, TasksState>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: .symmetric(horizontal: 16.w),
                sliver: SliverMainAxisGroup(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Container(
                        margin: .symmetric(vertical: 14.h),
                        decoration: AppTextFormStyle.container(
                          color: myTheme.cardColor,
                        ),

                        child: Column(
                          mainAxisSize: .min,
                          children: [
                            ListTileWidget(
                              selected: Text(
                                "Jasur Olimov",
                                style: AppTextStyles.style16.copyWith(
                                  color: myTheme.text,
                                  fontWeight: .w900,
                                ),
                              ),
                              unselected: Text(
                                "+998 97 845 12 34",
                                style: AppTextStyles.style12.copyWith(
                                  color: myTheme.text.withValues(alpha: 0.9),
                                ),
                              ),

                              leading: ContainerWidget(
                                vertical: 74.h,
                                horizontal: 60.w,
                                text: Text(
                                  "SR",
                                  style: AppTextStyles.style14.copyWith(
                                    fontWeight: .bold,
                                    color: myTheme.textColor,
                                  ),
                                ),
                                boxDecoration:
                                    AppTextFormStyle.container(
                                      color: widget.color,
                                    ).copyWith(
                                      border: BoxBorder.all(
                                        width: 0.5.w,
                                        color: widget.color,
                                      ),
                                      borderRadius: .circular(40.r),
                                    ),
                              ),
                              trailing: ContainerWidget(
                                vertical: 47.h,
                                horizontal: 44.w,
                                assets: "assets/img_23.png",
                                assetsHorizontal: 17.w,
                                assetsVertical: 17.h,
                                assetsColor: myTheme.globalColor,
                                boxDecoration:
                                    AppTextFormStyle.container(
                                      color: myTheme.unselctedCardColor
                                          .withValues(alpha: 0.5),
                                    ).copyWith(
                                      border: BoxBorder.all(
                                        width: 0.5.w,
                                        color: myTheme.unselctedColor,
                                      ),
                                      borderRadius: .circular(25.r),
                                    ),
                              ),
                            ),
                            Container(
                              padding: .symmetric(
                                vertical: 10.h,
                                horizontal: 14.w,
                              ),
                              margin: .symmetric(
                                horizontal: 16.w,
                                vertical: 6.h,
                              ),
                              decoration: AppTextFormStyle.container(
                                color: myTheme.unselctedCardColor.withValues(
                                  alpha: 0.7,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: .spaceBetween,
                                crossAxisAlignment: .center,
                                children: [
                                  Row(
                                    mainAxisSize: .min,
                                    children: [
                                      Icon(
                                        Icons.calendar_today_outlined,
                                        size: 16.w,
                                        color: myTheme.text,
                                      ),
                                      SizedBox(width: 6.w),
                                      Text(
                                        "Ro'yxatdan o'tgan:\n12.03.2024",
                                        style: AppTextStyles.style13.copyWith(
                                          color: myTheme.text,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 28.h,
                                    width: 122.w,
                                    decoration: BoxDecoration(
                                      borderRadius: .circular(8.r),
                                      border: .all(
                                        width: 2.w,
                                        color: myTheme.text,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: .spaceBetween,
                                      children: [
                                        Container(
                                          alignment: .center,
                                          height: 28.h,
                                          width: 30.w,
                                          decoration: BoxDecoration(
                                            color: myTheme.unselctedColor
                                                .withValues(alpha: 0.3),
                                            border: .fromLTRB(
                                              right: BorderSide(
                                                color: myTheme.unselctedColor,
                                              ),
                                            ),
                                          ),
                                          child: Text(
                                            "01",
                                            style: AppTextStyles.style12
                                                .copyWith(
                                                  color: myTheme.text,
                                                  fontWeight: .bold,
                                                ),
                                          ),
                                        ),
                                        Text(
                                          "A777AA",
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
                            SizedBox(height: 6.h),
                            Padding(
                              padding: .symmetric(horizontal: 16.w),
                              child: SizedBox(
                                height: 38.h,
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton(
                                  style: AppTextFormStyle.buttonStyleBorder(
                                    background: myTheme.unselctedCardColor,
                                    foreground: myTheme.text,
                                  ),
                                  onPressed: () {},
                                  child: Row(
                                    mainAxisSize: .min,
                                    children: [
                                      Icon(Icons.edit_outlined, size: 18.w),
                                      Text(
                                        " Haydovchini tahrirlash",
                                        style: AppTextStyles.style14,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 12.h),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        padding: .symmetric(vertical: 16.h, horizontal: 16.w),
                        decoration: AppTextFormStyle.container(
                          color: myTheme.cardColor,
                        ),

                        child: Column(
                          mainAxisSize: .min,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              mainAxisAlignment: .spaceBetween,
                              children: [
                                Text(
                                  "QOLGAN MUHRLAR",
                                  style: AppTextStyles.style12.copyWith(
                                    color: myTheme.text.withValues(alpha: 0.9),
                                    fontWeight: .w500,
                                  ),
                                ),
                                Text(
                                  "UMUMIY QIYMAT",
                                  style: AppTextStyles.style12.copyWith(
                                    color: myTheme.text.withValues(alpha: 0.9),
                                    fontWeight: .w500,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: .end,
                              mainAxisAlignment: .spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(
                                      "4",
                                      style: AppTextStyles.style22.copyWith(
                                        color: myTheme.text,
                                      ),
                                    ),
                                    Text(
                                      " ta",
                                      style: AppTextStyles.style16.copyWith(
                                        color: myTheme.text,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(
                                      "200000",
                                      style: AppTextStyles.style22.copyWith(
                                        color: myTheme.globalColor,
                                      ),
                                    ),
                                    Text(
                                      " ta",
                                      style: AppTextStyles.style16.copyWith(
                                        color: myTheme.globalColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              padding: .symmetric(
                                vertical: 10.h,
                                horizontal: 14.w,
                              ),
                              margin: .symmetric(vertical: 10.h),
                              decoration: AppTextFormStyle.container(
                                color: myTheme.unselctedCardColor.withValues(
                                  alpha: 0.7,
                                ),
                              ),
                              child: IntrinsicHeight(
                                child: Row(
                                  mainAxisAlignment: .spaceAround,
                                  crossAxisAlignment: .center,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: .center,
                                        mainAxisAlignment: .center,
                                        children: [
                                          Text(
                                            "Jami berilgan",
                                            style: AppTextStyles.style12
                                                .copyWith(
                                                  color: myTheme.text
                                                      .withValues(alpha: 0.9),
                                                  fontWeight: .w500,
                                                ),
                                          ),
                                          Text(
                                            "12 ta",
                                            style: AppTextStyles.style16
                                                .copyWith(color: myTheme.text),
                                          ),
                                        ],
                                      ),
                                    ),
                                    VerticalDivider(
                                      color: myTheme.text.withValues(
                                        alpha: 0.2,
                                      ),
                                      width: 1.w,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: .center,
                                        mainAxisAlignment: .center,
                                        children: [
                                          Text(
                                            "Naqdlashtirilgan",
                                            style: AppTextStyles.style12
                                                .copyWith(
                                                  color: myTheme.text
                                                      .withValues(alpha: 0.9),
                                                  fontWeight: .w500,
                                                ),
                                          ),
                                          Text(
                                            "8 ta",
                                            style: AppTextStyles.style16
                                                .copyWith(color: myTheme.text),
                                          ),
                                        ],
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
                    SliverToBoxAdapter(
                      child: BlocBuilder<TasksCubit, TasksState>(
                        builder: (context, state) {
                          return Container(
                            padding: .symmetric(
                              vertical: 16.h,
                              horizontal: 16.w,
                            ),
                            margin: .symmetric(vertical: 14.h),
                            decoration: AppTextFormStyle.container(
                              color: myTheme.cardColor,
                            ),

                            child: Column(
                              mainAxisSize: .min,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: .spaceBetween,
                                  children: [
                                    Text(
                                      "Tezkor operatsiyalar",
                                      style: AppTextStyles.style16.copyWith(
                                        color: myTheme.text,
                                      ),
                                    ),

                                    Container(
                                      decoration: AppTextFormStyle.container(
                                        color: myTheme.globalColor.withValues(
                                          alpha: 0.1,
                                        ),
                                      ),
                                      padding: .symmetric(
                                        vertical: 7.h,
                                        horizontal: 6.w,
                                      ),
                                      child: Text(
                                        "Chilonzor filiali",
                                        style: AppTextStyles.style12.copyWith(
                                          color: myTheme.globalColor,
                                          fontWeight: .bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: .symmetric(
                                    vertical: 3.h,
                                    horizontal: 3.w,
                                  ),
                                  margin: .symmetric(vertical: 10.h),
                                  decoration: AppTextFormStyle.container(
                                    color: myTheme.unselctedCardColor
                                        .withValues(alpha: 0.7),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          height: 48.h,
                                          child: ElevatedButton(
                                            style:
                                                AppTextFormStyle.buttonStyleBorder(
                                                  button: true,
                                                  padding: true,
                                                  background:
                                                      state.rapidOperations
                                                      ? myTheme
                                                            .unselctedCardColor
                                                            .withValues(
                                                              alpha: 0.6,
                                                            )
                                                      : myTheme.globalColor
                                                            .withValues(
                                                              alpha: 0.1,
                                                            ),
                                                  foreground:
                                                      state.rapidOperations
                                                      ? myTheme.text
                                                      : myTheme.globalColor,
                                                ),
                                            onPressed: () {
                                              context.read<TasksCubit>().onTap(
                                                state.index,
                                                state.value,
                                                state.hidingData,
                                                false,
                                                state.selectedIndex,
                                              );
                                            },
                                            child: Row(
                                              mainAxisSize: .min,
                                              children: [
                                                Icon(Icons.add, size: 18.w),
                                                Text(
                                                  " Muhr berish",
                                                  style: AppTextStyles.style14,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          height: 48.h,
                                          child: ElevatedButton(
                                            style:
                                                AppTextFormStyle.buttonStyleBorder(
                                                  button: true,
                                                  padding: true,
                                                  background:
                                                      !state.rapidOperations
                                                      ? myTheme
                                                            .unselctedCardColor
                                                            .withValues(
                                                              alpha: 0.6,
                                                            )
                                                      : myTheme.globalColor
                                                            .withValues(
                                                              alpha: 0.1,
                                                            ),
                                                  foreground:
                                                      !state.rapidOperations
                                                      ? myTheme.text
                                                      : myTheme.globalColor,
                                                ),
                                            onPressed: () {
                                              context.read<TasksCubit>().onTap(
                                                state.index,
                                                state.value,
                                                state.hidingData,
                                                true,
                                                state.selectedIndex,
                                              );
                                            },
                                            child: Row(
                                              mainAxisSize: .min,
                                              children: [
                                                Image.asset(
                                                  "assets/img_24.png",
                                                  width: 16.w,
                                                  color: !state.rapidOperations
                                                      ? myTheme.text
                                                      : myTheme.globalColor,
                                                ),

                                                Text(
                                                  " Naqdlashtirish",
                                                  style: AppTextStyles.style14,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                state.rapidOperations
                                    ? Cash()
                                    : Repidoperations(),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Row(
                        mainAxisAlignment: .spaceBetween,
                        children: [
                          Text(
                            "Operatsiyalar tarixi",
                            style: AppTextStyles.style16.copyWith(
                              fontWeight: .bold,
                              color: myTheme.text,
                            ),
                          ),
                          Text(
                            "OXIRGI HARAKATLAR",
                            style: AppTextStyles.style10.copyWith(
                              color: myTheme.text,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SliverList.builder(
                      itemCount: 12,
                      itemBuilder: (context, index) {
                        if(state.selectedIndex==index){
                         return HistoryOfOperations();
                        }else{
                        return Container(
                          padding: .symmetric(vertical: 3.h, horizontal: 3.w),
                          margin: .symmetric(vertical: 10.h),
                          decoration: AppTextFormStyle.container(
                            color: myTheme.textColor,
                          ),
                          child: ListTileWidget(icoBool: true,
                            onTap: () => context.read<TasksCubit>().onTap(
                              state.index,
                              state.value,
                              state.hidingData,
                              state.rapidOperations,
                              index,
                            ),
                            color: myTheme.unselctedColor,
                            trailing: Column(
                              crossAxisAlignment: .end,
                              mainAxisAlignment: .start,
                              children: [
                                Text(
                                  "1 ta muhr",
                                  style: AppTextStyles.style14.copyWith(
                                    color: myTheme.phonColor,
                                    fontWeight: .bold,
                                  ),
                                ),
                                Text(
                                  "50000",
                                  style: AppTextStyles.style14.copyWith(
                                    color: myTheme.text,
                                  ),
                                ),
                              ],
                            ),
                            selected: Text(
                              textAlign: .start,
                              "Muhr berildi",
                              style: AppTextStyles.style14.copyWith(
                                fontWeight: .bold,
                                color: myTheme.text,
                              ),
                            ),
                            unselected: Text(
                              textAlign: .start,
                              "Kecha, 17:30 • Chilonzor (Kunduzgi)",
                              style: AppTextStyles.style13.copyWith(
                                fontWeight: .w500,
                                color: myTheme.text.withValues(alpha: 0.8),
                              ),
                            ),
                            leading: ContainerWidget(
                              vertical: 46.h,
                              horizontal: 44.w,
                              assets: "assets/img_25.png",
                              assetsHorizontal: 16.75,
                              assetsVertical: 17.5,
                              assetsColor: myTheme.phonColor,
                              boxDecoration: AppTextFormStyle.container(
                                color: myTheme.phonColor.withValues(alpha: 0.1),
                              ),
                            ),
                          ),
                        );}
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
