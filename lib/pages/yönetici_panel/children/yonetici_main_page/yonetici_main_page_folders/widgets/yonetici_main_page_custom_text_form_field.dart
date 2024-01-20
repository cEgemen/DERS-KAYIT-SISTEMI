
import 'package:flutter/material.dart';

import '../../../../../../core/components/text_form_field_widgets/normal_text_form_field.dart';

class YoneticiMainPageCustomTextFormField extends StatelessWidget {
  const YoneticiMainPageCustomTextFormField({required TextEditingController textCtrl,required String hintText ,required void Function(String? value) onChanged, super.key})
      : _textCtrl = textCtrl,_hintText = hintText,
        _onChanged = onChanged;
  final TextEditingController _textCtrl;
  final String _hintText;
  final void Function(String? value) _onChanged;
  @override
  Widget build(BuildContext context) {
    return NormalTextFormField(
        onChanged: _onChanged, hintText:_hintText, textEditingController:_textCtrl);
  }
}