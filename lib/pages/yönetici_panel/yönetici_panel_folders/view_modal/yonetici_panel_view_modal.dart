import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../y%C3%B6netici_panel/children/yonetici_main_page/yonetici_main_page_folders/view/yonetici_main_page.dart';
import '../../../y%C3%B6netici_panel/y%C3%B6netici_panel_folders/constants/yontici_panel_constants_strings/yonetici_panel_constants_strings.dart';

part 'yonetici_panel_view_modal.g.dart';

class YoneticiPanelViewModal = _YoneticiPanelViewModalBase with _$YoneticiPanelViewModal;

abstract class _YoneticiPanelViewModalBase with Store {
   final YoneticiPanelConstantsStrings _strings = YoneticiPanelConstantsStrings.init;
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

  YoneticiPanelConstantsStrings get strings => _strings;
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
  
  void toYoneticiMainPage(BuildContext context)
  {
     Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return  YoneticiMainPage(); 
     },));
  }
  
  void dispose() {
    _strings.dispose();
    _kullaniciController.dispose();
    _passwordController.dispose();
    _newPasswordController.dispose();
    _newRepeatPasswordController.dispose();
  }
}