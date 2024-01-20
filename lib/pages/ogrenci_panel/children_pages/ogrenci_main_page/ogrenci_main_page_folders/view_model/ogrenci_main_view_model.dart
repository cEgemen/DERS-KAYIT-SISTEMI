import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../../../core/enums/sql_table_names_enum.dart';
import '../../../../../../core/services/sql_select_service.dart';

part 'ogrenci_main_view_model.g.dart';

class OgrenciMainViewModel = _OgrenciMainViewModelBase with _$OgrenciMainViewModel;

abstract class _OgrenciMainViewModelBase with Store {
  List<Map<String, dynamic>> _mesajList = [];
  List<List<dynamic>> ogrenciDersData = [];
  List<Map<String,dynamic>> filterHocaData = [];
  List<Map<String,dynamic>> ogrenciTalepData = [];
  List<String> currentHocaDersler = [];
  List<String> currentHocaIlgiAlanlari = [];
  List<Map<String, dynamic>> gelenTalepDataList = [];
  List<Map<String,dynamic>> ogrenciGecmisVeriler = [];
  final TextEditingController _textCtrl = TextEditingController();
  int maxMesajUzunlugu = -1;
  String ogrencifarklihocasecme = "-1";
  String dersSecimDurum = "-2";
  bool isHavePermission = false;
  bool isDersiAlmisMi = false;
  int ogrenciDersTalepSay = -1;
  
  @observable
  bool gecmisVerilerLoading = false;

  @observable
  bool _isOgrenciTalepDataLoading = false;

  @observable
  String _currentSelectButton = "";

  @observable
  bool _isDersLoading = false;

  @observable
  bool _isHaveMessage = false;

  @observable
  bool _isLoadingMessage = false;

  @observable
  bool _isFilterHocaLoading = false;

  @observable
  bool _isCurrentHocaDerslerLoading = false;

  @observable
  bool _isCurrentHocaIlgiAlanlariLoading = false;

  @observable
  bool _isGelenTalepListLoading = false;

  bool get isDerslerLoading => _isDersLoading;
  bool get isHaveMessage => _isHaveMessage;
  bool get isLoadingMessage => _isLoadingMessage;
  bool get isFilterHocaLoading => _isFilterHocaLoading;
  bool get isCurrentHocaDerslerLoading => _isCurrentHocaDerslerLoading;
  bool get isCurrentHocaIlgiAlanlariLoading => _isCurrentHocaIlgiAlanlariLoading;
  bool get isOgrenciTalepDataLoading => _isOgrenciTalepDataLoading;
  bool get isGelenTalepListLoading => _isGelenTalepListLoading; 
  List<Map<String, dynamic>> get mesajList => _mesajList;
  String get currentSelectButton => _currentSelectButton;
  TextEditingController get textCtrl => _textCtrl;

  @action
  void changeStateMessage() {
    if (mesajList.isEmpty) {
      if (_isHaveMessage != false) {
        _isHaveMessage = false;
      }
      return;
    }
    if (_isHaveMessage != true) {
      _isHaveMessage = true;
    }
    return;
  }

  @action
  Future<void> getAllMessage(int userId) async {
    _isLoadingMessage = true;
    _mesajList = await SqlSelectService.getUserMesaj(userId);
    changeStateMessage();
    _isLoadingMessage = false;
  }

  @action
  Future<void> getDersData(List<int> dersId, {String? specialKey}) async {
    _isDersLoading = true;
    List<List> tmpList = [];
    for (final id in dersId) {
      final tmp = await SqlSelectService.getUser(id, SqlTableName.dersler);
      tmpList.add(tmp);
    }
    ogrenciDersData = tmpList;
    _isDersLoading = false;
  }
   
  Future<void> getSistemAyarlari() async
  {
      final sistemAyar = await SqlSelectService.getSistemAyarlari();
      maxMesajUzunlugu =int.parse(sistemAyar[sistemAyar.length-4]);
      dersSecimDurum = sistemAyar[sistemAyar.length-1];
      ogrencifarklihocasecme =sistemAyar[7];
  }

  @action
  Future<void> getAllGecmisVeri(int ogrenciId) async
  {
        gecmisVerilerLoading = true;
        ogrenciGecmisVeriler = await SqlSelectService.getGecmisVeri(ogrenciId);
        gecmisVerilerLoading = false;
  }

  @action
  Future<void> getOgrenciTalepDataList(int id) async
  {
          _isOgrenciTalepDataLoading = true;
               
        ogrenciTalepData = await  SqlSelectService.getOgrenciTalepDataList(id);

          _isOgrenciTalepDataLoading = false;
  }
  
Future<void>  getPermission(int hocaId,int ogrenciId,int dersId) async
{          
        if(ogrencifarklihocasecme=="false")      
           { 
              isHavePermission =  await SqlSelectService.getSpecialHocaCountTalepler(hocaId,ogrenciId);
            }
         isDersiAlmisMi =   await SqlSelectService.getSpecilDersAlindiMi(dersId,ogrenciId);
         final tmp =await SqlSelectService.getOgrenciDersData(ogrenciId,dersId);
         ogrenciDersTalepSay = int.parse(tmp[3]);
} 

  @action
  Future<void> getFilteHocaData(int index, String text) async {
    _isFilterHocaLoading = true;
    debugPrint("text => $text");
    if (index != ogrenciDersData.length) {
      final tmpList1 = await SqlSelectService.getSpecialValue2("dersid", ogrenciDersData[index][0], "hocaid", SqlTableName.hocaDersleri);
      debugPrint("dersi  Veren   Hoca ID  List => => => ${tmpList1.toList()}");
      List<Map<String,dynamic>> tmpList2 = [];
      for (final hocaId in tmpList1) {
        final tmp3Data = await SqlSelectService.getUser(hocaId[0], SqlTableName.hoca);
      debugPrint("dersi  Veren   Hoca  Data List => => => ${tmp3Data.toList()}");
        if (text.isEmpty) {
          tmpList2.add({"dersData":ogrenciDersData[index],"hocaData":tmp3Data});
        } else {
          int count = 0;
          final hocaIlgiAlanlari = await SqlSelectService.getSpecialHocaIlgiAlanlari(hocaId[0]);
          for (final ilgiAlani in hocaIlgiAlanlari) {
            if (text == ilgiAlani) {
              count++;
            }
          }
          if (count != 0) {
          tmpList2.add({"dersData":ogrenciDersData[index],"hocaData":tmp3Data});
          }
        }
      }
       filterHocaData = tmpList2;
    } else {
      List<List<dynamic>> hocaIdList = [];
      List<List<dynamic>> dersDataList = [];
      for (final dersData in ogrenciDersData) {
        final tmpHocaIdList = await SqlSelectService.getSpecialValue2("dersid", dersData[0], "hocaid", SqlTableName.hocaDersleri);
        if(tmpHocaIdList.isNotEmpty)
        {
          dersDataList.add(dersData);
          hocaIdList.add(tmpHocaIdList);
        }
      }
      List<Map<String,dynamic>> tmpList2 = [];
      int index2 = 0;
      for (final hocaList in hocaIdList) {
        
        for (final hocaData in hocaList) {
          debugPrint("Hoca  ID LİST ==> $hocaIdList ");
          debugPrint("Hoca  LİST ==> $hocaList ");
          debugPrint("Hoca  DAta ==> $hocaData ");
          final tmp3Data = await SqlSelectService.getUser(hocaData[0], SqlTableName.hoca);
          debugPrint("dersDataList[index2] => ${dersDataList[index2]}");
          debugPrint("ogrenciDersData[index2] => ${ogrenciDersData[index2]}");

          if (text.isEmpty) {
            tmpList2.add({"dersData":dersDataList[index2],"hocaData":tmp3Data});
          } else {
            int count = 0;
            final hocaIlgiAlanlari = await SqlSelectService.getSpecialHocaIlgiAlanlari(hocaData[0]);
            for (final ilgiAlani in hocaIlgiAlanlari) {
              if (text == ilgiAlani) {
                count++;
              }
            }
            if (count != 0) {
              tmpList2.add({"dersData":dersDataList[index2],"hocaData":tmp3Data});
            }
          }
        }
        index2 ++;
      }
      filterHocaData = tmpList2;
    }
    debugPrint("filterHocaDatas ===>>> $filterHocaData");
    _isFilterHocaLoading = false;
  }

  @action
  Future<void> getCurrentHocaDersler(int id) async {
    _isCurrentHocaDerslerLoading = true;
    currentHocaDersler = await SqlSelectService.getSpecialHocaDersler(id);
    _isCurrentHocaDerslerLoading = false;
  }

  @action
  Future<void> getCurrentHocaIlgiAlanlari(int id) async {
    _isCurrentHocaIlgiAlanlariLoading = true;
    currentHocaIlgiAlanlari = await SqlSelectService.getSpecialHocaIlgiAlanlari(id);
    _isCurrentHocaIlgiAlanlariLoading = false;
  }
 
   @action
  Future<void> getHocaGelenTalepDataList(int id) async {
    _isGelenTalepListLoading = true;
    debugPrint("ogrenci id => $id");
    gelenTalepDataList = await SqlSelectService.getOgrenciTalepOlusturanlarDataList(id);
    debugPrint("gelenTalepDataList => $gelenTalepDataList");
    _isGelenTalepListLoading = false;
  }

  @action
  void changeStateTopButtons(String buttonName) {
    if (_currentSelectButton != buttonName) {
      _currentSelectButton = buttonName;
    }
  }
}
