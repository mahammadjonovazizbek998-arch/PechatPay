import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pechat_pay/logon/tasks/tasks_cubit.dart';
import 'package:pechat_pay/presentation/presentation/componets/smart_refresher_widget.dart';
import 'package:pechat_pay/presentation/presentation/componets/taxis/repid_operations.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../data/get_it/get_it.dart';
import '../../../../data/repository/auth.dart';

import '../../../../data/style/text_form_style.dart';
import '../../../../data/style/text_style.dart';
import '../../../../data/theme/theme_class.dart';
import '../../../../logon/home/homle_cubit.dart';
import '../list_tile.dart';
import 'cash.dart';
import 'driver_add_edit.dart';
import 'history_of_operations.dart';

class IssuingASealPeges extends StatefulWidget {
  final Color color;
  final int id;

  const IssuingASealPeges({super.key, required this.color, required this.id});

  @override
  State<IssuingASealPeges> createState() => _IssuingASealPegesState();
}

class _IssuingASealPegesState extends State<IssuingASealPeges> {
  AuthRepository authRepository = AuthRepository();
  late final RefreshController _refreshController;

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    sl<TasksCubit>().show(widget.id, 1);
    _refreshController = RefreshController(initialRefresh: false);
  }

  Future<void> _onRefresh() async {
    try {
      final cubit = context.read<TasksCubit>();
      await cubit.showHistory(widget.id, 1);
      _refreshController.refreshCompleted();
      _refreshController.resetNoData();
    } catch (_) {
      _refreshController.refreshFailed();
    }
  }

  bool isLoadingShown = false;

  Future<void> _onLoading() async {
    final cubit = context.read<TasksCubit>();
    final model = cubit.state.driverHistoryResponse;

    if (model == null || model.meta.lastPage <= model.meta.currentPage) {
      _refreshController.loadNoData();
      return;
    }

    try {
      await cubit.showHistory(widget.id, model.meta.currentPage + 1);
      _refreshController.loadComplete();
    } catch (_) {
      _refreshController.loadFailed();
    }
  }

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
          if (state is TasksLoding) {
            return Center(
              child: CircularProgressIndicator(color: myTheme.globalColor),
            );
          } else if (state is TasksFinish && state.driverDetailData != null) {
            return AppSmartRefresher(
              onLoading: () => _onLoading(),
              onRefresh: () => _onRefresh(),
              controller: _refreshController,
              child: CustomScrollView(
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
                              shadow: true,
                            ),

                            child: Column(
                              mainAxisSize: .min,
                              children: [
                                ListTileWidget(
                                  selected: Text(
                                    maxLines: 1,
                                    overflow: .ellipsis,
                                    state.driverDetailData?.driver.name ?? "",
                                    style: AppTextStyles.style16.copyWith(
                                      color: myTheme.text,
                                      fontWeight: .w900,
                                    ),
                                  ),
                                  unselected: Text(
                                    AuthRepository.formatUzbekPhone(
                                      state.driverDetailData?.driver.phone ??
                                          "901234567",
                                    ),
                                    style: AppTextStyles.style12.copyWith(
                                      color: myTheme.text.withValues(
                                        alpha: 0.9,
                                      ),
                                    ),
                                  ),

                                  leading: ContainerWidget(
                                    vertical: 74.h,
                                    horizontal: 60.w,
                                    text: Text(
                                      state.driverDetailData!.driver.name
                                                  .split(" ")
                                                  .length >
                                              1
                                          ? "${state.driverDetailData!.driver.name.split(" ")[0].substring(0, 1)}${state.driverDetailData!.driver.name.split(" ")[1].substring(0, 1)}"
                                          : state.driverDetailData!.driver.name
                                                .split(" ")[0]
                                                .substring(0, 2)
                                                .toUpperCase(),
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
                                  trailing: GestureDetector(
                                    onTap: () {
                                      authRepository.callNumber(
                                        state.driverDetailData!.driver.phone,
                                      );
                                    },
                                    child: ContainerWidget(
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
                                              color: myTheme.unselctedColor
                                                  .withValues(alpha: 0.2),
                                            ),
                                            borderRadius: .circular(25.r),
                                          ),
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
                                    color: myTheme.unselctedCardColor
                                        .withValues(alpha: 0.7),
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
                                            "Ro'yxatdan o'tgan:\n ${AuthRepository.formatDate(state.driverDetailData!.driver.createdAt!)}",
                                            style: AppTextStyles.style13
                                                .copyWith(color: myTheme.text),
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
                                                    color:
                                                        myTheme.unselctedColor,
                                                  ),
                                                ),
                                              ),
                                              child: Text(
                                                state
                                                    .driverDetailData!
                                                    .driver
                                                    .carNumber
                                                    .substring(0, 2),
                                                style: AppTextStyles.style12
                                                    .copyWith(
                                                      color: myTheme.text,
                                                      fontWeight: .bold,
                                                    ),
                                              ),
                                            ),
                                            Text(
                                              AuthRepository.formatUzbekCarNumber(
                                                state
                                                    .driverDetailData!
                                                    .driver
                                                    .carNumber,
                                              ),
                                              style: AppTextStyles.style12
                                                  .copyWith(
                                                    color: myTheme.text,
                                                    fontWeight: .bold,
                                                  ),
                                            ),
                                            Text(
                                              textAlign: .left,
                                              "uz",
                                              style: AppTextStyles.style12
                                                  .copyWith(
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
                                      onPressed: () {
                                        final tasksCubit = context
                                            .read<TasksCubit>();
                                        final homleCubit = context
                                            .read<HomleCubit>();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => DriverAddEdit(
                                              driverName: state
                                                  .driverDetailData!
                                                  .driver
                                                  .name,
                                              driverPhoneNumber: state
                                                  .driverDetailData!
                                                  .driver
                                                  .phone,
                                              licensePlate: state
                                                  .driverDetailData!
                                                  .driver
                                                  .carNumber,
                                              id: widget.id,
                                              unpaidPechatsCount: state
                                                  .driverDetailData!
                                                  .driver
                                                  .unpaidPechatsCount
                                                  .toString(),
                                              unpaidPechatsSum: state
                                                  .driverDetailData!
                                                  .driver
                                                  .unpaidPechatsSum
                                                  .toString(),
                                            ),
                                          ),
                                        ).then((_) {
                                          // Tahrirlash tugagandan so'ng ma'lumotlarni yangilaymiz
                                          tasksCubit.show(widget.id, 1);
                                          homleCubit.historyHomePage(1);
                                        });
                                      },
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
                            padding: .symmetric(
                              vertical: 16.h,
                              horizontal: 16.w,
                            ),
                            decoration: AppTextFormStyle.container(
                              color: myTheme.cardColor,
                              shadow: true,
                            ),

                            child: Column(
                              mainAxisSize: .min,
                              children: [
                                Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  mainAxisAlignment: .spaceBetween,
                                  children: [
                                    Text(
                                      "QOLGAN MUHRLAR",
                                      style: AppTextStyles.style12.copyWith(
                                        color: myTheme.text.withValues(
                                          alpha: 0.9,
                                        ),
                                        fontWeight: .w500,
                                      ),
                                    ),
                                    Text(
                                      "UMUMIY QIYMAT",
                                      style: AppTextStyles.style12.copyWith(
                                        color: myTheme.text.withValues(
                                          alpha: 0.9,
                                        ),
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
                                          state
                                              .driverDetailData!
                                              .driver
                                              .unpaidPechatsCount
                                              .toString(),
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
                                          AuthRepository.formatSum(
                                            state
                                                .driverDetailData!
                                                .driver
                                                .unpaidPechatsSum
                                                .toString(),
                                          ),
                                          style: AppTextStyles.style22.copyWith(
                                            color: myTheme.globalColor,
                                          ),
                                        ),
                                        Text(
                                          " so'm",
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
                                    color: myTheme.unselctedCardColor
                                        .withValues(alpha: 0.7),
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
                                                          .withValues(
                                                            alpha: 0.9,
                                                          ),
                                                      fontWeight: .w500,
                                                    ),
                                              ),
                                              Text(
                                                "${state.driverDetailData!.driver.totalPechatsCount} ta",
                                                style: AppTextStyles.style16
                                                    .copyWith(
                                                      color: myTheme.text,
                                                    ),
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
                                                          .withValues(
                                                            alpha: 0.9,
                                                          ),
                                                      fontWeight: .w500,
                                                    ),
                                              ),
                                              Text(
                                                "${state.driverDetailData!.driver.paidPechatsCount} ta",
                                                style: AppTextStyles.style16
                                                    .copyWith(
                                                      color: myTheme.text,
                                                    ),
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
                                  shadow: true,
                                ),

                                child: Column(
                                  mainAxisSize: .min,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: .start,
                                      children: [
                                        Text(
                                          "Tezkor operatsiyalar",
                                          style: AppTextStyles.style16.copyWith(
                                            color: myTheme.text,
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
                                                style: AppTextFormStyle.buttonStyleBorder(
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
                                                  context
                                                      .read<TasksCubit>()
                                                      .onTap(
                                                        state.value,
                                                        state.hidingData,
                                                        false,
                                                        state.selectedIndex,
                                                        state.type,
                                                      );
                                                },
                                                child: Row(
                                                  mainAxisSize: .min,
                                                  children: [
                                                    Icon(Icons.add, size: 18.w),
                                                    Text(
                                                      " Muhr berish",
                                                      style:
                                                          AppTextStyles.style14,
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
                                                style: AppTextFormStyle.buttonStyleBorder(
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
                                                  context
                                                      .read<TasksCubit>()
                                                      .onTap(
                                                        state.value,
                                                        state.hidingData,
                                                        true,
                                                        state.selectedIndex,
                                                        state.type,
                                                      );
                                                },
                                                child: Row(
                                                  mainAxisSize: .min,
                                                  children: [
                                                    Image.asset(
                                                      "assets/img_24.png",
                                                      width: 16.w,
                                                      color:
                                                          !state.rapidOperations
                                                          ? myTheme.text
                                                          : myTheme.globalColor,
                                                    ),

                                                    Text(
                                                      " Naqdlashtirish",
                                                      style:
                                                          AppTextStyles.style14,
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
                                        ? Cash(id: widget.id)
                                        : Repidoperations(id: widget.id),
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
                          itemCount: state.driverHistoryResponse != null
                              ? state.driverHistoryResponse!.data.length
                              : 0,
                          itemBuilder: (context, index) {
                            if (state.selectedIndex == index) {
                              return HistoryOfOperations();
                            } else {
                              return Container(
                                padding: .symmetric(
                                  vertical: 3.h,
                                  horizontal: 3.w,
                                ),
                                margin: .symmetric(vertical: 10.h),
                                decoration: AppTextFormStyle.container(
                                  color: myTheme.textColor,
                                ),
                                child: ListTileWidget(
                                  widget: false,
                                  icoBool: true,

                                  onTap: () {
                                    context.read<TasksCubit>().onTap(
                                      state.value,
                                      state.hidingData,
                                      state.rapidOperations,
                                      index,
                                      state.type,
                                    );
                                  },

                                  color: myTheme.unselctedColor,
                                  trailing: Column(
                                    crossAxisAlignment: .end,
                                    mainAxisAlignment: .center,
                                    children: [
                                      Text(
                                        state
                                                    .driverHistoryResponse!
                                                    .data[index]
                                                    .action ==
                                                "pay"
                                            ? "${state.driverHistoryResponse!.data[index].count} muhr"
                                            : "1 ta muhr",
                                        style: AppTextStyles.style14.copyWith(
                                          color: myTheme.phonColor,
                                          fontWeight: .bold,
                                        ),
                                      ),
                                      Text(
                                        state
                                            .driverHistoryResponse!
                                            .data[index]
                                            .summa
                                            .toString(),
                                        style: AppTextStyles.style14.copyWith(
                                          color: myTheme.text,
                                        ),
                                      ),
                                    ],
                                  ),
                                  selected: Text(
                                    textAlign: .start,
                                    state
                                                .driverHistoryResponse!
                                                .data[index]
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
                                          .data[index]
                                          .createdAt!,
                                    ),
                                    style: AppTextStyles.style13.copyWith(
                                      fontWeight: .w500,
                                      color: myTheme.text.withValues(
                                        alpha: 0.8,
                                      ),
                                    ),
                                  ),
                                  leading: ContainerWidget(
                                    vertical: 46.h,
                                    horizontal: 44.w,
                                    assets:
                                        state
                                                .driverHistoryResponse!
                                                .data[index]
                                                .action ==
                                            "pechat"
                                        ? "assets/money.png"
                                        : "assets/img_22.png",
                                    assetsHorizontal: 16.75,
                                    assetsVertical: 17.5,
                                    assetsColor:
                                        state
                                                .driverHistoryResponse!
                                                .data[index]
                                                .action ==
                                            "pechat"
                                        ? myTheme.phonColor
                                        : myTheme.globalColor,
                                    boxDecoration: AppTextFormStyle.container(
                                      color:
                                          state
                                                  .driverHistoryResponse!
                                                  .data[index]
                                                  .action ==
                                              "pechat"
                                          ? myTheme.phonColor.withValues(
                                              alpha: 0.1,
                                            )
                                          : myTheme.globalColor.withValues(
                                              alpha: 0.1,
                                            ),
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
