import '../../enums/sql_table_names_enum.dart';
import '../enums_extensions/sql_table_name_extension.dart';

extension StringExtension on String {
  SqlTableName get toSqlTableName {
    if (SqlTableName.hoca.getSqlTableName.toLowerCase().contains(toLowerCase())) {
      return SqlTableName.hoca;
    } else if (SqlTableName.ogrenci.getSqlTableName.toLowerCase().contains(toLowerCase())) {
      return SqlTableName.ogrenci;
    } else if (SqlTableName.yonetici.getSqlTableName.toLowerCase().contains(toLowerCase())) {
       return SqlTableName.yonetici;
    } else {
      throw Exception("Beklenmeyen Deger");
    }
  }
}
