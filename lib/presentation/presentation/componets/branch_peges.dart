import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/style/text_form_style.dart';
import '../../../data/style/text_style.dart';
import '../../../data/theme/theme_class.dart';
import 'branch_componets.dart';

class BranchPeges extends StatefulWidget {
  const BranchPeges({super.key});

  @override
  State<BranchPeges> createState() => _BranchPegesState();
}

class _BranchPegesState extends State<BranchPeges> {
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
              "Filiallar tarmog'i",
              style: AppTextStyles.style18.copyWith(
                fontWeight: .bold,
                color: myTheme.text,
              ),
            ),
            Text(
              textAlign: .start,
              "PechatPay tizim boshqaruvi",
              style: AppTextStyles.style10.copyWith(
                fontWeight: .w400,
                color: myTheme.text.withValues(alpha: 0.9),
              ),
            ),
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: .symmetric(horizontal: 16.w, vertical: 16.h),
            sliver: SliverMainAxisGroup(
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 48.h,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: AppTextFormStyle.buttonStyleBorder(
                        background: myTheme.globalColor,
                        foreground: myTheme.textColor,
                      ),
                      onPressed: () {},
                      child: Row(
                        mainAxisSize: .min,
                        children: [
                          Icon(Icons.add, size: 18.w),
                          Text(
                            " Yangi filial qo'shish",
                            style: AppTextStyles.style14,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 12.h)),
                SliverToBoxAdapter(
                  child: Text(
                    "MAVJUD FILIALLAR RO'YXATI",
                    style: AppTextStyles.style12.copyWith(
                      color: myTheme.text.withValues(alpha: 0.9),
                      fontWeight: .w500,
                    ),
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 12.h)),
                SliverList.separated(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return BranchComponets(myBranch: true,isacctiv: true,);
                    } else {
                      return BranchComponets(myBranch: true);
                    }
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 12.h);
                  },
                ),
                SliverToBoxAdapter(child: SizedBox(height: 12.h)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
