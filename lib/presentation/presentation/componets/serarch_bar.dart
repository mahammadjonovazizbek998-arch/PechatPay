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
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: Icon(
          Icons.clear,
          color: Theme.of(context).extension<ThemeClass>()!.text,
        ),
      ),
      SizedBox(width: 10.w),
    ];
  }

  @override
  String get searchFieldLabel =>
      'Haydovchi qidirish (ism, tel, davlat raqam)...';

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(
        Icons.arrow_back,
        color: Theme.of(context).extension<ThemeClass>()!.text,
      ),
    );
  }

  @override
  TextStyle? get searchFieldStyle => AppTextStyles.style14.copyWith();

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

  late final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

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
    final myTheme = Theme.of(context).extension<ThemeClass>()!;
    return BlocBuilder<HomleCubit, HomleState>(
      builder: (context, state) {
        if (state is HomeLoding && state.driverNoactiveResponse == null) {
          return SizedBox();
        } else if (state is HomleFinish &&
            (state.driverNoactiveResponse == null ||
                state.driverNoactiveResponse!.data.isEmpty)) {
          return Center(child: Text("Ma'lumot topilmadi"));
        } else {
          return AppSmartRefresher(
            onRefresh: () => _onRefresh(context),
            controller: _refreshController,
            onLoading: () => _onLoading(context),
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
                                color: myTheme.globalColor.withValues(
                                  alpha: 0.1,
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: 5.h,
                                horizontal: 6.w,
                              ),
                              child: Text(
                                "${state.driverNoactiveResponse!.meta.total} ta topildi",
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
                      if (state.driverNoactiveResponse != null)
                        SliverList.separated(
                          itemBuilder: (ctx, index) {
                            return TaxisWidget(
                              key: ValueKey(
                                state.driverNoactiveResponse!.data[index].id,
                              ),
                              driverNoactiveModel:
                                  state.driverNoactiveResponse!.data[index],
                              driver: null,
                            );
                          },
                          itemCount: state.driverNoactiveResponse != null
                              ? state.driverNoactiveResponse!.data.length
                              : 0,
                          separatorBuilder: (ctx, index) =>
                              SizedBox(height: 12.h, key: ValueKey(index)),
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

  @override
  Widget buildSuggestions(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;
    return BlocBuilder<HomleCubit, HomleState>(
      builder: (context, state) {
        if (state is HomeLoding) {
          return Center(
            child: CircularProgressIndicator(color: myTheme.globalColor),
          );
        } else {
          return Center(child: Image.asset("assets/img_39.png", width: 150.w));
        }
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
