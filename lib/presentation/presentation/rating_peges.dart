import 'package:flutter/material.dart';

import 'componets/app_bar_widget.dart';

class RatingPeges extends StatefulWidget {
  const RatingPeges({super.key});

  @override
  State<RatingPeges> createState() => _RatingPegesState();
}

class _RatingPegesState extends State<RatingPeges> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBarWidget(),
        body: Center(child: Text("RatingPeges")));
  }
}
