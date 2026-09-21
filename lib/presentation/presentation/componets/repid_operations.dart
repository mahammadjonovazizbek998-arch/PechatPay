
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/style/text_form_style.dart';
import '../../../data/style/text_style.dart';
import '../../../data/theme/theme_class.dart';
import 'list_tile.dart';

class Repidoperations extends StatefulWidget {
  const Repidoperations({super.key});

  @override
  State<Repidoperations> createState() => _RepidoperationsState();
}

class _RepidoperationsState extends State<Repidoperations> {
  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;

    return  Column(children: [
      Container(
        decoration: AppTextFormStyle.container(
          color: myTheme.unselctedCardColor.withValues(
            alpha: 0.7,
          ),
        ),
        child:  ListTileWidget(peding: true,
          selected: Text(
            "Tashrif qayd qilish",
            style: AppTextStyles.style16.copyWith(
              color: myTheme.text,
              fontWeight: .w900,
            ),
          ),
          unselected: Text(
            "Avtomatik +1 muhr qo'shiladi",
            style: AppTextStyles.style12.copyWith(
              color: myTheme.text.withValues(alpha: 0.9),
            ),
          ),

          leading:ContainerWidget(
            vertical: 46.h,
            horizontal: 44.w,
            assets: "assets/img_25.png",
            assetsHorizontal: 16.75,
            assetsVertical: 17.5,
            assetsColor: myTheme.textColor,
            boxDecoration: AppTextFormStyle.container(
              color: myTheme.phonColor,
            ),
          ),
          trailing: Column(
            mainAxisAlignment: .center,
            crossAxisAlignment: .end,
            children: [
              Text(
                "1 ta muhr",
                style: AppTextStyles.style16.copyWith(
                  color: myTheme.text,
                  fontWeight: .w900,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                "50 000 so'm",
                style: AppTextStyles.style12.copyWith(
                  color: myTheme.text.withValues(alpha: 0.9),
                ),
              ),
            ],
          ),
        ),
      ),
      SizedBox(height: 12.h,),
      SizedBox(
        height: 48.h,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          style: AppTextFormStyle.buttonStyleBorder(
            background: myTheme.phonColor,
            foreground: myTheme.textColor,
          ),
          onPressed: () {},
          child: Row(
            mainAxisSize: .min,
            children: [
              Image.asset("assets/img_26.png",width: 16.75.w,height: 17.5,),
              Text(
                " Haydovchini tahrirlash",
                style: AppTextStyles.style14,
              ),
            ],
          ),
        ),
      ),
      SizedBox(height: 12.h,),
    ],);
  }
}
