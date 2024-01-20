
import 'package:flutter/material.dart';

class VertcalSpaceWidget extends StatelessWidget {
  const VertcalSpaceWidget({required double widget,super.key}):_widget = widget;
  final double _widget;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
       width:_widget,
    );
  }
}