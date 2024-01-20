




import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../../../../core/services/sql_select_service.dart';

part 'kullanicilar_listesi_page.g.dart';

class KullanicilarListesiPageViewModal = _KullanicilarListesiPageViewModalBase with _$KullanicilarListesiPageViewModal;

abstract class _KullanicilarListesiPageViewModalBase with Store {
   
  List<Map<String , dynamic>> _ogrenciListesi = [];
  List<Map<String , dynamic>> _hocaListesi = [];
  List<Map<String,dynamic>> _ilgiAlanlari = [];
  List<Map<String,dynamic>> _dersler = [];
  int ? minHocaVerilecekDers ;
  int ? maxHocaVerilecekDers ;
  int ? maxOgrenciAlinacakDers ;
  int ? minOgrenciAlinacakDers ;
  int ? minilgialani ;


  final ScrollController _ogrenciScroll = ScrollController();
  final ScrollController _hocaScroll = ScrollController();

  
  @observable
     bool _isIlgiAlanlariLoading   = false;

  @observable
    bool  _isDerslerLoading  = false;

  @observable
  bool _isLoadingOgrenciListesi = false;

  @observable 
  bool _isLoadingHocaListesi = false;


  bool get isLoadingOgremciListesi => _isLoadingOgrenciListesi;
  bool get isLoadingHocaListesi => _isLoadingHocaListesi;
  bool  get  isDerslerLoading => _isDerslerLoading;
  bool get isIlgiAlanleriLoading => _isIlgiAlanlariLoading;
  List<Map<String , dynamic>> get hocaListesi => _hocaListesi;
  List<Map<String , dynamic>> get ogrenciListesi => _ogrenciListesi;
  List<Map<String , dynamic>> get ilgiAlanlari => _ilgiAlanlari;
  List<Map<String , dynamic>> get dersler => _dersler;
  ScrollController get ogrenciScroll  => _ogrenciScroll;
  ScrollController get hocaScroll  => _hocaScroll;

   Future<void> getSistemAyarlari() async
   {
       final tmp = await SqlSelectService.getSistemAyarlari();
       minHocaVerilecekDers =int.parse(tmp[2]);
       minOgrenciAlinacakDers = int.parse(tmp[4]);
       minilgialani = int.parse (tmp[1] );
       maxHocaVerilecekDers =int.parse(tmp[3]);
       maxOgrenciAlinacakDers = int.parse(tmp[5]);
   }

   Future <void> getAllOgrenci() async
  {
             _isLoadingOgrenciListesi = true;
             _ogrenciListesi = await SqlSelectService.getAllOgrenci();
              _isLoadingOgrenciListesi = false;

  }
  
   Future <void> getAllHoca() async
  {
             _isLoadingHocaListesi = true;
             _hocaListesi = await SqlSelectService.getAllHoca();
              _isLoadingHocaListesi = false;
  }

  @action
  Future<void> getAllIlgiAlani() async
  {
       _isIlgiAlanlariLoading =true;
       _ilgiAlanlari = await SqlSelectService.getAllIlgiAlani();
        _isIlgiAlanlariLoading =false;
  } 
  

  @action
  Future<void> getAllDersler() async
  {
       _isDerslerLoading =true;
       _dersler = await SqlSelectService.getAllDersler();
       _isDerslerLoading =false;
  } 

}