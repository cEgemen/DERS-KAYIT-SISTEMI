
import 'package:flutter/material.dart';

class DerslerModel {


  int ? id;
  String ? dersadi;
  /* final KullaniciType kullaniciType =KullaniciType.ogrenci; */
  final List<String> kullaniciPropartyNames = ["id","dersadi"];
  
  DerslerModel._({this.id,this.dersadi});  
  factory DerslerModel.entry(List sqlData)
   {
         final derslerData = sqlData ;
         for(final tmp in derslerData)
         {
            debugPrint(" dersadi => $tmp AND dataType => ${tmp.runtimeType} ");
         }
        return DerslerModel._(id: derslerData[0],dersadi:derslerData[1]);
   }

   List<dynamic> toList ()
   {
      return [id,dersadi];
   }
   Map<String , dynamic> toMap ()
   {
      return {"id":id,"dersadi":dersadi};
   }
    Map<String , dynamic> fromListToMap (List<dynamic> kullanici)
   {
      return {"id":kullanici[0],"dersadi":kullanici[1]};
   } 

  


}