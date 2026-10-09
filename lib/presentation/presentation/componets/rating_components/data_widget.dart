import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pechat_pay/data/style/text_form_style.dart';
import 'package:pechat_pay/data/style/text_style.dart';
import 'package:pechat_pay/logon/dashboard/dashboard_cubit.dart';
import 'package:pechat_pay/presentation/presentation/componets/taxis/chip_widget.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../data/theme/theme_class.dart';

class DataWidget extends StatefulWidget {
  const DataWidget({super.key});

  @override
  State<DataWidget> createState() => _DataWidgetState();
}

class _DataWidgetState extends State<DataWidget> {
  int itemCount() {
    final state = context.read<DashboardCubit>().state;
    if (state.chip[4].selected) {
      return getDays().length; // Kunlik
    } else if (state.chip[3].selected) {
      return getWeeks().length; // Haftalik
    } else if (state.chip[2].selected) {
      return getMonths().length; // Oylik
    } else if (state.chip[1].selected) {
      return getYears().length; // Yillik
    } else {
      return 0;
    }
  }

  List<String> getMonths() {
    final now = context.read<DashboardCubit>().state.selectedDate;

    return List.generate(12, (index) {
      final date = DateTime(now.year, now.month - index);
      return '${_monthName(date.month)} ${date.year}';
    });
  }

  List<String> getWeeks() {
    final now = context.read<DashboardCubit>().state.selectedDate;
    final date = DateTime(now.year, now.month, now.day);

    final currentWeekStart = date.subtract(Duration(days: date.weekday - 1));

    return List.generate(4, (index) {
      final start = currentWeekStart.subtract(Duration(days: index * 7));
      final end = start.add(const Duration(days: 6));

      return '${start.day}- ${end.day} ${_monthName(end.month)} ${end.year}';
    });
  }

  List<String> getDays() {
    final now = context.read<DashboardCubit>().state.selectedDate;

    return List.generate(7, (index) {
      final date = DateTime(now.year, now.month, now.day - index);

      return '${date.day}-${_monthName(date.month)} ${date.year}';
    });
  }

  List<String> getYears() {
    final year = context.read<DashboardCubit>().state.selectedDate.year;

    return List.generate(5, (index) => '${year - index}');
  }

  String _monthName(int month) {
    const months = [
      'Yanvar',
      'Fevral',
      'Mart',
      'Aprel',
      'May',
      'Iyun',
      'Iyul',
      'Avgust',
      'Sentabr',
      'Oktabr',
      'Noyabr',
      'Dekabr',
    ];

    return months[month - 1];
  }

  String name(int index) {
    final state = context.read<DashboardCubit>().state;
    if (state.chip[4].selected) {
      return getDays()[index];
    } else if (state.chip[3].selected) {
      return getWeeks()[index];
    } else if (state.chip[2].selected) {
      return getMonths()[index];
    } else if (state.chip[1].selected) {
      return getYears()[index];
    } else {
      return "";
    }
  }
  Future<void> _showDatePickerDialog() async {
    final cubit = context.read<DashboardCubit>();
    final state = cubit.state;
    final DateTime selectedDate = state.selectedDate;

    if (state.chip[3].selected) {
      // ---- HAFTA: istalgan kunni bosib, o'sha kun kirgan haftani olish ----
      final DateTime? weekStart = await showDialog<DateTime>(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Haftani tanlang',
                  style: AppTextStyles.style14.copyWith(
                    color: Theme.of(context).extension<ThemeClass>()!.text,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(dialogContext),
                  child: const Icon(Icons.clear_outlined),
                ),
              ],
            ),
            contentPadding: EdgeInsets.all(12.r),
            content: SizedBox(
              width: 320.w,
              height: 360.h,
              child: SfDateRangePicker(
                view: DateRangePickerView.month,
                selectionMode: DateRangePickerSelectionMode.single,
                initialSelectedDate: selectedDate,
                initialDisplayDate: selectedDate,
                minDate: DateTime(1999),
                maxDate: DateTime.now(),
                monthViewSettings: const DateRangePickerMonthViewSettings(
                  firstDayOfWeek: 1,
                ),
                onSelectionChanged: (args) {
                  if (args.value is DateTime) {
                    final DateTime picked = args.value;
                    final start = _mondayOf(picked);
                    Navigator.pop(dialogContext, start);
                  }
                },
              ),
            ),
          );
        },
      );

      if (weekStart != null && mounted) {
        await cubit.selected(0, weekStart);
      }
      return;
    }

    // ---- Oldingi holatlar (decade / year / month) ----
    DateRangePickerView initialView;
    if (state.chip[1].selected) {
      initialView = DateRangePickerView.decade;
    } else if (state.chip[2].selected) {
      initialView = DateRangePickerView.year;
    } else {
      initialView = DateRangePickerView.month;
    }

    final DateTime? result = await showDialog<DateTime>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sanani tanlang',
                style: AppTextStyles.style14.copyWith(
                  color: Theme.of(context).extension<ThemeClass>()!.text,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(dialogContext),
                child: const Icon(Icons.clear_outlined),
              ),
            ],
          ),
          contentPadding: EdgeInsets.all(12.r),
          content: SizedBox(
            width: 320.w,
            height: 360.h,
            child: SfDateRangePicker(
              view: initialView,
              allowViewNavigation: false,
              selectionMode: DateRangePickerSelectionMode.single,
              initialSelectedDate: selectedDate,
              initialDisplayDate: selectedDate,
              minDate: DateTime(1999),
              maxDate: DateTime.now(),
              monthViewSettings: const DateRangePickerMonthViewSettings(
                firstDayOfWeek: 1,
              ),
              onSelectionChanged: (args) {
                if (args.value is DateTime) {
                  Navigator.pop(dialogContext, args.value as DateTime);
                }
              },
            ),
          ),
        );
      },
    );

    if (result != null && mounted) {
      await cubit.selected(0, result);
    }
  }

  /// Berilgan kun turgan haftaning dushanbasi
  DateTime _mondayOf(DateTime d) =>
      DateTime(d.year, d.month, d.day - (d.weekday - 1));
//   Future<void> _showDatePickerDialog() async {
// final cubit = context.read<DashboardCubit>();
// final state = cubit.state;
// final DateTime selectedDate = state.selectedDate;
//
// DateTime? result ;
//     if (state.chip[3].selected) {
// result = await showDialog<DateTime>(
// context: context,
// builder: (_) => WeekPickerDialog(initialDate: selectedDate),
// );
// } else {
//  result=   await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         final state = context.read<DashboardCubit>().state;
//
//         DateRangePickerView initialView;
//         if (state.chip[1].selected) {
//           initialView = DateRangePickerView.decade;
//         } else if (state.chip[2].selected) {
//           initialView = DateRangePickerView.year;
//         }else {
//           initialView = DateRangePickerView.month;
//         }
//         return AlertDialog(
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Sanani tanlang',
//                 style: AppTextStyles.style14.copyWith(
//                   color: Theme.of(context).extension<ThemeClass>()!.text,
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () => Navigator.pop(context),
//                 child: const Icon(Icons.clear_outlined),
//               ),
//             ],
//           ),
//           contentPadding: EdgeInsets.all(12.r),
//           content: SizedBox(
//             width: 320.w,
//             height: 360.h,
//             child: SfDateRangePicker(view: initialView,
//               allowViewNavigation: false,
//               selectionMode: DateRangePickerSelectionMode.single,
//               initialSelectedDate: selectedDate,
//               minDate: DateTime(1999),
//               maxDate: DateTime.now(),
//               monthViewSettings: const DateRangePickerMonthViewSettings(
//                 firstDayOfWeek: 1,
//               ),
//               onSelectionChanged: (args) async {
//                 await context.read<DashboardCubit>().selected(0, args.value);
//                 if (mounted) {
//                   // ignore: use_build_context_synchronously
//                   Navigator.pop(context);
//                 }
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }}

  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        return Container(
          decoration: AppTextFormStyle.container(color: myTheme.textColor),
          padding: .symmetric(vertical: 12.h, horizontal: 12.w),
          child: Column(
            crossAxisAlignment: .start,
            mainAxisAlignment: .center,
            children: [
              Row(
                mainAxisAlignment: .center,
                crossAxisAlignment: .center,
                children: [
                  Container(
                    height: 44.h,
                    width: 242.w,
                    decoration: AppTextFormStyle.container(
                      borderColor: myTheme.text.withValues(alpha: 0.3),
                      color: myTheme.unselctedColor.withValues(alpha: 0.1),
                    ),
                    child: Row(
                      mainAxisAlignment: .spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () =>
                              context.read<DashboardCubit>().selected(
                                state.selectedIndex == 0
                                    ? 0
                                    : state.selectedIndex - 1,
                                null,
                              ),
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: state.selectedIndex != 0
                                ? myTheme.text
                                : myTheme.unselctedColor,
                            size: 15.w,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            maxLines: 1,
                            overflow: .clip,
                            name(state.selectedIndex),
                            style: AppTextStyles.style12.copyWith(
                              color: myTheme.text,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () =>
                              context.read<DashboardCubit>().selected(
                                state.selectedIndex == itemCount() - 1
                                    ? state.selectedIndex
                                    : state.selectedIndex + 1,
                                null,
                              ),
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: state.selectedIndex != itemCount() - 1
                                ? myTheme.text
                                : myTheme.unselctedColor,
                            size: 15.w,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12.w),
                  GestureDetector(
                    onTap: () => _showDatePickerDialog(),
                    child: Container(
                      alignment: .center,
                      width: 80.w,
                      height: 44.h,
                      decoration: AppTextFormStyle.container(
                        borderColor: myTheme.text.withValues(alpha: 0.3),
                        color: myTheme.textColor,
                      ),
                      child: Row(
                        mainAxisAlignment: .center,
                        crossAxisAlignment: .center,
                        mainAxisSize: .min,
                        children: [
                          Icon(
                            Icons.calendar_month_outlined,
                            color: myTheme.globalColor,
                            size: 15.w,
                          ),
                          SizedBox(width: 3.w),
                          Text(
                            "Kalendar",
                            style: AppTextStyles.style12.copyWith(
                              color: myTheme.text,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Divider(color: myTheme.text.withValues(alpha: 0.1)),
              if (state.chip[1].selected != true)
                SizedBox(
                  height: 45.h,
                  child: ListView.separated(
                    scrollDirection: .horizontal,
                    itemCount: itemCount(),
                    itemBuilder: (context, index) {
                      return ChipWidget(
                        name: name(index),
                        isSelected: state.selectedIndex == index,
                        onTap: () => context.read<DashboardCubit>().selected(
                          index,
                          null,
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(width: 8.w);
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
