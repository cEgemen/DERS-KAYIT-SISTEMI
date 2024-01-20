import 'package:flutter/material.dart';
import '../../../../core/components/text_form_field_widgets/normal_text_form_password_field.dart';
import '../view_model/hocal_panel_view_modal.dart';

class HocaPanelCustomPasswordTextFormField extends StatelessWidget {
  const HocaPanelCustomPasswordTextFormField({required HocaPanelViewModal state, required void Function(String? value) onChanged, super.key})
      : _state = state,
        _onChange = onChanged;
  final HocaPanelViewModal _state;
  final void Function(String? value) _onChange;
  @override
  Widget build(BuildContext context) {
    return NormalTextFormPasswordField(
        onChanged: _onChange, hintText: _state.strings.passwordTextFieldHintText, textEditingController: _state.passwordController);
  }
}
