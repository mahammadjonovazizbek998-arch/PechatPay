import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pechat_pay/presentation/presentation/componets/rating_components/pay_conterin_widget.dart';

import 'all_time_unpaid_pechats.dart';
import 'conterin_widget.dart';

class WeekPeges extends StatefulWidget {
  const WeekPeges({super.key});

  @override
  State<WeekPeges> createState() => _WeekPegesState();
}

class _WeekPegesState extends State<WeekPeges> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(child: ConterinWidget()),
            SizedBox(width: 12.w),
            Flexible(child: PayConterinWidget()),
          ],
        ),

        SizedBox(height: 14.h),

        AllTimeUnpaidPechats(),

        SizedBox(height: 14.h),
      ],
    );
  }
}
