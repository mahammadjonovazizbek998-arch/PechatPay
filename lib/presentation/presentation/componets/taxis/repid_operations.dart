import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pechat_pay/data/repository/auth.dart';
import 'package:pechat_pay/logon/home/homle_cubit.dart';
import 'package:pechat_pay/logon/tasks/tasks_cubit.dart';

import '../../../../data/style/text_form_style.dart';
import '../../../../data/style/text_style.dart';
import '../../../../data/theme/theme_class.dart';
import '../dialog/stamp_dialog.dart';
import '../list_tile.dart';

class Repidoperations extends StatefulWidget {
  final int id;

  const Repidoperations({super.key, required this.id});

  @override
  State<Repidoperations> createState() => _RepidoperationsState();
}

class _RepidoperationsState extends State<Repidoperations> {
  bool _isRequesting = false; // So'rov holati

  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, tasksState) {
        return Column(
          children: [
            GestureDetector(
              onTap: () =>
                  context.read<TasksCubit>().onTap(
                    tasksState.index,
                    tasksState.value,
                    tasksState.hidingData,
                    tasksState.rapidOperations,
                    tasksState.selectedIndex,
                    true,
                  ),
              child: Container(
                decoration: AppTextFormStyle.container(
                  borderColor: tasksState.type
                      ? myTheme.phonColor.withValues(alpha: 0.8)
                      : Colors.transparent,
                  color: tasksState.type
                      ? myTheme.phonColor.withValues(alpha: 0.07)
                      : myTheme.unselctedColor.withValues(alpha: 0.07),
                ),
                child: ListTileWidget(
                  peding: true,
                  selected: Text(
                    "Nasiya muhr",
                    style: AppTextStyles.style15.copyWith(
                      color: myTheme.text,
                      fontWeight: .w900,
                    ),
                  ),
                  unselected: Text(
                    "Balansga +1 qo'shiladi (keyinroq naqdlashtiriladi)",
                    style: AppTextStyles.style12.copyWith(
                      color: myTheme.text.withValues(alpha: 0.9),
                    ),
                  ),

                  leading1: DecoratedBox(
                    decoration: AppTextFormStyle.container(
                      borderColor: tasksState.type
                          ? Colors.transparent
                          : myTheme.text,
                      color: !tasksState.type
                          ? myTheme.textColor
                          : myTheme.phonColor,
                    ),
                    child: CircleAvatar(
                      radius: 8.r,
                      backgroundColor: !tasksState.type
                          ? myTheme.textColor
                          : myTheme.phonColor,
                    ),
                  ),
                  trailing: Column(
                    mainAxisAlignment: .center,
                    crossAxisAlignment: .end,
                    children: [
                      Text(
                        "+1 muhr",
                        style: AppTextStyles.style15.copyWith(
                          color: myTheme.phonColor,
                          fontWeight: .w900,
                        ),
                      ),
                    ],
                  ),
                  leading: null,
                ),
              ),
            ),
            SizedBox(height: 12.h),
            GestureDetector(
              onTap: () =>
                  context.read<TasksCubit>().onTap(
                    tasksState.index,
                    tasksState.value,
                    tasksState.hidingData,
                    tasksState.rapidOperations,
                    tasksState.selectedIndex,
                    false,
                  ),
              child: Container(
                decoration: AppTextFormStyle.container(
                  borderColor: tasksState.type
                      ? Colors.transparent
                      : myTheme.phonColor.withValues(alpha: 0.8),
                  color: tasksState.type
                      ? myTheme.unselctedColor.withValues(alpha: 0.07)
                      : myTheme.phonColor.withValues(alpha: 0.07),
                ),
                child: ListTileWidget(
                  peding: true,
                  selected: Text(
                    "Darhol naqd to'lash",
                    style: AppTextStyles.style15.copyWith(
                      color: myTheme.text,
                      fontWeight: .w900,
                    ),
                  ),
                  unselected: Text(
                    "1 muhr hisoblanib, shu zahoti qo'lga beriladi",
                    style: AppTextStyles.style12.copyWith(
                      color: myTheme.text.withValues(alpha: 0.9),
                    ),
                  ),

                  leading1: DecoratedBox(
                    decoration: AppTextFormStyle.container(
                      borderColor: !tasksState.type
                          ? Colors.transparent
                          : myTheme.text,
                      color: tasksState.type ? myTheme.textColor : myTheme.phonColor,
                    ),
                    child: CircleAvatar(
                      radius: 8.r,
                      backgroundColor: tasksState.type
                          ? myTheme.textColor
                          : myTheme.phonColor,
                    ),
                  ),
                  trailing: Column(
                    mainAxisAlignment: .center,
                    crossAxisAlignment: .end,
                    children: [
                      Text(
                        "${AuthRepository.formatSum(tasksState.driverDetailData?.pechatSumma.toString() ?? "0")} so'm",
                        style: AppTextStyles.style15.copyWith(
                          color: myTheme.phonColor,
                          fontWeight: .w900,
                        ),
                      ),
                    ],
                  ),
                  leading: null,
                ),
              ),
            ),
            SizedBox(height: 12.h),
            SizedBox(
              height: 48.h,
              width: MediaQuery.of(context).size.width,
              child: BlocConsumer<HomleCubit, HomleState>(
                listener: (context, homeState) {
                  if (_isRequesting && homeState is HomleFinish && homeState.pechatCreateResponse != null) {
                    setState(() {
                      _isRequesting = false;
                    });
                    showDialog(
                      context: context,
                      builder: (_) => StampDialog(response: homeState.pechatCreateResponse!),
                      barrierDismissible: false,
                    ).then((_) {
                      if (context.mounted) {
                        context.read<TasksCubit>().show(widget.id, 1);
                        context.read<HomleCubit>().resetPechatResponse();
                      }
                    });
                  } else if (_isRequesting && homeState is HomeError) {
                    setState(() {
                      _isRequesting = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          homeState.tokenErorrModel.message ?? "Xatolik yuz berdi",
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                builder: (context, homeState) {
                  return ElevatedButton(
                    style: AppTextFormStyle.buttonStyleBorder(
                      background: myTheme.phonColor,
                      foreground: myTheme.textColor,
                    ),
                    onPressed: () {
                      setState(() {
                        _isRequesting = true;
                      });
                      context.read<HomleCubit>().pechat(
                            widget.id,
                            tasksState.type ? "nasiya" : "naqt",
                          );
                    },
                    child: (homeState is HomeLoding && _isRequesting)
                        ? SizedBox(
                            width: 20.w,
                            height: 20.w,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: myTheme.textColor,
                            ),
                          )
                        : Row(
                            mainAxisSize: .min,
                            children: [
                              Image.asset(
                                "assets/img_26.png",
                                width: 16.75.w,
                                height: 17.5.h,
                                color: myTheme.textColor,
                              ),
                              Text(
                                " Muhr berish",
                                style: AppTextStyles.style14,
                              ),
                            ],
                          ),
                  );
                },
              ),
            ),
            SizedBox(height: 12.h),
          ],
        );
      },
    );
  }
}
