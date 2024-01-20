
import 'package:flutter/material.dart';
import '../../../../core/enums/kullanici_type_enum.dart';

class OgrenciModel {
 
  int ? id;
  String ? ad;
  String ? soyad;
  String ? sifre;
  String ? ogrencino;
  String ? pdf;
  double ? genelnotort;
  String ? firstentry;
  List<int> ogrenciDerslerId = [];
 List<int> ogrenciIlgiAlanlariId = [];
  final KullaniciType kullaniciType =KullaniciType.ogrenci;
  final List<String> kullaniciPropartyNames = ["id","ad","soyad","pdf","ogrencino","firstentry","sifre","genelnotort"];
  
   
  OgrenciModel._({this.id,this.ad,this.soyad,this.sifre,this.ogrencino,this.genelnotort,this.pdf,this.firstentry});  
  factory OgrenciModel.entry(List sqlData)
   {
         final ogrenciData = sqlData ;
         for(final tmp in ogrenciData)
         {
            debugPrint(" ogrenciData => $tmp AND dataType => ${tmp.runtimeType} ");
         }
        return OgrenciModel._(id: ogrenciData[0],ad:ogrenciData[1],soyad:ogrenciData[2],pdf:ogrenciData[3],genelnotort:ogrenciData[7],sifre:ogrenciData[6],ogrencino:ogrenciData[4],firstentry:ogrenciData[5]);
   }

   List<dynamic> toList ()
   {
      return [id,ad,soyad,pdf,ogrencino,firstentry,sifre,genelnotort];
   }
   Map<String , dynamic> toMap ()
   {
      return {"id":id,"ad":ad,"soyad":soyad,"pdf":pdf,"genelnotort":genelnotort,"sifre":sifre,"ogrencino":ogrencino,"firstentry":firstentry};
   }
    Map<String , dynamic> fromListToMap (List<dynamic> kullanici)
   {
      return {"id":kullanici[0],"ad":kullanici[1],"soyad":kullanici[2],"pdf":kullanici[3],"genelnotort":kullanici[7],"sifre":kullanici[6],"ogrencino":kullanici[4],"firstentry":kullanici[5]};
   }

   static OgrenciModel fromListToModel(List<dynamic> modelList)
   {
       return OgrenciModel.entry(modelList);
   } 
   
}