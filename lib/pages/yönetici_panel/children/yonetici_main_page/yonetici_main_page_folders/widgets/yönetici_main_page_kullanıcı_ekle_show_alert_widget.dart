import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../../core/components/buttons/normal_button.dart';
import '../../../../../../core/components/space_widgets/horizontal_space_widget.dart';
import '../../../../../../core/constants/app_constant_dimensions/app_dimensions.dart';
import '../../../../../../core/extensions/string_extension/string_extension.dart';
import '../../../../../../core/services/sql_insert_service.dart';
import '../../../../../y%C3%B6netici_panel/children/yonetici_main_page/yonetici_main_page_folders/view_modal/yonetici_main_page_view_modal.dart';
import '../../../../../y%C3%B6netici_panel/children/yonetici_main_page/yonetici_main_page_folders/widgets/yonetici_main_page_custom_text_form_field.dart';

class YoneticiMainPageKullaniciEkleShowDialogWidget extends StatelessWidget {
  const YoneticiMainPageKullaniciEkleShowDialogWidget({required YoneticiMainPageViewModal state, super.key}) : _state = state;

  final YoneticiMainPageViewModal _state;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      content: SizedBox(
        width: MediaQuery.of(context).size.width * .3,
        height: MediaQuery.of(context).size.height * .7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _horizontalNormalSpaceWidget(),
            Text(_state.strings.title),
            _horizontalLargeSpaceWidget(),
            YoneticiMainPageCustomTextFormField(
                textCtrl: _state.kullaniciNameCtrl,
                hintText: _state.strings.kullaniciNameHinetText,
                onChanged: (value) {
                  _state.kayitButtonState();
                  _state.resetButtonState();
                }),
            _horizontalLargeSpaceWidget(),
            YoneticiMainPageCustomTextFormField(
                textCtrl: _state.kullaniciLastNameCtrl,
                hintText: _state.strings.kullaniciLastNameHinetText,
                onChanged: (value) {
                  _state.kayitButtonState();
                  _state.resetButtonState();
                }),
            _horizontalLargeSpaceWidget(),
            _dropDownButtonWidget(state: _state),
            _horizontalNormalSpaceWidget(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Observer(builder: (_) {
                  return NormalButton(
                    onPressed: _state.isReadReset
                        ? () {
                            _state.resetText();
                            _state.resetButtonState();
                            _state.kayitButtonState();
                          }
                        : null,
                    child: Text(_state.strings.alertButtonText1),
                  );
                }),
                Observer(builder: (_) {
                  return NormalButton(
                    onPressed: _state.isReadyKayit
                        ? () async {
                            
                            await SqlInsertService.insertKullanici(_state.kullaniciNameCtrl.text, _state.kullaniciLastNameCtrl.text,_state.currentKullanici.toSqlTableName);
                          }
                        : null,
                    child: Text(_state.strings.alertButtonText2),
                  );
                }),
              ],
            )
          ],
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstantsDimensions.appRadiusMedium)),
    );
  }

  HorizontalSpaceWidget _horizontalLargeSpaceWidget() => const HorizontalSpaceWidget(widget: AppConstantsDimensions.appSpaceLarge);

  HorizontalSpaceWidget _horizontalNormalSpaceWidget() => const HorizontalSpaceWidget(widget: AppConstantsDimensions.appSpaceNormal);
}

class _dropDownButtonWidget extends StatefulWidget {
  const _dropDownButtonWidget({
    required YoneticiMainPageViewModal state,
    super.key,
  }): _state = state;
  final YoneticiMainPageViewModal _state;
  @override
  State<_dropDownButtonWidget> createState() => _dropDownButtonWidgetState();
}

class _dropDownButtonWidgetState extends State<_dropDownButtonWidget> {

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isExpanded: true,
      underline: const SizedBox(),
      value:widget._state.currentKullanici,
      items: [
        DropdownMenuItem(
          value:widget._state.kullaniciList[0],
          child: Text(widget._state.kullaniciList[0])
        ),
        DropdownMenuItem(
         value:widget._state.kullaniciList[1],
          child: Text(widget._state.kullaniciList[1])
        ),
      ],
      onChanged: (value) {
        setState(() {
             widget._state.changeStateKullanici(value!);
        });
      },
    );
  }
}
