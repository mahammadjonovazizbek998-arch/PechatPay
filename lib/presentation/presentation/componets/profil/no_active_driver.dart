import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pechat_pay/logon/profil/profil_cubit.dart';
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
  late final RefreshController _refreshController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sl<ProfilCubit>().noActiveDriver(7, 1);
    _refreshController = RefreshController(initialRefresh: false);
  }

  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;
    return Scaffold(
      appBar: AppBar(
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
      body: BlocBuilder<ProfilCubit, ProfilState>(
        builder: (context, state) {
          if (state is ProfilLoding) {
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
                    body =  Text("Yana yuklash uchun tepaga torting",style: AppTextStyles.style12.copyWith(
                      color: myTheme.text.withValues(
                        alpha: 0.9,
                      ),
                      fontWeight: .w500,
                    ),);
                  } else if (mode == LoadStatus.loading) {
                    body = CircularProgressIndicator(strokeWidth: 2,color: myTheme.globalColor,);
                  } else if (mode == LoadStatus.failed) {
                    body =  Text("Xatolik, qayta urinib ko'ring",style:  AppTextStyles.style12.copyWith(
                      color: myTheme.text.withValues(
                        alpha: 0.9,
                      ),
                      fontWeight: .w500,
                    ),);
                  } else if (mode == LoadStatus.canLoading) {
                    body = Text("Qo'yib yuboring",
                        style: AppTextStyles.style12.copyWith(
                          color: myTheme.text.withValues(
                            alpha: 0.9,
                          ),
                          fontWeight: .w500,
                        ), );
                  } else {
                    body = const Text("Ma'lumot tugadi");
                  }
                  return SizedBox(height: 60, child: Center(child: body));
                },
              ),
              onRefresh: () async {
                final cubit = context.read<ProfilCubit>();
                await cubit.noActiveDriver(
                  int.parse(state.day),
                  1,
                );
                _refreshController.refreshCompleted();
                _refreshController.resetNoData();
              },

              onLoading: () async {
                final cubit = context.read<ProfilCubit>();
                final model = cubit.state.driverNoactiveModel;

                if (model != null) {
                  if (model.meta.lastPage >
                      state.driverNoactiveModel!.meta.currentPage) {
                    await cubit.noActiveDriver(
                      int.parse(state.day),
                      model.meta.currentPage + 1,
                    );
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
                                      "${state.driverNoactiveModel != null
                                          ? state.driverNoactiveModel!.meta
                                          .total
                                          : 0} ta topildi",
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
                                  context.read<ProfilCubit>().noActiveDriver(
                                    int.parse(value),
                                    1,
                                  );
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
      ),
    );
  }
}
