import 'package:flutter/material.dart';

import '../../../../core/components/text_form_field_widgets/normal_text_form_field.dart';
import '../view_modal/yonetici_panel_view_modal.dart';

class YoneticiPanelCustomTextFormField extends StatelessWidget {
  const YoneticiPanelCustomTextFormField({required YoneticiPanelViewModal state, required void Function(String? value) onChanged, super.key})
      : _state = state,
        _onChanged = onChanged;
  final YoneticiPanelViewModal _state;
  final void Function(String? value) _onChanged;
  @override
  Widget build(BuildContext context) {
    return NormalTextFormField(
        onChanged: _onChanged, hintText: _state.strings.kullaniciTextFieldHintText, textEditingController: _state.kullaniciController);
  }
}
