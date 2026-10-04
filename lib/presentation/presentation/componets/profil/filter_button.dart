import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pechat_pay/data/style/text_form_style.dart';
import 'package:pechat_pay/data/style/text_style.dart';
import 'package:pechat_pay/logon/profil/profil_cubit.dart';
import 'package:pechat_pay/logon/tasks/tasks_cubit.dart';

import '../../../../data/theme/theme_class.dart';

class FilterButton extends StatefulWidget {
  final Function(String) onFilterSelected;

  const FilterButton({super.key, required this.onFilterSelected});

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  final Map<String, String> filters = {
    'name': 'Ism bo‘yicha',
    'car_number': 'Mashina raqami bo‘yicha',
    'phone': 'Telefon bo‘yicha',
    'oldest': 'Eng eski',
    'newest': 'Eng yangi',
    'least_visits': 'Eng kam tashrif',
    'most_visits': 'Eng ko‘p tashrif',
    'oldest_visit': 'Eng eski tashrif',
  };

  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (ctx, state) {
        return PopupMenuButton<String>(
          color: myTheme.cardColor,
          onSelected: (value) => context.read<TasksCubit>().onTap(
            state.index,
            value,
            state.hidingData,
            state.rapidOperations,
            state.selectedIndex,
            state.type,
          ),
          itemBuilder: (ctx) => filters.entries
              .map(
                (e) => PopupMenuItem(
                  value: e.key,
                  child: Text(
                    e.value,
                    style: AppTextStyles.style14.copyWith(
                      color: myTheme.text.withValues(alpha: 0.9),
                      fontWeight: .w500,
                    ),
                  ),
                ),
              )
              .toList(),
          child: Container(
            constraints: BoxConstraints(minWidth: 75.w, maxWidth: 150.w),
            decoration: AppTextFormStyle.container(
              color: myTheme.textColor,
              shadow: true,
            ),
            padding: .symmetric(horizontal: 10.w, vertical: 5.h),

            child: Row(
              mainAxisSize: .min,
              children: [
                Image.asset(
                  "assets/img_19.png",
                  width: 15.w,
                  height: 14.h,
                  color: myTheme.text,
                ),
                SizedBox(width: 3.w),
                Text(
                  maxLines: 1,
                  overflow: .ellipsis,
                  filters[state.value] ?? "Ism bo‘yicha",
                  style: AppTextStyles.style13.copyWith(
                    color: myTheme.text.withValues(alpha: 0.9),
                    fontWeight: .w500,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class NoActiveDriverFilterButton extends StatefulWidget {
  final Function(String) onFilterSelected;

  const NoActiveDriverFilterButton({super.key, required this.onFilterSelected});

  @override
  State<NoActiveDriverFilterButton> createState() =>
      _NoActiveDriverFilterButtonState();
}

class _NoActiveDriverFilterButtonState
    extends State<NoActiveDriverFilterButton> {
  final Map<String, String> filters = {
    '7': '7 kun',
    '15': '15 kun',
    '30': '30 kun',
  };

  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;
    return BlocBuilder<ProfilCubit, ProfilState>(
      builder: (ctx, state) {
        return PopupMenuButton<String>(
          color: myTheme.cardColor,
          onSelected: (value) =>
              context.read<ProfilCubit>().noActiveDriver(int.parse(value), 1),
          itemBuilder: (ctx) => filters.entries
              .map(
                (e) => PopupMenuItem(
                  value: e.key,
                  child: Text(
                    e.value,
                    style: AppTextStyles.style14.copyWith(
                      color: myTheme.text.withValues(alpha: 0.9),
                      fontWeight: .w500,
                    ),
                  ),
                ),
              )
              .toList(),
          child: Container(
            decoration: AppTextFormStyle.container(
              color: myTheme.textColor,
              shadow: true,
            ),
            padding: .symmetric(horizontal: 10.w, vertical: 5.h),

            child: Row(
              children: [
                Image.asset(
                  "assets/img_19.png",
                  width: 15.w,
                  height: 14.h,
                  color: myTheme.text,
                ),
                SizedBox(width: 3.w),
                Text(
                  filters[state.day] ?? "7 kun",
                  style: AppTextStyles.style13.copyWith(
                    color: myTheme.text.withValues(alpha: 0.9),
                    fontWeight: .w500,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
