import 'package:flutter/material.dart';

import '../../constants/app_constant_dimensions/app_dimensions.dart';

class NormalTextFormField extends StatelessWidget {
  const NormalTextFormField(
      {required String hintText,
      Widget? prefixIcon,
      String Function(String? value)? validator,
      void Function(String? value)? onChanged,
      required TextEditingController textEditingController,
      super.key})
      : _hintText = hintText,
        _prefixIcon = prefixIcon,
        _validator = validator,
        _onChange = onChanged,
        _textEditingController = textEditingController;
  final String _hintText;
  final Widget? _prefixIcon;
  final String Function(String? value)? _validator;
  final void Function(String? value)? _onChange;
  final TextEditingController _textEditingController;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .3,
      height:AppConstantsDimensions.appWidgetHeight,
      child: TextFormField(
        controller: _textEditingController,
        onChanged: _onChange,
        validator: _validator,
        decoration: InputDecoration(
          hintText: _hintText,
          prefixIcon: _prefixIcon,
        ),
      ),
    );
  }
}
