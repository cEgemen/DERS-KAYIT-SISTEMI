
import 'package:flutter/material.dart';

import '../../constants/app_constant_dimensions/app_dimensions.dart';

class NormalButton extends StatelessWidget {
  const NormalButton({required Widget child,void Function() ? onPressed,double ? width,Color ? color,super.key}):_child = child,_width = width,_onPressed = onPressed,_color = color;
  final double ? _width;
  final Widget  _child;
  final void Function() ? _onPressed; 
  final Color ? _color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppConstantsDimensions.appWidgetHeight,
      width:_width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: _color ?? Colors.deepPurple.shade200,
          shape:const StadiumBorder()
        ),
        onPressed:_onPressed,
        child:_child),
    );
  }
}
