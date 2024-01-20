

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../../../core/enums/sql_table_names_enum.dart';
import '../../../../core/services/sql_select_service.dart';
import '../../children_pages/hoca_main_page/hoca_main_page_folders/view/hoca_main_page.dart';
import '../../children_pages/hoca_setup_page/view/hoca_setup_page.dart';
import '../constants/hoca_panel_constants_string/hoca_panel_constants_strings.dart';
import '../model/hoca_model.dart';
part 'hocal_panel_view_modal.g.dart';

class HocaPanelViewModal = _HocaPanelViewModalBase with _$HocaPanelViewModal;

abstract class _HocaPanelViewModalBase with Store {

   final HocaPanelConstantsStrings _strings = HocaPanelConstantsStrings.init; 
   
  final TextEditingController _kullaniciController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _newRepeatPasswordController = TextEditingController();

  @observable
  bool _isDone = false;

  @observable
  bool _isReadyReset = false;

  @observable
  bool _isReadyComfirm = false;

  bool get isDone => _isDone;
  bool get isReadyReset => _isReadyReset;
  bool get isReadyComfirm => _isReadyComfirm;

  HocaPanelConstantsStrings get strings => _strings;
  TextEditingController get kullaniciController => _kullaniciController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get newPasswordController => _newPasswordController;
  TextEditingController get newRepeatPasswordController => _newRepeatPasswordController;

  void _changeIsDone(bool currentState) {
    if (_isDone != currentState) {
      _isDone = currentState;
      return;
    }
  }

    
  void _changeStateResetButton(bool value)
  {
          if(_isReadyReset != value)
          {
             _isReadyReset = value;
             return;
          }
  } 
   void _changeStateComfirmButton(bool value)
  {
          if(_isReadyComfirm != value)
          {
             _isReadyComfirm = value;
             return;
          }
  } 

  @action
  void comfirmButtonState()
  {
            if(_newPasswordController.text.length==6 && _newRepeatPasswordController.text.length==6)
            {
               _changeStateComfirmButton(true);   
               return ;
            }
            _changeStateComfirmButton(false);

  }

 @action
  void resetButtonState()
  {
            if(_newPasswordController.text.length==6 || _newRepeatPasswordController.text.length==6)
            {
               _changeStateResetButton(true);   
               return ;
            }
            _changeStateResetButton(false);

  }

  Future<void> toPage(BuildContext context,int id) async
  {
     final boolResult = await SqlSelectService.getUserFirstEntry(id,SqlTableName.hoca);
       if(boolResult)
       {
        final modelList = await SqlSelectService.getUser(id,SqlTableName.hoca);
        final modelDersIdList = await SqlSelectService.getUserDersIdList(id,"hocaid",SqlTableName.hocaDersleri);
        final modelIlgiIdList = await SqlSelectService.getUserIlgiAlanlariIdList(id,"hocaid",SqlTableName.hocaIlgiAlanlari);
        final model =   HocaModel.fromListToModel(modelList);
        model.hocaIlgiAlanlariId = modelIlgiIdList;
        model.hocaDerslerId = modelDersIdList;
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return  HocaMainPage(model:model);
      },));
      return ;
       } 
       Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return  HocaSetupPage(id: id);
      },));
      return ;
  }

  void alertResetButton() {
    _newPasswordController.text = "";
    _newRepeatPasswordController.text = "";
  }

  @action
  void changeButtonState() {
    if (_kullaniciController.text.isNotEmpty && _passwordController.text.length == 6) {
      _changeIsDone(true);
      return;
    }
    _changeIsDone(false);
    return;
  }

  void dispose() {
    _strings.dispose();
    _kullaniciController.dispose();
    _passwordController.dispose();
    _newPasswordController.dispose();
    _newRepeatPasswordController.dispose();
  }


}