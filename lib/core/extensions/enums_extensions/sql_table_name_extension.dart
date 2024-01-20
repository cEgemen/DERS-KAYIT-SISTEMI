import '../../enums/sql_table_names_enum.dart';

extension SqlTableNameExtension on SqlTableName {
  String get getSqlTableName {
    switch (this) {
      case SqlTableName.hoca:
        return "hocatable";
      case SqlTableName.ogrenci:
        return "ogrencitable";
      case SqlTableName.yonetici:
        return "yoneticitable";
         case SqlTableName.ilgiAlanlari:
        return "ilgialanlaritable";
         case SqlTableName.ogrenciIlgiAlanlari:
        return "ogrenciilgialanlaritable";
         case SqlTableName.hocaIlgiAlanlari:
        return "hocailgialanlaritable";
         case SqlTableName.dersler:
        return "derslertable";
         case SqlTableName.ogrenciDersleri:
        return "ogrencidersleritable";
         case SqlTableName.hocaDersleri:
        return "hocadersleritable";
         case SqlTableName.mesajlar:
        return "mesajtable";
         case SqlTableName.ogrenciTalep:
        return "ogrencitaleptable";
         case SqlTableName.hocaTalep:
        return "hocataleptable";
        case SqlTableName.onaylanmisderstable:
        return "onaylanmisderstable";
    }
  }
}
