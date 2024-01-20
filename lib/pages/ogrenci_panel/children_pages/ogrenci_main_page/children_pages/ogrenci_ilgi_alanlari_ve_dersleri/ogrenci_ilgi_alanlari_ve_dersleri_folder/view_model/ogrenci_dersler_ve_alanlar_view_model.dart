import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../../../../../core/enums/sql_table_names_enum.dart';
import '../../../../../../../../core/services/sql_select_service.dart';

part 'ogrenci_dersler_ve_alanlar_view_model.g.dart';

class OgrenciIlgiAlanlariVeDersleriViewModel = _OgrenciIlgiAlanlariVeDersleriViewModelBase with _$OgrenciIlgiAlanlariVeDersleriViewModel;

abstract class _OgrenciIlgiAlanlariVeDersleriViewModelBase with Store {
  List<Map<String, dynamic>> ogrenciDersData = [];
  List<List<dynamic>> ogrenciIlgiAlanlariData = [];

  @observable
  bool _isDersLoading = false;

  @observable
  bool _isIlgiAlanlariLoading = false;

  bool get isDerslerLoading => _isDersLoading;
  bool get isIlgiAlanlariLoading => _isIlgiAlanlariLoading;

  @action
  Future<void> getDersData(int ogrenciId, List<int> dersId) async {
    _isDersLoading = true;
    List<Map<String, dynamic>> ogrenciDersDataList = [];
    debugPrint("dersIdList.length => ${dersId.length}");
    for (final id in dersId) {
      final dersData = await SqlSelectService.getUser(id, SqlTableName.dersler);
      final hocaAd = await SqlSelectService.getOgrenciTalepDersInfo(ogrenciId, id);

      ogrenciDersDataList.add({"dersData": dersData, "hocaAd": hocaAd["hocaAd"],"hocaData":hocaAd["hocaData"]});
    }
    debugPrint("ogrenciDersData => $ogrenciDersDataList");
    ogrenciDersData = ogrenciDersDataList;
    _isDersLoading = false;
  }

  @action
  Future<void> getIlgiAlanlariData(List<int> ilgiAlanlariId) async {
    _isIlgiAlanlariLoading = true;
    for (final id in ilgiAlanlariId) {
      final tmp = await SqlSelectService.getUser(id, SqlTableName.ilgiAlanlari);
      ogrenciIlgiAlanlariData.add(tmp);
    }
    _isIlgiAlanlariLoading = false;
  }
}
