
import 'package:flutter/material.dart';
import 'package:pechat_pay/data/style/text_style.dart';

void showiDalog(String error,BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(error,style: AppTextStyles.style13,),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.red,
    ),
  );
}