import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pechat_pay/data/style/text_form_style.dart';
import 'package:pechat_pay/data/style/text_style.dart';
import 'package:pechat_pay/logon/tasks/tasks_cubit.dart';

import '../../../data/theme/theme_class.dart';

class FilterButton extends StatefulWidget {
  final Function(String) onFilterSelected;

  const FilterButton({super.key, required this.onFilterSelected});

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  final Map<String, String> filters = {
    'all': 'Barchasi',
    'active': 'Faol',
    'completed': 'Bajarilgan',
    'pending': 'Kutilmoqda',
  };

  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (ctx, state) {
        return PopupMenuButton<String>(color: myTheme.cardColor,
          onSelected: (value) =>
              context.read<TasksCubit>().onTap(state.index, value,state.hidingData,state.rapidOperations,state.selectedIndex),
          itemBuilder: (ctx) => filters.entries
              .map((e) => PopupMenuItem(value: e.key, child: Text(e.value,style: AppTextStyles.style14.copyWith(color: myTheme.text.withValues(alpha: 0.9),
            fontWeight: .w500,))))
              .toList(),
          child: Container(
            decoration: AppTextFormStyle.container(color: myTheme.textColor),
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
                  filters[state.value]??"Barchasi",
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
