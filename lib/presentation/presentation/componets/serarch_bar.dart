import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pechat_pay/data/style/text_style.dart';
import 'package:pechat_pay/logon/home/homle_cubit.dart';
import 'package:pechat_pay/presentation/presentation/componets/smart_refresher_widget.dart';
import 'package:pechat_pay/presentation/presentation/componets/taxis/taxis_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../data/style/text_form_style.dart';
import '../../../data/theme/theme_class.dart';

class SerarchBar extends SearchDelegate {
  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  @override
  String get searchFieldLabel =>
      'Haydovchi qidirish (ism, tel, davlat raqam)...';

  @override
  TextStyle? get searchFieldStyle => AppTextStyles.style14;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = "",
        icon: Icon(
          Icons.clear,
          color: Theme.of(context).extension<ThemeClass>()!.text,
        ),
      ),
      SizedBox(width: 10.w),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: Icon(
        Icons.arrow_back,
        color: Theme.of(context).extension<ThemeClass>()!.text,
      ),
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none,
        hintStyle: AppTextStyles.style14.copyWith(
          color: Theme.of(context).extension<ThemeClass>()!.unselctedColor,
        ),
      ),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    try {
      await context.read<HomleCubit>().searchHome(1, query);
      _refreshController.refreshCompleted();
      _refreshController.resetNoData();
    } catch (_) {
      _refreshController.refreshFailed();
    }
  }

  Future<void> _onLoading(BuildContext context) async {
    final cubit = context.read<HomleCubit>();
    final model = cubit.state.driverNoactiveResponse;

    if (model == null || model.meta.lastPage <= model.meta.currentPage) {
      _refreshController.loadNoData();
      return;
    }

    try {
      await cubit.searchHome(model.meta.currentPage + 1, query);
      _refreshController.loadComplete();
    } catch (_) {
      _refreshController.loadFailed();
    }
  }

  @override
  Widget buildResults(BuildContext context) {
    final side = MediaQuery.sizeOf(context).shortestSide;

    Future<void> onRefresh() => _onRefresh(context);
    Future<void> onLoading() => _onLoading(context);

    if (side < 600) {
      return SearchPhoneView(
        refreshController: _refreshController,
        onRefresh: onRefresh,
        onLoading: onLoading,
      );
    } else if (side < 840) {
      return SearchSmallTabletView(
        refreshController: _refreshController,
        onRefresh: onRefresh,
        onLoading: onLoading,
      );
    } else {
      return SearchTabletView(
        refreshController: _refreshController,
        onRefresh: onRefresh,
        onLoading: onLoading,
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;
    return BlocBuilder<HomleCubit, HomleState>(
      builder: (context, state) {
        if (state is HomeLoding) {
          return Center(
            child: CircularProgressIndicator(color: myTheme.globalColor),
          );
        }
        return Center(child: Image.asset("assets/img_39.png", width: 150.w));
      },
    );
  }

  @override
  void showResults(BuildContext context) {
    if (query.isNotEmpty) {
      context.read<HomleCubit>().searchHome(1, query);
      super.showResults(context);
    }
  }
}

// ======================= 1. TELEFON =======================
class SearchPhoneView extends StatefulWidget {
  final Future<void> Function() onRefresh;
  final Future<void> Function() onLoading;
  final RefreshController refreshController;

  const SearchPhoneView({
    super.key,
    required this.onRefresh,
    required this.onLoading,
    required this.refreshController,
  });

  @override
  State<SearchPhoneView> createState() => _SearchPhoneViewState();
}

class _SearchPhoneViewState extends State<SearchPhoneView> {
  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;

    return BlocBuilder<HomleCubit, HomleState>(
      builder: (context, state) {
        final response = state.driverNoactiveResponse;

        if (state is HomeLoding && response == null) {
          return const SizedBox();
        }
        if (response == null || response.data.isEmpty) {
          return const Center(child: Text("Ma'lumot topilmadi"));
        }

        final items = response.data;

        return AppSmartRefresher(
          controller: widget.refreshController,
          onRefresh: () => widget.onRefresh(),
          onLoading: () => widget.onLoading(),
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                sliver: SliverMainAxisGroup(
                  slivers: [
                    SliverToBoxAdapter(child: SizedBox(height: 14.h)),
                    SliverToBoxAdapter(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "HAYDOVCHILAR RO'YXATI",
                            style: AppTextStyles.style12.copyWith(
                              color: myTheme.text.withValues(alpha: 0.9),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Container(
                            decoration: AppTextFormStyle.container(
                              color: myTheme.globalColor.withValues(alpha: 0.1),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 5.h,
                              horizontal: 6.w,
                            ),
                            child: Text(
                              "${response.meta.total} ta topildi",
                              style: AppTextStyles.style12.copyWith(
                                color: myTheme.globalColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SliverToBoxAdapter(child: SizedBox(height: 10.h)),
                    SliverList.separated(
                      itemCount: items.length,
                      separatorBuilder: (_, _) => SizedBox(height: 12.h),
                      itemBuilder: (_, i) => TaxisWidget(
                        key: ValueKey(items[i].id),
                        driverNoactiveModel: items[i],
                        driver: null,
                      ),
                    ),
                    SliverToBoxAdapter(child: SizedBox(height: 20.h)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ======================= 2. KICHIK PLANSHET =======================
class SearchSmallTabletView extends StatefulWidget {
  final Future<void> Function() onRefresh;
  final Future<void> Function() onLoading;
  final RefreshController refreshController;

  const SearchSmallTabletView({
    super.key,
    required this.onRefresh,
    required this.onLoading,
    required this.refreshController,
  });

  @override
  State<SearchSmallTabletView> createState() => _SearchSmallTabletViewState();
}

class _SearchSmallTabletViewState extends State<SearchSmallTabletView> {
  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;

    return BlocBuilder<HomleCubit, HomleState>(
      builder: (context, state) {
        final response = state.driverNoactiveResponse;

        if (state is HomeLoding && response == null) {
          return const SizedBox();
        }
        if (response == null || response.data.isEmpty) {
          return const Center(child: Text("Ma'lumot topilmadi"));
        }

        final items = response.data;

        return AppSmartRefresher(
          controller: widget.refreshController,
          onRefresh: () => widget.onRefresh(),
          onLoading: () => widget.onLoading(),
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                sliver: SliverMainAxisGroup(
                  slivers: [
                    SliverToBoxAdapter(child: SizedBox(height: 14.h)),
                    SliverToBoxAdapter(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "HAYDOVCHILAR RO'YXATI",
                            style: AppTextStyles.style12.copyWith(
                              color: myTheme.text.withValues(alpha: 0.9),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Container(
                            decoration: AppTextFormStyle.container(
                              color: myTheme.globalColor.withValues(alpha: 0.1),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 5.h,
                              horizontal: 6.w,
                            ),
                            child: Text(
                              "${response.meta.total} ta topildi",
                              style: AppTextStyles.style12.copyWith(
                                color: myTheme.globalColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SliverToBoxAdapter(child: SizedBox(height: 10.h)),
                    SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      sliver: SliverList.separated(
                        itemCount: items.length,
                        separatorBuilder: (_, _) => SizedBox(height: 20.h),
                        itemBuilder: (_, i) => TaxisWidget(
                          key: ValueKey(items[i].id),
                          driverNoactiveModel: items[i],
                          driver: null,
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(child: SizedBox(height: 20.h)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ======================= 3. KATTA PLANSHET =======================
class SearchTabletView extends StatefulWidget {
  final Future<void> Function() onRefresh;
  final Future<void> Function() onLoading;
  final RefreshController refreshController;

  const SearchTabletView({
    super.key,
    required this.onRefresh,
    required this.onLoading,
    required this.refreshController,
  });

  @override
  State<SearchTabletView> createState() => _SearchTabletViewState();
}

class _SearchTabletViewState extends State<SearchTabletView> {
  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;

    return BlocBuilder<HomleCubit, HomleState>(
      builder: (context, state) {
        final response = state.driverNoactiveResponse;

        if (state is HomeLoding && response == null) {
          return const SizedBox();
        }
        if (response == null || response.data.isEmpty) {
          return const Center(child: Text("Ma'lumot topilmadi"));
        }

        final items = response.data;

        return AppSmartRefresher(
          controller: widget.refreshController,
          onRefresh: () => widget.onRefresh(),
          onLoading: () => widget.onLoading(),
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                sliver: SliverMainAxisGroup(
                  slivers: [
                    SliverToBoxAdapter(child: SizedBox(height: 14.h)),
                    SliverToBoxAdapter(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "HAYDOVCHILAR RO'YXATI",
                            style: AppTextStyles.style12.copyWith(
                              color: myTheme.text.withValues(alpha: 0.9),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Container(
                            decoration: AppTextFormStyle.container(
                              color: myTheme.globalColor.withValues(alpha: 0.1),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 5.h,
                              horizontal: 6.w,
                            ),
                            child: Text(
                              "${response.meta.total} ta topildi",
                              style: AppTextStyles.style12.copyWith(
                                color: myTheme.globalColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SliverToBoxAdapter(child: SizedBox(height: 10.h)),
                    SliverGrid.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10.h,
                        crossAxisSpacing: 10.w,
                        childAspectRatio: 1.85
                      ),
                      itemBuilder: (_, i) => TaxisWidget(
                        key: ValueKey(items[i].id),
                        driverNoactiveModel: items[i],
                        driver: null,
                      ),
                      itemCount: items.length,
                    ),
                    SliverToBoxAdapter(child: SizedBox(height: 20.h)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
