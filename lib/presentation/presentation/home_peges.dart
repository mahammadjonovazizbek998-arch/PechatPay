import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pechat_pay/logon/home/homle_cubit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../data/style/text_form_style.dart';
import '../../data/style/text_style.dart';
import '../../data/theme/theme_class.dart';
import 'componets/app_bar_widget.dart';
import 'componets/serarch_bar.dart';
import 'componets/smart_refresher_widget.dart';
import 'componets/taxis/taxis_widget.dart';

class HomePeges extends StatefulWidget {
  const HomePeges({super.key});

  @override
  State<HomePeges> createState() => _HomePegesState();
}

class _HomePegesState extends State<HomePeges> {
  late final RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController(initialRefresh: false);
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  void openSerachBar(BuildContext context) {
    showSearch(context: context, delegate: SerarchBar());
  }

  Future<void> _onRefresh() async {
    try {
      await context.read<HomleCubit>().historyHomePage(1);
      _refreshController.refreshCompleted();
      _refreshController.resetNoData();
    } catch (_) {
      _refreshController.refreshFailed();
    }
  }

  bool isLoadingShown = false;

  Future<void> _onLoading() async {
    final cubit = context.read<HomleCubit>();
    final model = cubit.state.historyHomePage;

    if (model == null || model.meta.lastPage <= model.meta.currentPage) {
      _refreshController.loadNoData();
      return;
    }

    try {
      await cubit.historyHomePage(model.meta.currentPage + 1);
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
      body: BlocConsumer<HomleCubit, HomleState>(
        builder: (context, state) {
          if (state is HomeLoding && state.historyHomePage == null) {
            return Center(
              child: CircularProgressIndicator(color: myTheme.globalColor),
            );
          } else if (state.historyHomePage != null) {
            return AppSmartRefresher(
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              controller: _refreshController,
              child: CustomScrollView(
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
                                readOnly: true,
                                showCursor: false,
                                enableInteractiveSelection: false,
                                decoration: AppTextFormStyle.sorchText(
                                  color: myTheme.text.withValues(alpha: 0.9),
                                  text:
                                      "Haydovchi qidirish (ism, tel, davlat raqam)...",
                                  icon: Icon(Icons.search, size: 19.w),
                                ),
                                onTap: () => openSerachBar(context),
                              ),
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(child: SizedBox(height: 14.h)),
                        SliverToBoxAdapter(
                          child: Row(
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
                                  color: myTheme.globalColor.withValues(
                                    alpha: 0.1,
                                  ),
                                ),
                                padding: .symmetric(
                                  vertical: 5.h,
                                  horizontal: 6.w,
                                ),
                                child: Text(
                                  "${state.historyHomePage!.meta.total} ta topildi",
                                  style: AppTextStyles.style12.copyWith(
                                    color: myTheme.globalColor,
                                    fontWeight: .bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SliverToBoxAdapter(child: SizedBox(height: 10.h)),
                        SliverList.separated(
                          itemBuilder: (ctx, index) {
                            return TaxisWidget(
                              key: ValueKey(
                                state.historyHomePage!.data[index].id,
                              ),
                              // ID dan foydalanamiz
                              driverNoactiveModel: null,
                              driver: state.historyHomePage!.data[index],
                            );
                          },
                          itemCount: state.historyHomePage!.data.length,
                          separatorBuilder: (ctx, index) => SizedBox(
                            height: 12.h,
                            key: ValueKey("sep_$index"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Text(
                "Ma'lumot topilmadi",
                style: AppTextStyles.style14.copyWith(color: myTheme.text),
              ),
            );
          }
        },
        listener: (context, state) {
          if (state is HomeLoding && state.historyHomePage != null) {
            if (!isLoadingShown) {
              isLoadingShown = true;
              showDialog(
                context: context,
                barrierDismissible: false,
                barrierColor: Colors.black54,
                useRootNavigator: true,
                builder: (_) => PopScope(
                  canPop: false,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: myTheme.globalColor,
                    ),
                  ),
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
      ),
    );
  }
}
