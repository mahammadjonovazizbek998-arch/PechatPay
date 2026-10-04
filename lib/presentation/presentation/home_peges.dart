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
    // TODO: implement initState
    super.initState();
    _refreshController = RefreshController(initialRefresh: false);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _refreshController.dispose();
  }
void openSerachBar(BuildContext context){
    showSearch(context: context, delegate: SerarchBar());
}
  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;
    return Scaffold(
      appBar: AppBarWidget(),
      body: BlocBuilder<HomleCubit, HomleState>(
        builder: (context, state) {
          if (state is HomeLoding) {
            return Center(
              child: CircularProgressIndicator(color: myTheme.globalColor),
            );
          } else {
            return SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              controller: _refreshController,
              footer: CustomFooter(
                height: 60,
                builder: (context, mode) {
                  Widget body;
                  if (mode == LoadStatus.idle) {
                    body = Text(
                      "Yana yuklash uchun tepaga torting",
                      style: AppTextStyles.style12.copyWith(
                        color: myTheme.text.withValues(alpha: 0.9),
                        fontWeight: .w500,
                      ),
                    );
                  } else if (mode == LoadStatus.loading) {
                    body = CircularProgressIndicator(
                      strokeWidth: 2,
                      color: myTheme.globalColor,
                    );
                  } else if (mode == LoadStatus.failed) {
                    body = Text(
                      "Xatolik, qayta urinib ko'ring",
                      style: AppTextStyles.style12.copyWith(
                        color: myTheme.text.withValues(alpha: 0.9),
                        fontWeight: .w500,
                      ),
                    );
                  } else if (mode == LoadStatus.canLoading) {
                    body = Text(
                      "Qo'yib yuboring",
                      style: AppTextStyles.style12.copyWith(
                        color: myTheme.text.withValues(alpha: 0.9),
                        fontWeight: .w500,
                      ),
                    );
                  } else {
                    body = const Text("Ma'lumot tugadi");
                  }
                  return SizedBox(height: 60, child: Center(child: body));
                },
              ),
              onRefresh: () async {
                final cubit = context.read<HomleCubit>();
                await cubit.historyHomePage(1);
                _refreshController.refreshCompleted();
                _refreshController.resetNoData();
              },

              onLoading: () async {
                final cubit = context.read<HomleCubit>();
                final model = cubit.state.historyHomePage;

                if (model != null) {
                  if (model.meta.lastPage > model.meta.currentPage) {
                    await cubit.historyHomePage(model.meta.currentPage + 1);
                    _refreshController.loadComplete();
                  } else {
                    _refreshController.loadNoData();
                  }
                } else {
                  _refreshController.loadNoData();
                }
              },
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
                                onTap: ()=>openSerachBar(context),
                              ),
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(child: SizedBox(height: 14.h)),
                        SliverToBoxAdapter(
                          child: BlocBuilder<HomleCubit, HomleState>(
                            builder: (context, state) {
                              return Row(
                                mainAxisAlignment: .spaceBetween,
                                children: [
                                  Text(
                                    "HAYDOVCHILAR RO'YXATI",
                                    style: AppTextStyles.style12.copyWith(
                                      color: myTheme.text.withValues(
                                        alpha: 0.9,
                                      ),
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
                              );
                            },
                          ),
                        ),
                        SliverToBoxAdapter(child: SizedBox(height: 10.h)),
                        SliverList.separated(
                          itemBuilder: (ctx, index) {
                            return TaxisWidget(
                              key: ValueKey(index),
                              driverNoactiveModel: null,
                              driver: state.historyHomePage!.data[index],
                            );
                          },
                          itemCount: state.historyHomePage!=null? state.historyHomePage!.data.length:0,
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
      ),
    );
  }
}
