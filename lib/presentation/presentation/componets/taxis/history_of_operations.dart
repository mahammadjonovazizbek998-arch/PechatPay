import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pechat_pay/logon/tasks/tasks_cubit.dart';

import '../../../../data/repository/auth.dart';
import '../../../../data/style/text_form_style.dart';
import '../../../../data/style/text_style.dart';
import '../../../../data/theme/theme_class.dart';
import '../list_tile.dart';

class HistoryOfOperations extends StatefulWidget {
  const HistoryOfOperations({super.key});

  @override
  State<HistoryOfOperations> createState() => _HistoryOfOperationsState();
}

class _HistoryOfOperationsState extends State<HistoryOfOperations> {
  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) {
        return Container(
          margin: .symmetric(vertical: 14.h),
          decoration: AppTextFormStyle.container(
            shadow: true,
            color: myTheme.cardColor,
            borderColor: myTheme.globalColor,
          ),

          child: Column(
            mainAxisSize: .min,
            children: [
              ListTileWidget(
                color: myTheme.unselctedColor,
                trailing: Column(
                  crossAxisAlignment: .end,
                  mainAxisAlignment: .start,
                  children: [
                    Text(
                      state
                                  .driverHistoryResponse!
                                  .data[state.selectedIndex!]
                                  .action ==
                              "pay"
                          ? "${state.driverHistoryResponse!.data[state.selectedIndex!].count} muhr"
                          : "1 ta muhr",

                      style: AppTextStyles.style14.copyWith(
                        color: myTheme.text,
                        fontWeight: .bold,
                      ),
                    ),
                    Text(
                      state
                          .driverHistoryResponse!
                          .data[state.selectedIndex!]
                          .summa
                          .toString(),
                      style: AppTextStyles.style14.copyWith(
                        color: myTheme.globalColor,
                      ),
                    ),
                  ],
                ),
                selected: Text(
                  textAlign: .start,
                  state
                              .driverHistoryResponse!
                              .data[state.selectedIndex!]
                              .action ==
                          "pechat"
                      ? "Muhr berildi"
                      : "Naqdlashtirish",
                  style: AppTextStyles.style14.copyWith(
                    fontWeight: .bold,
                    color: myTheme.text,
                  ),
                ),
                unselected: Text(
                  textAlign: .start,
                  AuthRepository.formatDate(
                    state
                        .driverHistoryResponse!
                        .data[state.selectedIndex!]
                        .createdAt!,
                  ),
                  style: AppTextStyles.style13.copyWith(
                    fontWeight: .w500,
                    color: myTheme.text.withValues(alpha: 0.8),
                  ),
                ),
                leading: ContainerWidget(
                  vertical: 46.h,
                  horizontal: 44.w,
                  assets:
                      state
                              .driverHistoryResponse!
                              .data[state.selectedIndex!]
                              .action ==
                          "pechat"
                      ? "assets/money.png"
                      : "assets/img_22.png",
                  assetsHorizontal: 16.75,
                  assetsVertical: 17.5,
                  assetsColor:
                      state
                              .driverHistoryResponse!
                              .data[state.selectedIndex!]
                              .action ==
                          "pechat"
                      ? myTheme.phonColor.withValues(alpha: 0.8)
                      : myTheme.globalColor.withValues(alpha: 0.8),
                  boxDecoration: AppTextFormStyle.container(
                    color:
                        state
                                .driverHistoryResponse!
                                .data[state.selectedIndex!]
                                .action ==
                            "pechat"
                        ? myTheme.phonColor.withValues(alpha: 0.1)
                        : myTheme.globalColor.withValues(alpha: 0.1),
                  ),
                ),
              ),
              Divider(color: myTheme.text.withValues(alpha: 0.2)),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: .symmetric(vertical: 10.h, horizontal: 10.w),
                margin: .symmetric(vertical: 14.h, horizontal: 14.w),
                decoration: AppTextFormStyle.container(
                  color: myTheme.unselctedColor.withValues(alpha: 0.09),
                ),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      "FILIAL & MANZIL",
                      style: AppTextStyles.style10.copyWith(
                        color: myTheme.text,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      state
                          .driverHistoryResponse!
                          .data[state.selectedIndex!]
                          .filialName,
                      style: AppTextStyles.style12.copyWith(
                        color: myTheme.text,
                        fontWeight: .bold,
                      ),
                    ),
                  ],
                ),
              ),
              state
                          .driverHistoryResponse!
                          .data[state.selectedIndex!]
                          .pechats
                          .isNotEmpty ||
                      state
                              .driverHistoryResponse!
                              .data[state.selectedIndex!]
                              .pay !=
                          null
                  ? Padding(
                      padding: .symmetric(horizontal: 14.w, vertical: 5.h),
                      child: Row(
                        mainAxisAlignment: .spaceBetween,
                        children: [
                          Text(
                            "TO'LANGAN MUHRLAR RO'YXATI",
                            style: AppTextStyles.style12.copyWith(
                              fontWeight: .bold,
                              color: myTheme.text,
                            ),
                          ),
                        ],
                      ),
                    )
                  : SizedBox(),
              ListView.separated(
                itemCount:
                    state
                        .driverHistoryResponse!
                        .data[state.selectedIndex!]
                        .pechats
                        .isEmpty
                    ? state
                                  .driverHistoryResponse!
                                  .data[state.selectedIndex!]
                                  .pay !=
                              null
                          ? 1
                          : 0
                    : state
                          .driverHistoryResponse!
                          .data[state.selectedIndex!]
                          .pechats
                          .length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, indedx) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: .symmetric(horizontal: 14.w),
                    decoration: AppTextFormStyle.container(
                      color: myTheme.unselctedColor.withValues(alpha: 0.09),
                    ),
                    child: ListTileWidget(
                      peding: true,
                      color: myTheme.unselctedColor,
                      trailing: Text(
                        state
                                    .driverHistoryResponse!
                                    .data[state.selectedIndex!]
                                    .action ==
                                "pay"
                            ? "${AuthRepository.formatSum(state.driverHistoryResponse!.data[state.selectedIndex!].pechats[indedx].summa.toString())} so'm"
                            : "${AuthRepository.formatSum(state.driverHistoryResponse!.data[state.selectedIndex!].pay?.summa.toString() ?? "0")} so'm",
                        style: AppTextStyles.style14.copyWith(
                          color: myTheme.text,
                        ),
                      ),
                      selected: Text(
                        textAlign: .start,
                        "Muhr #${state.driverHistoryResponse!.data[state.selectedIndex!].action == "pay" ? state.driverHistoryResponse!.data[state.selectedIndex!].pechats[indedx].id.toString() : state.driverHistoryResponse!.data[state.selectedIndex!].pay?.id.toString()}",
                        style: AppTextStyles.style14.copyWith(
                          fontWeight: .bold,
                          color: myTheme.text,
                        ),
                      ),
                      unselected: Text(
                        textAlign: .start,
                        "${state.driverHistoryResponse!.data[state.selectedIndex!].action == "pay" ? AuthRepository.formatDate(state.driverHistoryResponse!.data[state.selectedIndex!].pechats[indedx].createdAt!) : AuthRepository.formatDate(state.driverHistoryResponse!.data[state.selectedIndex!].pay!.createdAt!)}  ",
                        style: AppTextStyles.style13.copyWith(
                          fontWeight: .w500,
                          color: myTheme.text.withValues(alpha: 0.8),
                        ),
                      ),
                      leading: ContainerWidget(
                        vertical: 46.h,
                        horizontal: 44.w,
                        assets: "assets/rubber-stamp.png",
                        assetsHorizontal: 16.75,
                        assetsVertical: 17.5,
                        assetsColor: myTheme.globalColor.withValues(alpha: 0.8),
                        boxDecoration: AppTextFormStyle.container(
                          color: myTheme.globalColor.withValues(alpha: 0.1),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 10.h);
                },
              ),
              // state
              //         .driverHistoryResponse!
              //         .data[state.selectedIndex!]
              //         .pechats
              //         .isNotEmpty
              //     ? Container(
              //         width: MediaQuery.of(context).size.width,
              //         padding: .symmetric(vertical: 10.h, horizontal: 10.w),
              //         margin: .symmetric(vertical: 14.h, horizontal: 14.w),
              //         decoration: AppTextFormStyle.container(
              //           color: myTheme.globalColor.withValues(alpha: 0.06),
              //         ),
              //         child: Column(
              //           children: [
              //             Row(
              //               mainAxisAlignment: .spaceBetween,
              //               children: [
              //                 Text(
              //                   "BALANS O'ZGARISHI",
              //                   style: AppTextStyles.style10.copyWith(
              //                     color: myTheme.text,
              //                   ),
              //                 ),
              //                 Text(
              //                   "JAMI TO'LANGAN NAQD SUMMA",
              //                   style: AppTextStyles.style10.copyWith(
              //                     color: myTheme.text,
              //                   ),
              //                 ),
              //               ],
              //             ),
              //             SizedBox(height: 5.h),
              //             Row(
              //               mainAxisAlignment: .spaceBetween,
              //               children: [
              //                 Text(
              //                   "6 ta - 4ta muhir",
              //                   style: AppTextStyles.style14.copyWith(
              //                     fontWeight: .bold,
              //                     color: myTheme.text,
              //                   ),
              //                 ),
              //                 Text(
              //                   "100 000 so'm (Naqd)",
              //                   style: AppTextStyles.style14.copyWith(
              //                     color: myTheme.globalColor,
              //                     fontWeight: .bold,
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ],
              //         ),
              //       )
              //     : SizedBox(),
              Padding(
                padding: .symmetric(horizontal: 14.w),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 38.h,
                  child: ElevatedButton(
                    style: AppTextFormStyle.buttonStyleBorder(
                      button: false,
                      padding: true,
                      background: myTheme.unselctedColor.withValues(
                        alpha: 0.09,
                      ),
                      foreground: myTheme.text,
                    ),
                    onPressed: () {
                      context.read<TasksCubit>().onTap(

                        state.value,
                        state.hidingData,
                        state.rapidOperations,
                        null,
                          state.type
                      );
                    },
                    child: Row(
                      mainAxisSize: .min,
                      children: [
                        Icon(
                          Icons.keyboard_arrow_up,
                          size: 18.w,
                          color: myTheme.text,
                        ),
                        Text(
                          " Yopish",
                          style: AppTextStyles.style14.copyWith(
                            color: myTheme.text,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
            ],
          ),
        );
      },
    );
  }
}
