
import 'package:mobx/mobx.dart';

import '../../../../../../../../core/services/sql_select_service.dart';

part 'ayarlar_page_view_modal.g.dart';

class AyarlarPageViewModal = _AyarlarPageViewModalBase with _$AyarlarPageViewModal;

abstract class _AyarlarPageViewModalBase with Store {
  
 List<Map<String , dynamic>> _ilgiAlanlariListesi = [];
 List<Map<String , dynamic>> _derslerListesi = [];


  @observable
  bool _isLoadingIlgiAlanlariListesi = false;
  
  @observable
  bool _isLoadingDerslerListesi = false;

  bool get isLoadingIlgiAlanlariListesi => _isLoadingIlgiAlanlariListesi;
  List<Map<String , dynamic>> get ilgiAlanlariListesi => _ilgiAlanlariListesi;
  bool get isLoadingDerslerListesi => _isLoadingDerslerListesi;
  List<Map<String , dynamic>> get derslerListesi => _derslerListesi;


  
   Future <void> getAllIlgiAlanlari() async
  {
             _isLoadingIlgiAlanlariListesi = true;
             _ilgiAlanlariListesi = await SqlSelectService.getAllIlgiAlani();
              _isLoadingIlgiAlanlariListesi = false;

  }
  
  Future <void> getAllDersler() async
  {
             _isLoadingDerslerListesi = true;
             _derslerListesi = await SqlSelectService.getAllDersler();
              _isLoadingDerslerListesi = false;

  }


}