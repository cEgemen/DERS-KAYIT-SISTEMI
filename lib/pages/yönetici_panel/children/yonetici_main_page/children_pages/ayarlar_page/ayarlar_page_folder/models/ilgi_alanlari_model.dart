
import 'package:flutter/material.dart';

class IlgiAlaniModel {


  int ? id;
  String ? ilgialani;
  /* final KullaniciType kullaniciType =KullaniciType.ogrenci; */
  final List<String> kullaniciPropartyNames = ["id","ilgialani"];
  
  IlgiAlaniModel._({this.id,this.ilgialani});  
  factory IlgiAlaniModel.entry(List sqlData)
   {
         final ilgiAlaniData = sqlData ;
         for(final tmp in ilgiAlaniData)
         {
            debugPrint(" ilgiAlani => $tmp AND dataType => ${tmp.runtimeType} ");
         }
        return IlgiAlaniModel._(id: ilgiAlaniData[0],ilgialani:ilgiAlaniData[1]);
   }

   List<dynamic> toList ()
   {
      return [id,ilgialani];
   }
   Map<String , dynamic> toMap ()
   {
      return {"id":id,"ilgialani":ilgialani};
   }
    Map<String , dynamic> fromListToMap (List<dynamic> kullanici)
   {
      return {"id":kullanici[0],"ilgialani":kullanici[1]};
   } 
}