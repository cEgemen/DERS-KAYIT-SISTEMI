import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../children_pages/ogrenci_setup_page/view/ogrenci_setup_page.dart';
import '../constants/ogrenci_panel_constants_strings/ogrenci_panel_constants_string.dart';

import '../../../../core/enums/sql_table_names_enum.dart';
import '../../../../core/services/sql_select_service.dart';
import '../../children_pages/ogrenci_main_page/ogrenci_main_page_folders/view/ogrenci_main_page.dart';
import '../model/ogrenci_model.dart';
part 'ogrenci_panel_view_modal.g.dart';

class OgrenciPanelViewModal = _OgrenicPanelViewModalBase with _$OgrenciPanelViewModal;

abstract class _OgrenicPanelViewModalBase with Store {
  final OgrenciPanelConstantsStrings _strings = OgrenciPanelConstantsStrings.init;
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

  OgrenciPanelConstantsStrings get strings => _strings;
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

   Future<void> toPage(BuildContext context,int id) async
  {  
    debugPrint("ogrenci id ==> $id");
     final boolResult = await SqlSelectService.getUserFirstEntry(id,SqlTableName.ogrenci);
    debugPrint("isSetup ==> $boolResult"); 
       if(boolResult)
       {
        final modelList = await SqlSelectService.getUser(id,SqlTableName.ogrenci);
        final modelDersIdList = await SqlSelectService.getUserDersIdList(id,"ogrenciid",SqlTableName.ogrenciDersleri);
        final modelIlgiIdList = await SqlSelectService.getUserIlgiAlanlariIdList(id,"ogrenciid",SqlTableName.ogrenciIlgiAlanlari);
        final model = OgrenciModel.fromListToModel(modelList);
        model.ogrenciIlgiAlanlariId = modelIlgiIdList;
        model.ogrenciDerslerId = modelDersIdList;
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return  OgrenciMainPage(model:model);
      },));
      return ;
       } 
       Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return  OgrenciSetupPage(id: id);
      },));
      return ;
  }

  void dispose() {
    _strings.dispose();
    _kullaniciController.dispose();
    _passwordController.dispose();
    _newPasswordController.dispose();
    _newRepeatPasswordController.dispose();
  }
}
