import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../core/components/buttons/normal_button.dart';
import '../../../../core/components/show_dialog_widgets/normal_show_dialog_alert_widget.dart';
import '../../../../core/components/space_widgets/horizontal_space_widget.dart';
import '../../../../core/components/text_form_field_widgets/normal_text_form_password_field.dart';
import '../../../../core/constants/app_constant_dimensions/app_dimensions.dart';
import '../../../../core/enums/sql_table_names_enum.dart';
import '../../../../core/services/sql_select_service.dart';
import '../../../../core/services/sql_update_service.dart';
import '../view_modal/yonetici_panel_view_modal.dart';

class YoneticiPanelShowAlertWidget extends StatelessWidget {
  const YoneticiPanelShowAlertWidget({required YoneticiPanelViewModal state,super.key}) : _state = state;
  final YoneticiPanelViewModal _state;
 @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      content: SizedBox(
        width: MediaQuery.of(context).size.width * .3,
        height: MediaQuery.of(context).size.height * .5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _horizontalNormalSpaceWidget(),
            Text(_state.strings.alertTitle),
            _horizontalLargeSpaceWidget(),
            NormalTextFormPasswordField(
              hintText: _state.strings.newPasswordTextFieldHintText,
              textEditingController: _state.newPasswordController,
              onChanged: (value) {
                _state.resetButtonState();
                _state.comfirmButtonState();
              },
            ),
            _horizontalLargeSpaceWidget(),
            NormalTextFormPasswordField(
              hintText: _state.strings.newRepeatPasswordTextFieldHintText,
              textEditingController: _state.newRepeatPasswordController,
              onChanged: (value) {
                _state.resetButtonState();
                _state.comfirmButtonState();
              },
            ),
            _horizontalLargeSpaceWidget(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Observer(builder: (_) {
                  return NormalButton(
                    onPressed: _state.isReadyReset
                        ? () {
                          Navigator.of(context).pop();
                            _state.alertResetButton();
                            _state.resetButtonState();
                            _state.comfirmButtonState();
                          }
                        : null,
                    child: Text(_state.strings.alertButtonText1),
                  );
                }),
                Observer(builder: (_) {
                  return NormalButton(
                    onPressed: _state.isReadyComfirm ? () async{
                         if(_state.newPasswordController.text == _state.newRepeatPasswordController.text)
                             {
                                
                       final idResult = await SqlSelectService.getUserId(_state.kullaniciController.text,SqlTableName.yonetici);
                     await SqlUpdateService.updateKullaniciSifre(idResult,_state.newPasswordController.text,SqlTableName.yonetici);
                           Navigator.of(context).pop();
                            _state.alertResetButton();
                            _state.resetButtonState();
                            _state.comfirmButtonState();
                             }
                            else{
                               showDialog(context: context, builder: (context) {
                             return  const ShowDialogAlertWidget(title:"Bilgilendirme !!!", contentText:"İki Sifre Eşleşmiyor. Tekrar Deneyebilirsiniz");
                                
                              },);
                            }

                    } : null,
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
