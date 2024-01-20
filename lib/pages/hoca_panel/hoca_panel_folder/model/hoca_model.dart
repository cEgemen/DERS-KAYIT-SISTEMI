
import 'package:flutter/material.dart';

import '../../../../core/enums/kullanici_type_enum.dart';

class HocaModel {

 int ? id;
 String ? ad;
 String ? soyad;
 String ? sicilno;
 String? sifre; 
 String ? firstentry;
 String ? kalankontenjan;
 String ? baslangickontenjan;
 List<int> hocaDerslerId = [];
 List<int> hocaIlgiAlanlariId = [];

 final KullaniciType kullaniciType =KullaniciType.hoca;
 final List<String> kullaniciPropartyNames = ["id","ad","soyad","sicilno","firstentry","sifre","baslangickontenjan","kalankontenjan"];
  HocaModel._({this.id,this.ad,this.soyad,this.sifre,this.sicilno,this.firstentry,this.kalankontenjan,this.baslangickontenjan});  
  
  factory HocaModel.entry(List sqlData)
   {
         final hocaData = sqlData;
         for(final tmp in hocaData)
         {
            debugPrint(" hocaData => $tmp AND dataType => ${tmp.runtimeType} ");
         }
        return HocaModel._(id: hocaData[0],ad:hocaData[1],soyad:hocaData[2],sifre:hocaData[5],sicilno:hocaData[3],firstentry:hocaData[4],kalankontenjan: hocaData[7],baslangickontenjan: hocaData[6]);
   }

    List<dynamic> toList ()
   {
      return [id,ad,soyad,sicilno,firstentry,sifre,kalankontenjan,baslangickontenjan];
   }

    Map<String,dynamic> toMap ()
   {
      return {"id":id,"ad":ad,"soyad":soyad,"sifre":sifre,"sicilno":sicilno,"firstentry":firstentry,"kalankontenjan":kalankontenjan,"baslangickontenjan":baslangickontenjan};
   }
    Map<String , dynamic> fromListToMap (List<dynamic> kullanici)
   {
      return {"id":kullanici[0],"ad":kullanici[1],"soyad":kullanici[2],"sifre":kullanici[5],"sicilno":kullanici[3],"firstentry":kullanici[4],"kalankontenjan":kullanici[7],"baslangickontenjan":kullanici[6]};
   }

  static HocaModel fromListToModel(List modelValuesList) {
      return HocaModel.entry(modelValuesList);
  }
   
}