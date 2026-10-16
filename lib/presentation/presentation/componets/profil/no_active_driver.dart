import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pechat_pay/logon/profil/profil_cubit.dart';
import 'package:pechat_pay/presentation/presentation/componets/smart_refresher_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../data/get_it/get_it.dart';
import '../../../../data/style/text_form_style.dart';
import '../../../../data/style/text_style.dart';
import '../../../../data/theme/theme_class.dart';
import '../taxis/taxis_widget.dart';
import 'filter_button.dart';

class NoActiveDriver extends StatefulWidget {
  const NoActiveDriver({super.key});

  @override
  State<NoActiveDriver> createState() => _NoActiveDriverState();
}

class _NoActiveDriverState extends State<NoActiveDriver> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sl<ProfilCubit>().noActiveDriver(7, 1);
  }

  double get shortestSide => MediaQuery.sizeOf(context).shortestSide;

  bool get isPhone => shortestSide < 600;

  bool get isSmallTablet => shortestSide >= 600 && shortestSide < 840;

  bool get isTablet => shortestSide >= 840;

  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: myTheme.globalBackgroundColor,
        title: Column(
          mainAxisAlignment: .start,
          crossAxisAlignment: .start,
          mainAxisSize: .min,
          children: [
            Text(
              textAlign: .start,
              "Nofaol haydovchilar",
              style: AppTextStyles.style18.copyWith(
                fontWeight: .bold,
                color: myTheme.text,
              ),
            ),
            Text(
              textAlign: .start,
              "PechatPay tizimida nofaol haydovchilar tahlili",
              style: AppTextStyles.style10.copyWith(
                fontWeight: .w400,
                color: myTheme.text.withValues(alpha: 0.9),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: isPhone
            ? IsPhoneNoActiveDriver()
            : isSmallTablet
            ? IsSmallTabletNoActiveDriver()
            : IsTabletNoActiveDriver(),
      ),
    );
  }
}

class IsPhoneNoActiveDriver extends StatefulWidget {
  const IsPhoneNoActiveDriver({super.key});

  @override
  State<IsPhoneNoActiveDriver> createState() => _IsPhoneNoActiveDriverState();
}

class _IsPhoneNoActiveDriverState extends State<IsPhoneNoActiveDriver> {
  late final RefreshController _refreshController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshController = RefreshController(initialRefresh: false);
  }

  Future<void> _onRefresh() async {
    try {
      final cubit = context.read<ProfilCubit>();
      final state = cubit.state;
      await cubit.noActiveDriver(int.parse(state.day), 1);
      _refreshController.refreshCompleted();
      _refreshController.resetNoData();
    } catch (_) {
      _refreshController.refreshFailed();
    }
  }

  Future<void> onTap(int id, String day) async {
    await context.read<ProfilCubit>().noActiveDriver(int.parse(day), id);

    if (!mounted) return;
    _refreshController.resetNoData();
  }

  Future<void> _onLoading() async {
    final cubit = context.read<ProfilCubit>();
    final model = cubit.state.driverNoactiveModel;
    final  state = cubit.state;

    if (model == null || model.meta.lastPage <= model.meta.currentPage) {
      _refreshController.loadNoData();
      return;
    }

    try {
      await onTap(model.meta.currentPage + 1,state.day);

      if (!mounted) return;
      _refreshController.loadComplete();
    } catch (_) {
      if (!mounted) return;
      _refreshController.loadFailed();
    }
  }

  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;
    return BlocBuilder<ProfilCubit, ProfilState>(
      builder: (context, state) {
        if (state is ProfilLoding) {
          return Center(
            child: CircularProgressIndicator(color: myTheme.globalColor),
          );
        }
        else {
          return AppSmartRefresher(
            onLoading: () => _onLoading(),
            onRefresh: ()=>_onRefresh(),
            controller: _refreshController,
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: .symmetric(vertical: 16.h, horizontal: 16.w),
                  sliver: SliverMainAxisGroup(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Row(
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
                                    "${state.driverNoactiveModel != null ? state.driverNoactiveModel!.meta.total : 0} ta topildi",
                                    style: AppTextStyles.style12.copyWith(
                                      color: myTheme.globalColor,
                                      fontWeight: .bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            NoActiveDriverFilterButton(
                              onFilterSelected: (value) {
                                onTap(1,value);
                              },
                            ),
                          ],
                        ),
                      ),
                      SliverToBoxAdapter(child: SizedBox(height: 10.h)),
                      SliverList.separated(
                        itemCount: state.driverNoactiveModel != null
                            ? state.driverNoactiveModel!.data.length
                            : 0,
                        itemBuilder: (context, index) {
                          return TaxisWidget(
                            phone: true,
                            driverNoactiveModel:
                                state.driverNoactiveModel!.data[index],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 16.h);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class IsSmallTabletNoActiveDriver extends StatefulWidget {
  const IsSmallTabletNoActiveDriver({super.key});

  @override
  State<IsSmallTabletNoActiveDriver> createState() =>
      _IsSmallTabletNoActiveDriverState();
}

class _IsSmallTabletNoActiveDriverState
    extends State<IsSmallTabletNoActiveDriver> {
  late final RefreshController _refreshController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshController = RefreshController(initialRefresh: false);
  }

  Future<void> _onRefresh() async {
    try {
      final cubit = context.read<ProfilCubit>();
      final state = cubit.state;
      await cubit.noActiveDriver(int.parse(state.day), 1);
      _refreshController.refreshCompleted();
      _refreshController.resetNoData();
    } catch (_) {
      _refreshController.refreshFailed();
    }
  }

  Future<void> onTap(int id, String day) async {
    await context.read<ProfilCubit>().noActiveDriver(int.parse(day), id);

    if (!mounted) return;
    _refreshController.resetNoData();
  }

  Future<void> _onLoading() async {
    final cubit = context.read<ProfilCubit>();
    final model = cubit.state.driverNoactiveModel;
    final  state = cubit.state;

    if (model == null || model.meta.lastPage <= model.meta.currentPage) {
      _refreshController.loadNoData();
      return;
    }

    try {
      await onTap(model.meta.currentPage + 1,state.day);

      if (!mounted) return;
      _refreshController.loadComplete();
    } catch (_) {
      if (!mounted) return;
      _refreshController.loadFailed();
    }
  }

  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;
    return BlocBuilder<ProfilCubit, ProfilState>(
      builder: (context, state) {
        if (state is ProfilLoding) {
          return Center(
            child: CircularProgressIndicator(color: myTheme.globalColor),
          );
        } else {
          return AppSmartRefresher(
            onLoading: () => _onLoading(),
            onRefresh: ()=>_onRefresh(),
            controller: _refreshController,
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: .symmetric(vertical: 16.h, horizontal: 16.w),
                  sliver: SliverMainAxisGroup(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Row(
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
                                    "${state.driverNoactiveModel != null ? state.driverNoactiveModel!.meta.total : 0} ta topildi",
                                    style: AppTextStyles.style12.copyWith(
                                      color: myTheme.globalColor,
                                      fontWeight: .bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            NoActiveDriverFilterButton(
                              onFilterSelected: (value) {
                                onTap(1,value);
                              },
                            ),
                          ],
                        ),
                      ),
                      SliverToBoxAdapter(child: SizedBox(height: 10.h)),
                      SliverPadding(padding: .symmetric(horizontal: 14.h),sliver: SliverList.separated(
                        itemCount: state.driverNoactiveModel != null
                            ? state.driverNoactiveModel!.data.length
                            : 0,
                        itemBuilder: (context, index) {
                          return TaxisWidget(
                            phone: true,
                            driverNoactiveModel:
                            state.driverNoactiveModel!.data[index],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 20.h);
                        },
                      ),)
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class IsTabletNoActiveDriver extends StatefulWidget {
  const IsTabletNoActiveDriver({super.key});

  @override
  State<IsTabletNoActiveDriver> createState() => _IsTabletNoActiveDriverState();
}

class _IsTabletNoActiveDriverState extends State<IsTabletNoActiveDriver> {
  late final RefreshController _refreshController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshController = RefreshController(initialRefresh: false);
  }

  Future<void> _onRefresh() async {
    try {
      final cubit = context.read<ProfilCubit>();
      final state = cubit.state;
      await cubit.noActiveDriver(int.parse(state.day), 1);
      _refreshController.refreshCompleted();
      _refreshController.resetNoData();
    } catch (_) {
      _refreshController.refreshFailed();
    }
  }

  Future<void> onTap(int id, String day) async {
    await context.read<ProfilCubit>().noActiveDriver(int.parse(day), id);

    if (!mounted) return;
    _refreshController.resetNoData();
  }

  Future<void> _onLoading() async {
    final cubit = context.read<ProfilCubit>();
    final model = cubit.state.driverNoactiveModel;
    final  state = cubit.state;

    if (model == null || model.meta.lastPage <= model.meta.currentPage) {
      _refreshController.loadNoData();
      return;
    }

    try {
      await onTap(model.meta.currentPage + 1,state.day);

      if (!mounted) return;
      _refreshController.loadComplete();
    } catch (_) {
      if (!mounted) return;
      _refreshController.loadFailed();
    }
  }

  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;
    return BlocBuilder<ProfilCubit, ProfilState>(
      builder: (context, state) {
        if (state is ProfilLoding) {
          return Center(
            child: CircularProgressIndicator(color: myTheme.globalColor),
          );
        } else {
          return AppSmartRefresher(
            onLoading: () => _onLoading(),
            onRefresh: ()=>_onRefresh(),
            controller: _refreshController,
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: .symmetric(vertical: 16.h, horizontal: 16.w),
                  sliver: SliverMainAxisGroup(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Row(
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
                                    "${state.driverNoactiveModel != null ? state.driverNoactiveModel!.meta.total : 0} ta topildi",
                                    style: AppTextStyles.style12.copyWith(
                                      color: myTheme.globalColor,
                                      fontWeight: .bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            NoActiveDriverFilterButton(
                              onFilterSelected: (value) {
                                onTap(1,value);
                              },
                            ),
                          ],
                        ),
                      ),
                      SliverToBoxAdapter(child: SizedBox(height: 10.h)),
                     SliverGrid.builder( gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                         crossAxisCount: 2,
                         mainAxisSpacing: 10.h,
                         crossAxisSpacing: 10.w,
                         childAspectRatio: 1.85
                     ), itemCount: state.driverNoactiveModel != null
                         ? state.driverNoactiveModel!.data.length
                         : 0,
                       itemBuilder: (context, index) {
                         return TaxisWidget(
                           phone: true,
                           driverNoactiveModel:
                           state.driverNoactiveModel!.data[index],
                         );
                       },)
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
