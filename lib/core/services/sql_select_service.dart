import 'package:flutter/material.dart';

import '../../pages/hoca_panel/hoca_panel_folder/model/hoca_model.dart';
import '../../pages/ogrenci_panel/ogrenci_panel_folders/model/ogrenci_model.dart';
import '../../pages/y%C3%B6netici_panel/children/yonetici_main_page/children_pages/ayarlar_page/ayarlar_page_folder/models/dersler_model.dart';
import '../../pages/y%C3%B6netici_panel/children/yonetici_main_page/children_pages/ayarlar_page/ayarlar_page_folder/models/ilgi_alanlari_model.dart';
import '../enums/sql_table_names_enum.dart';
import '../extensions/enums_extensions/sql_table_name_extension.dart';
import '../inits/postgreSql_init/postgreSql_init.dart';

class SqlSelectService {
  static Future<List<List<dynamic>>> userInitialLoginControlled(String name, SqlTableName tableName) async {
    final result = await PostgreSql.connection?.query(
      'SELECT * FROM "${tableName.getSqlTableName}" WHERE ad = @ad AND sifre = @sifre',
      substitutionValues: {'ad': name, "sifre": "-1"},
    );
     if(result!.isEmpty)
     {
      return [];
     }
    return result;
  }

  static Future<String> getUserId(String name, SqlTableName tableName) async {
    final result = await PostgreSql.connection?.query(
      'SELECT id FROM "${tableName.getSqlTableName}" WHERE ad = @ad ',
      substitutionValues: {'ad': name},
    );
    final id = result![0][0].toString();
    return id;
  }
  
  static Future <List<dynamic>> getYoneticiData() async
  {
       final result = await PostgreSql.connection?.query(
      'SELECT * FROM "yoneticitable"'
    );
    return result![0];
  }

  static Future<List<List<dynamic>>> userInitialPanelControlled(String name, String sifre, SqlTableName tableName) async {
    final result = await PostgreSql.connection?.query(
      'SELECT * FROM "${tableName.getSqlTableName}" WHERE ad = @ad AND sifre = @sifre',
      substitutionValues: {'ad': name, "sifre": sifre},
    );
    debugPrint("userInitialPanelControlled ==> $result");
    if (result!.isEmpty) {
      return [];
    }
    return result;
  }

  static Future<List> getSistemAyarlari() async {
    final result = await PostgreSql.connection?.query(
      'SELECT * FROM "sistemayarlartable"',
    );
    return result![0];
  }
  
   static Future<List<Map<String, dynamic>>> getAllDersler() async {
    final result = await PostgreSql.connection?.query('SELECT * FROM "derslertable" ');
    List<Map<String, dynamic>> derslerList = [];
    for (final tmp in result!) {
      final id = tmp[0];
      final derslerData = DerslerModel.entry(tmp);
      derslerList.add({"id": id, "modalData": derslerData});
    }
 
    return derslerList;
  }

   static Future<List<List<dynamic>>> getOgrenciGecmisData(int ogrenciId) async {
    final result = await PostgreSql.connection?.query('SELECT * FROM "ogrencigecmisverilertable" WHERE ogrenciid =@value1 ' , substitutionValues: {"value1":ogrenciId});
    return result!;
  }

     static Future<List<Map<String, dynamic>>> getSpecialAllDersData(List<int> specialDers) async {
    final result = await PostgreSql.connection?.query('SELECT * FROM "derslertable" ');
    List<Map<String, dynamic>> derslerList = [];
    debugPrint("special ders List length ==>>> ${specialDers.length}");
    for (final tmp in result!) {
      for(int specialId in specialDers)
    {  
      if(tmp[0] == specialId)
     {
       final id = tmp[0];
      final derslerData = DerslerModel.entry(tmp);
      derslerList.add({"id": id, "modalData": derslerData});
      break;
      }
      }
    }
        debugPrint("dersler list length ==>>> ${derslerList.length}");
    return derslerList;
  }

 static Future<List<Map<String, dynamic>>> getAllOgrenci() async {
    final result = await PostgreSql.connection?.query('SELECT * FROM "ogrencitable" ');
    List<Map<String, dynamic>> ogrenciList = [];
    for (final tmp in result!) {
      final id = tmp[0];
      debugPrint("getAllOgrenci ogrenciData ==>>> $tmp");
      final ogrenciData = OgrenciModel.entry(tmp);
      final ogrenciDerslerNameData =await getSpecialOgrenciDersler(id);
      final dersData  = await getSpecialOgrenciDerslerData(id);
      final ilgiAlaniNameData = await getSpecialOgrenciIlgiAlanlari(id);
      final ilgiAlaniData = await getSpecialOgrenciIlgiAlanlariData(id);   
            ogrenciList.add({"id": id, "modalData": ogrenciData,"dersNameData":ogrenciDerslerNameData,"dersData":dersData,"ilgiAlaniNameData":ilgiAlaniNameData,"ilgiAlaniData":ilgiAlaniData});
    }

    return ogrenciList;
  }

  static Future<List<Map<String,dynamic>>> getdersHocaOgrenciDataList() async
  {
    List<Map<String,dynamic>> megaDatas = [];
    List<Map<String,dynamic>> allOgrenciDatas = [];
         allOgrenciDatas  =await getAllOgrenci(); 
         debugPrint("allOgrenciDatas ===>> $allOgrenciDatas"); 
     if(allOgrenciDatas.isNotEmpty)
     {
         for(final ogrenciMapData in allOgrenciDatas)
         {
         debugPrint("ogrenciMapData ===>>> $ogrenciMapData"); 
                if(ogrenciMapData["dersData"].isNotEmpty)
                { 
                     for(final ogrenciDersData in ogrenciMapData["dersData"]) 
                      {
         debugPrint("ogrenciDersData ==>>> $ogrenciDersData"); 
                           final specialDersHocaDatas = await getSpecialDersHocaDatas(ogrenciDersData[0]);
         debugPrint("specialDersHocaDatas ==>> $specialDersHocaDatas"); 
                     if(specialDersHocaDatas.isNotEmpty)
                         {
                           megaDatas.add({"dersData":ogrenciDersData,"ogrenciData":ogrenciMapData["modalData"],"hocaData":specialDersHocaDatas});
                         }
                       }
                }
         }         
     }
     debugPrint("mega Data ===>> $megaDatas ");
     return megaDatas;     
  }

   static Future<List<Map<String,dynamic>>> getSpecialDersHocaDatas(int dersid) async
  {
        final tmp = await PostgreSql.connection?.query('SELECT * FROM "hocadersleritable"');
    debugPrint("hoca dersleri tablosu total =>> $tmp ");
     List<Map<String, dynamic>> hocaList = [];
    if(tmp!.isNotEmpty)
    {
      bool isOk =false;
      for(final tmp2 in tmp)
      { 
       /*  debugPrint("hoca ders id => ${tmp2[2]}  AND gelen ders id ==> $dersid"); */
         if(tmp2[2] == dersid)
         {
            isOk = true;
         }
      }
    if(isOk)
    {
        final result = await PostgreSql.connection?.query('SELECT hocaid FROM "hocadersleritable" WHERE dersid = @dersid',substitutionValues:{'dersid': dersid} );
       if(result!.isNotEmpty)
   { 
    for (final t in result) {
      final id = t[0];
      List<dynamic> hocaData = await getUser(id, SqlTableName.hoca);
      hocaList.add({"hocaid":id,"hocaData":hocaData});
    }
    }
    }
}
    return hocaList;
  }

   
  static Future<List<Map<String,dynamic>>> getSpecialDersOgrenciDatas(int dersid) async
  {
         final t = await PostgreSql.connection?.query('SELECT * FROM "ogrencidersleritable"');
         List<Map<String, dynamic>> ogrenciList = [];
    debugPrint("all ogrenci Ders =>> $t");
    if(t!.isNotEmpty)
    {
      bool isOk = false;
        for(final tmp2 in t)
      {
         if(tmp2[2] == dersid)
         {
            isOk = true;
         }
      }
    if(isOk)
    {
        final result = await PostgreSql.connection?.query('SELECT ogrenciid FROM "ogrencidersleritable" WHERE dersid = @dersid',substitutionValues:{'dersid': dersid} );
    for (final tmp in result!) {
      final id = tmp[0];
      List<dynamic> hocaData = await getUser(id, SqlTableName.ogrenci);
      ogrenciList.add({"ogrenciid":id,"ogrenciData":hocaData});
    }}
}
    return ogrenciList;
  }

   static Future<List<Map<String,dynamic>>> getdersHocaOgrenciDataList2() async
  {
              List<Map<String,dynamic>> megaDatas = [];
    List<Map<String,dynamic>> allOgrenciDatas = [];
         allOgrenciDatas  =await getAllOgrenci2(); 
         /* debugPrint("allOgrenciDatas ===>> $allOgrenciDatas");  */
     if(allOgrenciDatas.isNotEmpty)
     {
         for(final ogrenciMapData in allOgrenciDatas)
         {
         debugPrint("ogrenciMapData ===>>> ${ogrenciMapData["modalData"].genelnotort}"); 
                if(ogrenciMapData["dersData"].isNotEmpty)
                { 
                     for(final ogrenciDersData in ogrenciMapData["dersData"]) 
                      {
       /*   debugPrint("ogrenciDersData ==>>> $ogrenciDersData");  */
                           final specialDersHocaDatas = await getSpecialDersHocaDatas(ogrenciDersData[0]);
     /*     debugPrint("specialDersHocaDatas ==>> $specialDersHocaDatas"); */ 
                     if(specialDersHocaDatas.isNotEmpty)
                         {
                           megaDatas.add({"dersData":ogrenciDersData,"ogrenciData":ogrenciMapData["modalData"],"hocaData":specialDersHocaDatas});
                         }
                       }
                }
         }         
     }
     debugPrint("mega Data ===>> $megaDatas ");
     return megaDatas;     
  }
  
  static Future<List<Map<String,dynamic>>> getdersHocaOgrenciDataList3(List<int> atamaYapilacakDersler) async
  {
    List<Map<String,dynamic>> megaDatas = [];
    List<Map<String,dynamic>> allSecilenDersDatas = [];
    allSecilenDersDatas  =await getSpecialAllDersData(atamaYapilacakDersler); 
     if(allSecilenDersDatas.isNotEmpty)
     {
         for(final dersMapData in allSecilenDersDatas)
         {
         debugPrint("dersMapData ===>>>ders ad : ${dersMapData["modalData"].dersadi} ${dersMapData["modalData"].id}"); 
             final specialDersOgrenciDatas = await getSpecialDersOgrenciDatas(dersMapData["modalData"].id);
             final specialDersHocaDatas = await getSpecialDersHocaDatas(dersMapData["modalData"].id);
             if(specialDersOgrenciDatas.isNotEmpty)
             {
                      if(specialDersHocaDatas.isNotEmpty)
                      {
                   megaDatas.add({"dersData":dersMapData,"ogrenciData":specialDersOgrenciDatas,"hocaData":specialDersHocaDatas});
                      }
             }
         }         
     }
     debugPrint("mega Data ===>> $megaDatas ");
     return megaDatas;     
  }
  
  


  static Future<List<Map<String, dynamic>>> getSpecialHocaDatas(int dersId) async {
    final tmp = await PostgreSql.connection?.query('SELECT * FROM "hocadersleritable"');
    debugPrint("allhocaDers =>> $tmp");
     List<Map<String, dynamic>> hocaList = [];
    if(tmp!.isNotEmpty)
    {
      final result = await PostgreSql.connection?.query('SELECT hocaid FROM "hocadersleritable WHERE dersid = @dersid"',substitutionValues:{'dersid': dersId} );
       if(result!.isNotEmpty)
   { 
    for (final t in result) {
      final id = t[0];
      List<dynamic> hocaData = await getUser(id, SqlTableName.hoca);
      hocaList.add({"hocaid":id,"hocaData":hocaData});
    }
    }
}
    return hocaList;
  }


  static Future<List<Map<String, dynamic>>> getSpecialOgrenciDatas(int dersId) async {
     final t = await PostgreSql.connection?.query('SELECT * FROM "ogrencidersleritable"');
         List<Map<String, dynamic>> ogrenciList = [];
    debugPrint("allogrenciDers =>> $t");
    if(t!.isNotEmpty)
    {final result = await PostgreSql.connection?.query('SELECT ogrenciid FROM "ogrencidersleritable WHERE dersid = @dersid"',substitutionValues:{'dersid': dersId} );
    for (final tmp in result!) {
      final id = tmp[0];
      List<dynamic> hocaData = await getUser(id, SqlTableName.ogrenci);
      ogrenciList.add({"ogrenciid":id,"ogrenciData":hocaData});
    }
}
    return ogrenciList;
  }

  static Future<List<Map<String, dynamic>>> getAllOgrenci2() async {
     final result = await PostgreSql.connection?.query('SELECT * FROM "ogrencitable" ORDER BY genelnotort DESC');
    List<Map<String, dynamic>> ogrenciList = [];
    for (final tmp in result!) {
      final id = tmp[0];
      debugPrint("getAllOgrenci ogrenciData ==>>> $tmp");
      final ogrenciData = OgrenciModel.entry(tmp);
      final ogrenciDerslerNameData =await getSpecialOgrenciDersler(id);
      final dersData  = await getSpecialOgrenciDerslerData(id);
      final ilgiAlaniNameData = await getSpecialOgrenciIlgiAlanlari(id);
      final ilgiAlaniData = await getSpecialOgrenciIlgiAlanlariData(id);   
            ogrenciList.add({"id": id, "modalData": ogrenciData,"dersNameData":ogrenciDerslerNameData,"dersData":dersData,"ilgiAlaniNameData":ilgiAlaniNameData,"ilgiAlaniData":ilgiAlaniData});
    }

    return ogrenciList;
  }




 
  static Future<List<Map<String, dynamic>>> getAllHoca() async {
    final result = await PostgreSql.connection?.query('SELECT * FROM "hocatable" ');
    List<Map<String, dynamic>> hocaList = [];
    for (final tmp in result!) {
      final id = tmp[0];
      final hocaData = HocaModel.entry(tmp);
       final hocaDerslerNameData =await getSpecialHocaDersler(id);
      final dersData  = await getSpecialHocaDerslerData(id);  
       final ilgiAlaniNameData = await getSpecialHocaIlgiAlanlari(id);
      final ilgiAlaniData = await getSpecialHocaIlgiAlanlariData(id);  
           hocaList.add({"id": id, "modalData": hocaData,"dersNameData":hocaDerslerNameData,"dersData":dersData,"ilgiAlaniNameData":ilgiAlaniNameData,"ilgiAlaniData":ilgiAlaniData});
    }

    return hocaList;
  }

  


  static Future<List<Map<String, dynamic>>> getAllIlgiAlani() async {
    final result = await PostgreSql.connection?.query('SELECT * FROM "ilgialanlaritable" ');
    List<Map<String, dynamic>> ilgiAlaniList = [];
    for (final tmp in result!) {
      final id = tmp[0];
      final ilgiAlaniData = IlgiAlaniModel.entry(tmp);
      ilgiAlaniList.add({"id": id, "modalData": ilgiAlaniData});
    }

    return ilgiAlaniList;
  }

 
 
   static Future<List<dynamic>> getSistemAyarlariSpecilaValue() async {
    List<List> result = await PostgreSql.connection?.query('SELECT id,derssecimbaslamatarihi,derssecimibitistarihi FROM "sistemayarlartable" ') as List<List> ;
    debugPrint("sistemAyarlarıDataList =>>> ${result[0]}");
    return result[0];
  }

  static Future<List<Map<String, dynamic>>> getAllTalepler() async {
    List<Map<String,dynamic>> gecmisTaleplerDataList = [];
    final resultOgrenciTalep = await PostgreSql.connection?.query('SELECT * FROM "ogrencitaleptable"');
    final resultHocaTalep = await PostgreSql.connection?.query('SELECT * FROM "hocataleptable"');
    for (final tmp in resultOgrenciTalep!) {
      final dersAd =await getSpecialValue("id",tmp[3],"dersadi",SqlTableName.dersler);
      final dersData = await getSpecialOgrenciDersData(tmp[1],tmp[3]);
      final ogrenciAd= await getUser(tmp[1],SqlTableName.ogrenci);
      final hocaAd = await getUser(tmp[2],SqlTableName.hoca);
      gecmisTaleplerDataList.add({"tabloType":"ogrencitaleptable","talepData":tmp,"dersAd":dersAd,"dersData":dersData,"talepteBulunan":"${ogrenciAd[1]} ${ogrenciAd[2]}","talebiAlan":"${hocaAd[1]} ${hocaAd[2]}","hocaData":hocaAd,"ogrenciData":ogrenciAd,});

    }
    for (final tmp in resultHocaTalep!) {
       final dersAd =await getSpecialValue("id",tmp[3],"dersad",SqlTableName.dersler);
      final ogrenciAd= await getUser(tmp[2],SqlTableName.ogrenci);
      final dersData = await getSpecialOgrenciDersData(tmp[2],tmp[3]);
      final hocaAd = await getUser(tmp[1],SqlTableName.hoca);
      gecmisTaleplerDataList.add({"tabloType":"hocataleptable","talepData":tmp,"dersAd":dersAd,"dersData":dersData,"talebiAlan":"${ogrenciAd[1]} ${ogrenciAd[2]}","talepteBulunan":"${hocaAd[1]} ${hocaAd[2]}","hocaData":hocaAd,"ogrenciData":ogrenciAd});
    }
     debugPrint("gecmisTaleplerDataList =>>>> $gecmisTaleplerDataList");
    return gecmisTaleplerDataList;
  }

  static Future<List<dynamic>> getUser(int id, SqlTableName tableName) async {
    final result = await PostgreSql.connection?.query('SELECT * FROM "${tableName.getSqlTableName}" WHERE id = @id', substitutionValues: {'id': id});
    return result![0];
  }

  static Future<bool> getSpecialHocaCountTalepler(int hocaId,int ogrenciId) async
  {
     final result = await PostgreSql.connection?.query('SELECT * FROM "ogrencitaleptable" WHERE ogrenciid =@ogrenciid AND hocaid = @hocaid', substitutionValues: {'hocaid':hocaId,'ogrenciid':ogrenciId});
     debugPrint("getSpecialHocaCountTalepresult ==>=>=>=> $result");
    return result!.isEmpty ? true : false;
  }

   static Future<bool> getSpecilDersAlindiMi(int dersId,int ogrenciId) async
  {
     final result = await PostgreSql.connection?.query('SELECT * FROM "onaylanmisderstable" WHERE ogrenciid =@ogrenciid AND dersid = @dersid', substitutionValues: {'dersid':dersId,'ogrenciid':ogrenciId});
    return result!.isNotEmpty ? true : false;
  }



  static Future<List<List<dynamic>>> getUserMesajDataList(dynamic value,dynamic value2,String filterText ,String filterText2,SqlTableName tableName) async
  {
     final result = await PostgreSql.connection?.query('SELECT * FROM "${tableName.getSqlTableName}" WHERE $filterText = @value AND $filterText2 = @value2 '  , substitutionValues: {'value': value,'value2':value2});
    return result!;
  }

  static Future<List<List<dynamic>>> getUserTalepDataList(dynamic value,dynamic value2,String filterText ,String filterText2,SqlTableName tableName) async
  {
     final result = await PostgreSql.connection?.query('SELECT * FROM "${tableName.getSqlTableName}" WHERE $filterText = @value AND $filterText2 = @value2 '  , substitutionValues: {'value': value,'value2':value2});
    return result!;
  }

   static Future<List<List<dynamic>>> getHocaTalepDataList(dynamic value,dynamic value2,String filterText ,String filterText2) async
  {
     final result = await PostgreSql.connection?.query('SELECT * FROM "hocataleptable" WHERE $filterText = @value AND $filterText2 = @value2 '  , substitutionValues: {'value': value,'value2':value2});
    return result!;
  }
  
  static Future<List<List<dynamic>>> getDersiTalepEdenler(int dersid,int hocaid) async {
    final result = await PostgreSql.connection?.query('SELECT * FROM "ogrenitaleptable" WHERE dersid = @dersid AND hocaid = @hocaid', substitutionValues: {'dersid': dersid,'hocaid':hocaid});
    return result!;
  }

   static Future<List<List<dynamic>>> getDersiIcinMesajAtanlar(String aliciId,int dersid,String filterText,String filterText2) async {
    final result = await PostgreSql.connection?.query('SELECT * FROM "mesajtable" WHERE $filterText2 = @dersid AND $filterText = @aliciid', substitutionValues: { filterText2 : dersid, filterText:aliciId});
    return result!;
  }

  static Future<List<dynamic>> getSpecialValue(String specialFilterText, dynamic id, String specialValueText, SqlTableName tableName) async {
    final result = await PostgreSql.connection
        ?.query('SELECT $specialValueText FROM "${tableName.getSqlTableName}" WHERE $specialFilterText = @id', substitutionValues: {'id': id});
    debugPrint("result => $result");
    return result!.isEmpty ? [] : result[0];
  }
  
  static Future<List<Map<String,dynamic>>> getGecmisVeri(int ogrenciId) async {
    List<Map<String,dynamic>> oldDatas = [];
    final result = await PostgreSql.connection
        ?.query('SELECT * FROM "ogrencigecmisverilertable" WHERE ogrenciid = @ogrenciid', substitutionValues: {'ogrenciid': ogrenciId});
    debugPrint("result => $result");
      if(result!.isNotEmpty)
     {
      for(final gecmisVeri in result)
    {
     final ad = await getSpecialValue("id",gecmisVeri[1],"dersadi",SqlTableName.dersler);
      oldDatas.add({"dersAd":ad[0],"dersData":gecmisVeri});
    } 
    
    }
    return oldDatas;
  }

  static Future<List<List<dynamic>>> getSpecialValue2(String specialFilterText, int id, String specialValueText, SqlTableName tableName) async {
    final result = await PostgreSql.connection
        ?.query('SELECT $specialValueText FROM "${tableName.getSqlTableName}" WHERE $specialFilterText = @id', substitutionValues: {'id': id});
    debugPrint("result => $result");
    return result!.isEmpty ? [] : result;
  }

  static Future<String> getSpecialOgrenciDersTalepSayisi(int ogrenciid,int dersid)
  async{
               final result = await PostgreSql.connection
        ?.query('SELECT * FROM "ogrencidersleritable" WHERE ogrenciid = @ogrenciid AND dersid = @dersid', substitutionValues: {'dersid': dersid,"ogrenciid":ogrenciid});
    debugPrint("result => $result");
    return result![0][3] ;
  }

  static Future<List<String>> getSpecialHocaDersler(int id) async {
    List<String> hocaDersler = [];
    final result = await PostgreSql.connection?.query('SELECT dersid FROM "hocadersleritable" WHERE hocaid= @id', substitutionValues: {'id': id});
   if(result!.isNotEmpty)
   {
     for (final ders in result) {
      debugPrint("dersId => $ders");
      final dersAd = await PostgreSql.connection?.query('SELECT dersadi FROM "derslertable" WHERE id= @id', substitutionValues: {'id': ders[0]});
      debugPrint("dersAdi => $dersAd");
      hocaDersler.add(dersAd!.isEmpty ? [] : dersAd[0][0]);
    }}
    return hocaDersler;
  }
 
 static Future<List<List<dynamic>>> getSpecialHocaDerslerData(int id) async {
    List<List<dynamic>> hocaDersler = [];
    final result =
        await PostgreSql.connection?.query('SELECT dersid FROM "hocadersleritable" WHERE hocaid= @id', substitutionValues: {'id': id});
   if(result!.isNotEmpty)
   { 
    for (final ders in result) {
      debugPrint("dersId => $ders");
      final dersAd = await PostgreSql.connection?.query('SELECT * FROM "derslertable" WHERE id= @id', substitutionValues: {'id': ders[0]});
      debugPrint("dersAdi => $dersAd");
      hocaDersler.add(dersAd!.isEmpty ? [] : dersAd[0]);
    }}
    return hocaDersler;
  }
   
   static Future<List<dynamic>> getOgrenciDersData(int ogrenciId,int dersID)
   async {
              final result =
        await PostgreSql.connection?.query('SELECT * FROM "ogrencidersleritable" WHERE ogrenciid= @ogrenciid AND dersid = @dersid', substitutionValues: {'ogrenciid': ogrenciId,'dersid':dersID});
        return result![0];
   }

  static Future<List<String>> getSpecialOgrenciDersler(int id) async {
    List<String> ogrenciDersler = [];
    final result =
        await PostgreSql.connection?.query('SELECT dersid FROM "ogrencidersleritable" WHERE ogrenciid= @id', substitutionValues: {'id': id});
   if(result!.isNotEmpty)
   { 
    for (final ders in result) {
      debugPrint("dersId => $ders");
      final dersAd = await PostgreSql.connection?.query('SELECT dersadi FROM "derslertable" WHERE id= @id', substitutionValues: {'id': ders[0]});
      debugPrint("dersAdi => $dersAd");
      ogrenciDersler.add(dersAd!.isEmpty ? [] : dersAd[0][0]);
    }}
    return ogrenciDersler;
  }

   static Future<List<List<dynamic>>> getSpecialOgrenciDerslerData(int id) async {
    List<List<dynamic>> ogrenciDersler = [];
    final result =
        await PostgreSql.connection?.query('SELECT dersid FROM "ogrencidersleritable" WHERE ogrenciid= @id', substitutionValues: {'id': id});
   if(result!.isNotEmpty)
  {  
    for (final ders in result) {
      debugPrint("dersId => $ders");
      final dersAd = await PostgreSql.connection?.query('SELECT * FROM "derslertable" WHERE id= @id', substitutionValues: {'id': ders[0]});
      debugPrint("dersAdi => $dersAd");
      ogrenciDersler.add(dersAd!.isEmpty ? [] : dersAd[0]);
    }}
    return ogrenciDersler;
  }

  static Future<List<dynamic>> getSpecialOgrenciDersData(int id,int dersid) async {
    final result =
        await PostgreSql.connection?.query('SELECT * FROM "ogrencidersleritable" WHERE ogrenciid= @id AND dersid = @dersid', substitutionValues: {'id': id,'dersid':dersid});
    debugPrint("ders data ===> ${result![0]}");
    return result[0];
  }

  static Future<List<String>> getSpecialHocaIlgiAlanlari(int id) async {
    List<String> hocaIlgiAlanlari = [];
    final result =
        await PostgreSql.connection?.query('SELECT ilgialaniid FROM "hocailgialanlaritable" WHERE hocaid= @id', substitutionValues: {'id': id});
    for (final ilgiAlanlari in result!) {
      debugPrint("ilgiAlanlariId => $ilgiAlanlari");
      final ilgiAlaniAd =
          await PostgreSql.connection?.query('SELECT ilgialani FROM "ilgialanlaritable" WHERE id= @id', substitutionValues: {'id': ilgiAlanlari[0]});
      debugPrint("ilgiAlaniAd => $ilgiAlaniAd");
      hocaIlgiAlanlari.add(ilgiAlaniAd!.isEmpty ? [] : ilgiAlaniAd[0][0]);
    }
    return hocaIlgiAlanlari;
  }

  static Future<double> getSpecialOgrenciGenelNotOrtalmasi(int ogrenciId) async
  {
             final result =
        await PostgreSql.connection?.query('SELECT genelnotort FROM "ogrencitable" WHERE id= @id', substitutionValues: {'id': ogrenciId});
        return result![0][0];
  }

  static Future<List<List<dynamic>>> getSpecialHocaIlgiAlanlariData(int id) async {
    List<List<dynamic>> hocaIlgiAlanlari = [];
    final result =
        await PostgreSql.connection?.query('SELECT ilgialaniid FROM "hocailgialanlaritable" WHERE hocaid= @id', substitutionValues: {'id': id});
    for (final ilgiAlanlari in result!) {
      debugPrint("ilgiAlanlariId => $ilgiAlanlari");
      final ilgiAlaniAd =
          await PostgreSql.connection?.query('SELECT * FROM "ilgialanlaritable" WHERE id= @id', substitutionValues: {'id': ilgiAlanlari[0]});
      debugPrint("ilgiAlaniAd => $ilgiAlaniAd");
      hocaIlgiAlanlari.add(ilgiAlaniAd!.isEmpty ? [] : ilgiAlaniAd[0]);
    }
       return hocaIlgiAlanlari;
  }
 
    static Future<List<List<dynamic>>> getSpecialOgrenciIlgiAlanlariData(int id) async {
    List<List<dynamic>> ogrenciIlgiAlanlari = [];
    final result =
        await PostgreSql.connection?.query('SELECT ilgialaniid FROM "ogrenciilgialanlaritable" WHERE ogrenciid= @id', substitutionValues: {'id': id});
    for (final ilgiAlanlari in result!) {
      debugPrint("ilgiAlanlariId => $ilgiAlanlari");
      final ilgiAlaniAd =
          await PostgreSql.connection?.query('SELECT * FROM "ilgialanlaritable" WHERE id= @id', substitutionValues: {'id': ilgiAlanlari[0]});
      debugPrint("ilgiAlaniAd => $ilgiAlaniAd");
      ogrenciIlgiAlanlari.add(ilgiAlaniAd!.isEmpty ? [] : ilgiAlaniAd[0]);
    }
       return ogrenciIlgiAlanlari;
  }

  static Future<List<String>> getSpecialOgrenciIlgiAlanlari(int id) async {
    List<String> ogrenciIlgiAlanlari = [];
    final result =
        await PostgreSql.connection?.query('SELECT ilgialaniid FROM "ogrenciilgialanlaritable" WHERE ogrenciid= @id', substitutionValues: {'id': id});
    for (final ilgiAlanlari in result!) {
      debugPrint("ilgiAlanlariId => $ilgiAlanlari");
      final ilgiAlaniAd =
          await PostgreSql.connection?.query('SELECT ilgialani FROM "ilgialanlaritable" WHERE id= @id', substitutionValues: {'id': ilgiAlanlari[0]});
      debugPrint("ilgiAlaniAd => $ilgiAlaniAd");
      ogrenciIlgiAlanlari.add(ilgiAlaniAd!.isEmpty ? [] : ilgiAlaniAd[0][0]);
    }
    return ogrenciIlgiAlanlari;
  }

  static Future<List<Map<String, dynamic>>> getOgrenciTalepDataList(int ogrenciid) async {
    List<Map<String, dynamic>> ogrenciTalepListTmp = [];
    final result =
        await PostgreSql.connection?.query('SELECT * FROM "ogrencitaleptable" WHERE ogrenciid = @id', substitutionValues: {'id': ogrenciid});
    debugPrint("ogrenciTalep result => $result");
    for (final ogrenciTalepData in result!) {
      debugPrint("getOgrenciTalep dersid ==> ${ ogrenciTalepData[3]}");
      final dersData = await getSpecialOgrenciDersData(ogrenciid, ogrenciTalepData[3]);
      final dersAd = await getUser(ogrenciTalepData[3],SqlTableName.dersler);
            debugPrint("getOgrenciTalep ders ad ==> ${dersAd[1]}");
      final hocaData = await getUser(ogrenciTalepData[2], SqlTableName.hoca);
      ogrenciTalepListTmp.add({"dersAd":dersAd[1],"dersData": dersData, "hocaData": hocaData, "talepData": ogrenciTalepData});
    }
    return ogrenciTalepListTmp;
  }

  static Future<List<Map<String, dynamic>>> getHocaTalepOlusturanlarDataList(int hocaid) async {
    List<Map<String, dynamic>> hocaTalepListTmp = [];
    final result = await PostgreSql.connection?.query('SELECT * FROM "ogrencitaleptable" WHERE hocaid = @id AND talepdurum = @durum',
        substitutionValues: {'id': hocaid, "durum": "Beklemede"});
    debugPrint("hocaTalepOlusturanlar result => $result");
    for (final hocaTalepData in result!) {
      debugPrint("hocaTalepData in While => $hocaTalepData");
      final dersData = await getUser(hocaTalepData[3], SqlTableName.dersler);
      final ogrenciData = await getUser(hocaTalepData[1], SqlTableName.ogrenci);
      hocaTalepListTmp.add({"dersData": dersData, "ogrenciData": ogrenciData, "talepData": hocaTalepData});
    }
    return hocaTalepListTmp;
  }

  static Future<List<Map<String, dynamic>>> getOgrenciTalepOlusturanlarDataList(int ogrenciid) async {
    List<Map<String, dynamic>> ogrenciTalepListTmp = [];
    final result = await PostgreSql.connection?.query('SELECT * FROM "hocataleptable" WHERE ogrenciid = @id', substitutionValues: {'id': ogrenciid});
    debugPrint("ogrenciTalepOlusturanlar result => $result");
    for (final ogrenciTalepData in result!) {
      debugPrint("ogrenciTalepData in While => $ogrenciTalepData");
      final dersData = await getUser(ogrenciTalepData[3], SqlTableName.dersler);
      final hocaData = await getUser(ogrenciTalepData[1], SqlTableName.hoca);
      ogrenciTalepListTmp.add({"dersData": dersData, "hocaData": hocaData, "talepData": ogrenciTalepData});
    }
    return ogrenciTalepListTmp;
  }

  static Future<bool> getUserFirstEntry(int id, SqlTableName tableName) async {
    final result =
        await PostgreSql.connection?.query('SELECT firstentry FROM "${tableName.getSqlTableName}" WHERE id = @id', substitutionValues: {'id': id});
    debugPrint("firstEntry ===> $result");
    return result![0][0].contains( "false" ) ? false : true;
  }

  static Future<Map<String,dynamic>> getOgrenciTalepDersInfo(int ogrenciId, int dersId) async {
    debugPrint("ogrenciId => $ogrenciId");
    debugPrint("dersId => $dersId");
    final result = await PostgreSql.connection?.query('SELECT hocaid FROM "onaylanmisderstable" WHERE ogrenciid = @id AND dersid = @dersid',
        substitutionValues: {'id': ogrenciId, "dersid": dersId});
    debugPrint("getOgrenciTalepDersInfo => $result");
    if (result!.isEmpty) {
      return {"hocaAd":"Dersi Aldıgı Hoca Bulunmamaktadır","hocaData":[]};
    } else {
      final hocaDataResult = await getUser(result[0][0], SqlTableName.hoca);
      debugPrint("hocaAdSoyad  =>>> ${hocaDataResult[1]} ${hocaDataResult[2]}");
      return {"hocaAd":" ${hocaDataResult[1]} ${hocaDataResult[2]}","hocaData":hocaDataResult};
    }
  }

  static Future<List<int>> getUserDersIdList(int id, String kullaniciText, SqlTableName tableName) async {
    final result = await PostgreSql.connection
        ?.query('SELECT dersid FROM "${tableName.getSqlTableName}" WHERE $kullaniciText = @id', substitutionValues: {"id": id});
    List<int> userDersIdList = [];
    for (final dersId in result!) {
      userDersIdList.add(dersId[0]);
    }
    return userDersIdList;
  }

  static Future<List<int>> getUserIlgiAlanlariIdList(int id, String kullaniciText, SqlTableName tableName) async {
    final result = await PostgreSql.connection
        ?.query('SELECT ilgialaniid FROM "${tableName.getSqlTableName}" WHERE $kullaniciText = @id', substitutionValues: {"id": id});
    List<int> userIlgiAlanlarIdList = [];
    for (final ilgiAlaniId in result!) {
      userIlgiAlanlarIdList.add(ilgiAlaniId[0]);
    }
    return userIlgiAlanlarIdList;
  }

  static Future<List<List>> getHocaOgrencileriDataList(int id) async {
    final result =
        await PostgreSql.connection?.query('SELECT ogrenciid,dersid FROM "onaylanmisderstable" WHERE hocaid = @id', substitutionValues: {"id": id});
    debugPrint("getHocaOgrencileri result => $result");
    return result!;
  }

  static Future<List<Map<String, dynamic>>> getUserMesaj(int userId) async {
    final mesajResult = await PostgreSql.connection?.query('SELECT id,gonderenid,mesaj,gonderenType FROM mesajtable WHERE aliciid = @aliciid',
        substitutionValues: {"aliciid": userId.toString()});
    List<Map<String, dynamic>> mesajList = [];
    debugPrint("mesajResult => $mesajResult");
    if (mesajResult!.isNotEmpty) {
      debugPrint("mesajResult is $mesajResult AND is in İf block");
      for (final tmp in mesajResult) {
        if (tmp[3].contains("Hoca")) {
          final gonderenUser = await getUser(int.parse(tmp[1]), SqlTableName.hoca);

          mesajList.add({"gonderenList": gonderenUser, "mesaj": tmp});
        } else if (tmp[3].contains("Ogrenci")) {
          final gonderenUser = await getUser(int.parse(tmp[1]), SqlTableName.ogrenci);
          debugPrint("gonderenUser is $gonderenUser ");
          mesajList.add({"gonderenList": gonderenUser, "mesaj": tmp});
          debugPrint(
              "mesajList[gonderenList][1] = ${mesajList[0]['gonderenList'][2]} and mesajList[gonderenList][1] = ${mesajList[0]['gonderenList'][3]}");
        } else {
          final gonderenUser = await getUser(int.parse(tmp[1]), SqlTableName.yonetici);
          List<dynamic> tmpYoneticiData = [];
          tmpYoneticiData.add(gonderenUser[0]);
          tmpYoneticiData.add(gonderenUser[1]);
          tmpYoneticiData.add("******");  
          mesajList.add({"gonderenList": tmpYoneticiData, "mesaj": tmp});
        }
      }
    }
    return mesajList;
  }
}
