import 'package:flutter/material.dart';

import '../../../../core/components/text_form_field_widgets/normal_text_form_field.dart';
import '../view_model/hocal_panel_view_modal.dart';

class HocaPanelCustomTextFormField extends StatelessWidget {
  const HocaPanelCustomTextFormField({required HocaPanelViewModal state, required void Function(String? value) onChanged, super.key})
      : _state = state,
        _onChanged = onChanged;
  final HocaPanelViewModal _state;
  final void Function(String? value) _onChanged;
  @override
  Widget build(BuildContext context) {
    return NormalTextFormField(
        onChanged: _onChanged, hintText: _state.strings.kullaniciTextFieldHintText, textEditingController: _state.kullaniciController);
  }
}
