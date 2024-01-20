
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

class PostgreSql {
  
   PostgreSql._();
   static PostgreSQLConnection ? connection ;
   static Future<void> sqlInit() async
   {
   connection = PostgreSQLConnection("localhost", 5432, "yazLab1", username: "postgres", password: "123123");
    await connection?.open().then((value) {
          debugPrint("veri tabanı baglandi");
    });
   }
  
  
}