import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../../../../../core/services/sql_insert_service.dart';
import '../../../../../../core/services/sql_update_service.dart';
import '../../../../../../core/enums/sql_table_names_enum.dart';
import '../../../../../../core/services/sql_select_service.dart';
part 'hoca_main_page_view_model.g.dart';

class HocaMainViewModel = _HocaMainViewModelBase with _$HocaMainViewModel;

abstract class _HocaMainViewModelBase with Store {
  List<Map<String, dynamic>> _mesajList = [];
  List<List<dynamic>> hocaDersData = [];
  List<Map<String, dynamic>> hocaTalepOlusturanlarDataList = [];
  List<String> currentOgrenciDersler = [];
  List<String> currentOgrenciIlgiAlanlari = [];
  List<Map<String, dynamic>> dersOnaylananlar = [];
  final TextEditingController _textCtrl = TextEditingController();
  List<Map<String, dynamic>> filterOgrenciData = [];
  List<int> derece = [1,2,3,4,5];
  int maxMesajUzunlugu = -1;
  String ogrencifarklihocasecme = "-1";
  String dersSecimDurum = "-2";
  bool isHavePermission = false;
  bool isDersiAlmisMi = false;
  int ogrenciDersTalepSay = -1;
  
  @observable
  bool _isCurrentOgrenciDerslerLoading = false;

  @observable
  bool _isDersiAlanlarLoading = false;

  @observable
  bool _isCurrentOgrenciIlgiAlanlariLoading = false;

  @observable
  bool _isFilterOgrenciLoading = false;

  @observable
  bool _isHaveMessage = false;

  @observable
  bool _isHocaTalepOlusturanlarListLoading = false;

  @observable
  bool _isDersLoading = false;

  @observable
  String _currentSelectButton = " ";

  bool get isDersloading => _isDersLoading;
  bool get isHaveMessage => _isHaveMessage;
  bool get isHocaTalepOlusturanlarListLoading => _isHocaTalepOlusturanlarListLoading;
  bool get isFilterOgrenciLoading => _isFilterOgrenciLoading;
  bool get isCurrentOgrenciDerslerLoading => _isCurrentOgrenciDerslerLoading;
  bool get isCurrentOgrenciIlgiAlanlariLoading => _isCurrentOgrenciIlgiAlanlariLoading;
  bool get isDersiAlanlarLoading => _isDersiAlanlarLoading;
  String get currentSelectButton => _currentSelectButton;
  List<Map<String, dynamic>> get mesajList => _mesajList;
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

   Future<void> getSistemAyarlari() async
  {
      final sistemAyar = await SqlSelectService.getSistemAyarlari();
      maxMesajUzunlugu =int.parse(sistemAyar[sistemAyar.length-4]);
      dersSecimDurum = sistemAyar[sistemAyar.length-1];
      ogrencifarklihocasecme =sistemAyar[7];
  }

  @action
  Future<void> getOgrenciTalepDataList(int id) async {
    _isHocaTalepOlusturanlarListLoading = true;
    debugPrint("hoca id => $id");
    hocaTalepOlusturanlarDataList = await SqlSelectService.getHocaTalepOlusturanlarDataList(id);
    debugPrint("hocaTalepOlusturanlarDataList => $hocaTalepOlusturanlarDataList");
    _isHocaTalepOlusturanlarListLoading = false;
  }

  @action
  Future<void> getDersData(List<int> dersId, {String? specialKey}) async {
    _isDersLoading = true;
    List<List> tmpList = [];
    for (final id in dersId) {
      final tmp = await SqlSelectService.getUser(id, SqlTableName.dersler);
      tmpList.add(tmp);
    }
    hocaDersData = tmpList;
    _isDersLoading = false;
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
  Future<void> getFilteOgrenciData(int index, String text) async {
    _isFilterOgrenciLoading = true;
    debugPrint("text => $text");
    if (index != hocaDersData.length) {
      final tmpList1 = await SqlSelectService.getSpecialValue2("dersid", hocaDersData[index][0], "ogrenciid", SqlTableName.ogrenciDersleri);
      List<Map<String, dynamic>> tmpList2 = [];
      for (final ogrenciId in tmpList1) {
        final tmp3Data = await SqlSelectService.getUser(ogrenciId[0], SqlTableName.ogrenci);
        isDersiAlmisMi = await SqlSelectService.getSpecilDersAlindiMi(hocaDersData[index][0],ogrenciId[0]);
     if(!isDersiAlmisMi)
      {  
        if (text.isEmpty) {
          tmpList2.add({"dersData": hocaDersData[index], "ogrenciData": tmp3Data});
        } else {
           final ogrenciGenelNotOrt = await SqlSelectService.getSpecialOgrenciGenelNotOrtalmasi(ogrenciId[0]);
              if (text == "$ogrenciGenelNotOrt") {
              tmpList2.add({"dersData": hocaDersData[index], "ogrenciData": tmp3Data});
              }
        }}
      }
      filterOgrenciData = tmpList2;
    } else {
      List<List<dynamic>> ogrenciIdList = [];
      List<List<dynamic>> dersDataList = [];
      for (final dersData in hocaDersData) {
        final ogrenciId = await SqlSelectService.getSpecialValue2("dersid", dersData[0], "ogrenciid", SqlTableName.ogrenciDersleri);
        if(ogrenciId.isNotEmpty)
      {
         List<List<dynamic>> ogrenciId2 = [];
         for(final ogrenciD in ogrenciId)
         {
             final x  = await SqlSelectService.getSpecilDersAlindiMi(dersData[0],ogrenciD[0]);
             if(!x)
             {
                ogrenciId2.add(ogrenciD);
             } 
         }
          if (ogrenciId2.isNotEmpty) {
          dersDataList.add(dersData);
          ogrenciIdList.add(ogrenciId2);
        }
        }
      }
      List<Map<String, dynamic>> tmpList2 = [];
      int index2 = 0;
      for (final ogrenciList in ogrenciIdList) {
        for (final ogrenciData in ogrenciList) {
          final tmp3Data = await SqlSelectService.getUser(ogrenciData[0], SqlTableName.ogrenci);
          debugPrint("dersDataList[index2] => ${dersDataList[index2]}");
          debugPrint("hocaDersData[index2] => ${hocaDersData[index2]}");

          if (text.isEmpty) {
            tmpList2.add({"dersData": dersDataList[index2], "ogrenciData": tmp3Data});
          } else {
            final ogrenciGenelNotOrt = await SqlSelectService.getSpecialOgrenciGenelNotOrtalmasi(ogrenciData[0]);
              if (text == "$ogrenciGenelNotOrt") {
              tmpList2.add({"dersData": dersDataList[index2], "ogrenciData": tmp3Data});
              }
          }
        }
        index2++;
      }
      filterOgrenciData = tmpList2;
    }
    _isFilterOgrenciLoading = false;
  }

  @action
  Future<void> getDersiOnaylananlarDataList(int id) async {
    _isDersiAlanlarLoading = true;
    List<Map<String, dynamic>> totalDataList = [];
    final ogrenciAndDersIdList = await SqlSelectService.getHocaOgrencileriDataList(id);
    for (final tmpList in ogrenciAndDersIdList) {
      debugPrint("tmpList => $tmpList");
      final ogrenciData = await SqlSelectService.getUser(tmpList[0], SqlTableName.ogrenci);
      debugPrint("ogrenciData => $ogrenciData");
      final ogrenciIlgiAlanData = await SqlSelectService.getSpecialOgrenciIlgiAlanlari(tmpList[0]);
      debugPrint("ogrenciIlgiAlanData => $ogrenciIlgiAlanData");
      final ogrenciDersData = await SqlSelectService.getSpecialOgrenciDersler(tmpList[0]);
      debugPrint("ogrenciDersData => $ogrenciDersData");
      final dersData = await SqlSelectService.getUser(tmpList[1], SqlTableName.dersler);
      debugPrint("dersData => $dersData");
      totalDataList
          .add({"dersData": dersData, "ogrenciData": ogrenciData, "ogrenciIlgiAlanData": ogrenciIlgiAlanData, "ogrenciDersData": ogrenciDersData});
    }
    dersOnaylananlar = totalDataList;
    _isDersiAlanlarLoading = false;
  }

  @action
  Future<void> getAllMessage(int userId) async {
    _mesajList = await SqlSelectService.getUserMesaj(userId);
    if (_mesajList.isNotEmpty) {
      if (_isHaveMessage != true) {
        _isHaveMessage = true;
        return;
      }
    }
    if (_isHaveMessage != false) {
      _isHaveMessage = false;
    }
    return;
  }
   

  Future<void> onaylaButtonUpdate(int index, int id) async {
    debugPrint(
        "index =>> $index hocaTalepOlusturanlarDataList[index][ogrenciData][0] =>>> ${hocaTalepOlusturanlarDataList[index]["ogrenciData"][0]}  hocaTalepOlusturanlarDataList[index][dersData][0] =>> ${hocaTalepOlusturanlarDataList[index]["dersData"][0]}  ");
    await SqlUpdateService.OgrenciTalepTableUpdate(hocaTalepOlusturanlarDataList[index]["talepData"][0], "Onaylandi");
    await SqlInsertService.addOnaylanmisDers(
        id, hocaTalepOlusturanlarDataList[index]["ogrenciData"][0], hocaTalepOlusturanlarDataList[index]["dersData"][0]);   
  }

  Future<void> reddetButtonUpdate(int index, int id) async {
    await SqlUpdateService.OgrenciTalepTableUpdate(hocaTalepOlusturanlarDataList[index]["talepData"][0], "Red Edildi");
  }

  @action
  Future<void> getCurrentOgrenciDersler(int id) async {
    _isCurrentOgrenciDerslerLoading = true;
    currentOgrenciDersler = await SqlSelectService.getSpecialOgrenciDersler(id);
    _isCurrentOgrenciDerslerLoading = false;
  }

  @action
  Future<void> getCurrentOgrenciIlgiAlanlari(int id) async {
    _isCurrentOgrenciIlgiAlanlariLoading = true;
    currentOgrenciIlgiAlanlari = await SqlSelectService.getSpecialOgrenciIlgiAlanlari(id);
    _isCurrentOgrenciIlgiAlanlariLoading = false;
  }

  @action
  void changeStateTopButtons(String buttonName) {
    if (_currentSelectButton != buttonName) {
      _currentSelectButton = buttonName;
    }
  }
}
