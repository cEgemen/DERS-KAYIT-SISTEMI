import 'package:flutter/material.dart';

import '../../constants/app_constant_dimensions/app_dimensions.dart';

class NormalTextFormPasswordField extends StatefulWidget {
  const NormalTextFormPasswordField(
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
  State<NormalTextFormPasswordField> createState() => _NormalTextFormPasswordFieldState();
}

class _NormalTextFormPasswordFieldState extends State<NormalTextFormPasswordField> {
  bool _isVisible = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .3,
      height: AppConstantsDimensions.appWidgetHeight,
      child: TextFormField(
        controller: widget._textEditingController,
        onChanged: widget._onChange,
        validator: widget._validator,
        obscureText: _isVisible == true ? false : true,
        decoration: InputDecoration(
            hintText: widget._hintText,
            prefixIcon: widget._prefixIcon,
            suffixIcon: IconButton(
                onPressed: () {
                  changeState();
                },
                icon: Icon(_isVisible == true ? Icons.visibility_off_outlined : Icons.visibility_outlined))),
      ),
    );
  }

  void changeState() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }
}
