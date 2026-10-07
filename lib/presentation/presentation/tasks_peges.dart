import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pechat_pay/data/style/text_form_style.dart';
import 'package:pechat_pay/logon/home/homle_cubit.dart';
import 'package:pechat_pay/logon/tasks/tasks_cubit.dart';
import 'package:pechat_pay/presentation/presentation/componets/profil/filter_button.dart';
import 'package:pechat_pay/presentation/presentation/componets/smart_refresher_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../data/style/text_style.dart';
import '../../data/theme/theme_class.dart';
import 'componets/app_bar_widget.dart';
import 'componets/taxis/chip_widget.dart';
import 'componets/taxis/driver_add_edit.dart';
import 'componets/taxis/taxis_widget.dart';

class TasksPeges extends StatefulWidget {
  const TasksPeges({super.key});

  @override
  State<TasksPeges> createState() => _TasksPegesState();
}

class _TasksPegesState extends State<TasksPeges> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _refreshController = RefreshController(initialRefresh: false);
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  late final RefreshController _refreshController;

  Future<void> onTap(int id) async {
    await context.read<TasksCubit>().driversPage(_searchController.text, id);
    if (!mounted) return;
    _refreshController.resetNoData();
  }

  Future<void> _onRefresh() async {
    try {
      await onTap(1);
      _refreshController.refreshCompleted();
      _refreshController.resetNoData();
    } catch (_) {
      _refreshController.refreshFailed();
    }
  }

  bool isLoadingShown = false;

  Future<void> _onLoading() async {
    final cubit = context.read<TasksCubit>();
    final model = cubit.state.driversPage;

    if (model == null || model.meta.lastPage <= model.meta.currentPage) {
      _refreshController.loadNoData();
      return;
    }

    try {
      await onTap(model.meta.currentPage + 1);
      _refreshController.loadComplete();
    } catch (_) {
      _refreshController.loadFailed();
    }
  }

  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;

    return Scaffold(
      appBar: AppBarWidget(),
      body: BlocListener<HomleCubit, HomleState>(
  listener: (context, holat) {
    if (holat is HomeLoding && holat.historyHomePage != null) {
      if (!isLoadingShown) {
        isLoadingShown = true;
        showDialog(
          context: context,
          barrierDismissible: false,
          barrierColor: Colors.black54,
          useRootNavigator: true,
          builder: (_) => PopScope(
            canPop: false,
            child: Center(child: CircularProgressIndicator(color: myTheme.globalColor,)),
          ),
        ).then((_) => isLoadingShown = false);
      }
    } else {
      if (isLoadingShown) {
        Navigator.of(context, rootNavigator: true).pop();
        isLoadingShown = false;
      }
    }
  },
  child: BlocBuilder<TasksCubit, TasksState>(
        builder: (context, state) {
          if(state is  TasksLoding && state.driversPage==null){
            return Center(
              child: CircularProgressIndicator(color: myTheme.globalColor),
            );
          }else if(state.driversPage!=null){
          return AppSmartRefresher(
            onLoading: ()=>_onLoading(),
            onRefresh:()=>_onRefresh() ,
            controller: _refreshController,
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: .symmetric(horizontal: 14.w),
                  sliver: SliverMainAxisGroup(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Form(
                          key: formKey,
                          child: Row(
                            children: [
                              SizedBox(
                                height: 44.h,
                                width: 260.w,
                                child: TextFormField(
                                  controller: _searchController,
                                  decoration: AppTextFormStyle.sorchText(
                                    color: myTheme.text.withValues(alpha: 0.9),
                                    text: "Ism, telefon yoki avtoraqam...",
                                    icon: Icon(Icons.search, size: 19.w),
                                  ),
                                  onFieldSubmitted: (value) {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    onTap(1);
                                  },
                                ),
                              ),
                              SizedBox(width: 8.w),
                              SizedBox(
                                height: 44.h,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => DriverAddEdit(),
                                      ),
                                    );
                                  },
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
                                      name: state.chip[index].name,
                                      isSelected: state.chip[index].selected,
                                      onTap: () async {
                                        await context.read<TasksCubit>().chip(
                                          index,
                                        );
                                        await onTap(1);
                                      },
                                    ),
                                  );
                                },
                                scrollDirection: .horizontal,
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                      return SizedBox(width: 8.w);
                                    },
                                itemCount: state.chip.length,
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
                                        color: myTheme.text.withValues(
                                          alpha: 0.9,
                                        ),
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
                                        "${state.driversPage?.meta.total ?? 0} ta topildi",
                                        style: AppTextStyles.style12.copyWith(
                                          color: myTheme.globalColor,
                                          fontWeight: .bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                FilterButton(
                                  onFilterSelected: (value) async {
                                    await context.read<TasksCubit>().onTap(
                                      value,
                                      state.hidingData,
                                      state.rapidOperations,
                                      state.selectedIndex,
                                      state.type,
                                    );
                                    if (mounted) {
                                      await onTap(1);
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      SliverToBoxAdapter(child: SizedBox(height: 10.h)),
                      if(state.driversPage!=null && state.driversPage!.data.isNotEmpty)
                      SliverList.separated(
                        itemBuilder: (ctx, index) {
                          return TaxisWidget(
                            key: ValueKey(index),
                            driverNoactiveModel: state.driversPage!.data[index],
                          );
                        },
                        itemCount: state.driversPage?.data.length ?? 0,
                        separatorBuilder: (ctx, index) =>
                            SizedBox(height: 12.h, key: ValueKey(index)),
                      ),
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: Text("Haydochi topilmadi"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );}else{
            return Center(
              child: Text(
                "Ma'lumot topilmadi",
                style: AppTextStyles.style14.copyWith(color: myTheme.text),
              ),
            );
          }
        },
        
      ),
),
    );
  }
}
