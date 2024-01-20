import 'package:flutter/material.dart';
import '../enums/sql_table_names_enum.dart';
import '../extensions/enums_extensions/sql_table_name_extension.dart';

import '../inits/postgreSql_init/postgreSql_init.dart';

class SqlDeleteService {
  SqlDeleteService._();

  static Future<void> deletData(int id, SqlTableName tableName) async {
    if (tableName == SqlTableName.yonetici) {
      throw Exception("Delete Yoneticiiiii");
    }
   await PostgreSql.connection!.query(
      'DELETE FROM "${tableName.getSqlTableName}" WHERE id = @id',
      substitutionValues: {
        'id': id,
      },
    );
    debugPrint("silinecek id =>  $id");
  } 

  static Future<void> deletOanylanmisDersTableData(int ogrenciid,int hocaid,int dersid) async {
   await PostgreSql.connection!.query(
      'DELETE FROM "onaylanmisderstable" WHERE hocaid = @hocaid AND ogrenciid = @ogrenciid AND dersid = @dersid',
      substitutionValues: {
        'hocaid':hocaid,
        'ogrenciid':ogrenciid,
        'dersid':dersid
      },
    );
  }
  
  static Future<void> specialOneItemDeletData(dynamic value,String filterText,SqlTableName tableName) async
  {
       await PostgreSql.connection!.query('DELETE FROM "${tableName.getSqlTableName}" WHERE $filterText = @filterText',
      substitutionValues: {
        'filterText':value,
      },);
  }
 
 static Future<void> specialTwoItemDeletData(dynamic value,dynamic value2,String filterText,String filterText2,SqlTableName tableName) async
  {
       await PostgreSql.connection!.query('DELETE FROM "${tableName.getSqlTableName}" WHERE $filterText = @filterText AND $filterText2 = @filterText2',
      substitutionValues: {
        'filterText':value,
        'filterText2':value2
      },);
  }

}
