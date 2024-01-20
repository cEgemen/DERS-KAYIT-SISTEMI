import 'package:flutter/material.dart';
import '../../../../core/components/text_form_field_widgets/normal_text_form_password_field.dart';

import '../view_modal/ogrenci_panel_view_modal.dart';

class OgrenciPanelCustomPasswordTextFormField extends StatelessWidget {
  const OgrenciPanelCustomPasswordTextFormField({required OgrenciPanelViewModal state, required void Function(String? value) onChanged, super.key})
      : _state = state,
        _onChange = onChanged;
  final OgrenciPanelViewModal _state;
  final void Function(String? value) _onChange;
  @override
  Widget build(BuildContext context) {
    return NormalTextFormPasswordField(
        onChanged: _onChange, hintText: _state.strings.passwordTextFieldHintText, textEditingController: _state.passwordController);
  }
}
