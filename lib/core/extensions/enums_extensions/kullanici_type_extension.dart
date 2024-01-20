

import '../../enums/kullanici_type_enum.dart';

extension KullaniciTypeExtension on KullaniciType {
    String get getKullaniciTypeName {
         switch(this)
         {
            case KullaniciType.hoca:
            return "Hoca";
            case KullaniciType.ogrenci:
            return "Ogrenci";
         }
       
    }
}