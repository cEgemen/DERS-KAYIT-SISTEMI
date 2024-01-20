import 'package:flutter/material.dart';

class HorizontalSpaceWidget extends StatelessWidget {
  const HorizontalSpaceWidget({required double widget,super.key}):_widget = widget;
  final double _widget;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
       height:_widget,
    );
  }
}