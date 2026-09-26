import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pechat_pay/logon/tasks/tasks_cubit.dart';

import '../../../../data/style/text_form_style.dart';
import '../../../../data/style/text_style.dart';
import '../../../../data/theme/theme_class.dart';

class Cash extends StatefulWidget {
  const Cash({super.key});

  @override
  State<Cash> createState() => _CashState();
}

class _CashState extends State<Cash> {
  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (BuildContext context, state) {
        return Column(
          children: [
            Container(
              padding: .symmetric(horizontal: 12.w, vertical: 18.h),
              decoration: AppTextFormStyle.container(
                color:  myTheme.unselctedColor.withValues(alpha: 0.09),
              ),
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text(
                    "Yechib olinadigan\nmuhr:",
                    style: AppTextStyles.style12.copyWith(
                      color: myTheme.text.withValues(alpha: 0.9),
                    ),
                  ),
                  Container(
                    padding: .symmetric(horizontal: 6.w, vertical: 6.h),
                    width: 140.w,height: 50.h,
                    decoration: AppTextFormStyle.container(
                      color: myTheme.cardColor,
                    ),
                    child: Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        SizedBox(width: 40.w,height: 40.h,
                          child: ElevatedButton(
                            style: AppTextFormStyle.buttonStyleBorder(
                              button: true,
                              padding: null,
                              background: myTheme.unselctedCardColor,

                              foreground: myTheme.text,
                            ),
                            onPressed: () {
                              context.read<TasksCubit>().number(-1);
                            },
                            child: Icon(
                              Icons.remove,
                              size: 18.w,
                              color: myTheme.text,
                            ),
                          ),
                        ),
                        Text(
                          textAlign: .center,
                          state.number.toString(),
                          style: AppTextStyles.style16.copyWith(
                            color: myTheme.text.withValues(alpha: 0.9),
                          ),
                        ),
                        SizedBox(width: 40.w,height: 40.h,
                          child: ElevatedButton(
                            style: AppTextFormStyle.buttonStyleBorder(
                              button: true,
                              padding: null,
                              background: myTheme.unselctedCardColor,

                              foreground: myTheme.text,
                            ),
                            onPressed: () {
                              context.read<TasksCubit>().number(1);
                            },
                            child: Icon(Icons.add, size: 18.w),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            Container(
              padding: .symmetric(horizontal: 12.w, vertical: 18.h),
              decoration: AppTextFormStyle.container(
                color: myTheme.globalColor.withValues(alpha: 0.07),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Text(
                        "Formula bo'yicha:",
                        style: AppTextStyles.style12.copyWith(
                          color: myTheme.text.withValues(alpha: 0.9),
                        ),
                      ),
                      Text(
                        "${state.number} * muhr",
                        style: AppTextStyles.style14.copyWith(
                          fontWeight: .bold,
                          color: myTheme.text,
                        ),
                      ),
                    ],
                  ),
                  Divider(color: myTheme.unselctedColor.withValues(alpha: 0.2)),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Text(
                        "To'lanadigan summa:",
                        style: AppTextStyles.style14.copyWith(
                          fontWeight: .bold,
                          color: myTheme.text.withValues(alpha: 0.9),
                        ),
                      ),
                      Text(
                        "100000 so'm",
                        style: AppTextStyles.style20.copyWith(
                          fontWeight: .bold,
                          color: myTheme.globalColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            SizedBox(width: MediaQuery.of(context).size.width,
              height: 48.h,
              child: ElevatedButton(
                style: AppTextFormStyle.buttonStyleBorder(
                  button: true,
                  padding: true,
                  background: myTheme.globalColor,
                  foreground: myTheme.textColor,
                ),
                onPressed: () {},
                child: Row(
                  mainAxisSize: .min,
                  children: [
                    Icon(Icons.check, size: 18.w, color: myTheme.textColor),
                    Text(
                      " 100 000 so'm to'lashni tasdiqlash",
                      style: AppTextStyles.style14.copyWith(
                        color: myTheme.textColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
