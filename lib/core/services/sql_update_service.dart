import 'package:flutter/material.dart';
import 'sql_select_service.dart';
import '../extensions/enums_extensions/sql_table_name_extension.dart';
import '../enums/sql_table_names_enum.dart';
import '../inits/postgreSql_init/postgreSql_init.dart';

class SqlUpdateService {
  static Future<void> updateKullaniciSifre(String id, String sifre, SqlTableName tableName) async {
    final result = await PostgreSql.connection!.query(
      'UPDATE "${tableName.getSqlTableName}" SET sifre = @new_value WHERE id = @condition_value',
      substitutionValues: {
        'new_value': sifre,
        'condition_value': id,
      },
    );
    debugPrint("result -> $result");
  }

  static Future<void> updateTablesValues(Map<String, dynamic> model, SqlTableName tableName) async {
    if (tableName == SqlTableName.ogrenci) {
      await PostgreSql.connection!.query(
        'UPDATE "${tableName.getSqlTableName}" SET ad = @ad , soyad = @soyad ,pdf = @pdf ,genelnotort = @genelnotort,sifre = @sifre , ogrencino = @ogrencino WHERE id = @condition_value',
        substitutionValues: {
          'sifre': model["sifre"],
          'ad': model["ad"],
          'soyad': model["soyad"],
          'pdf': model["pdf"],
          'genelnotort': model["genelnotort"],
          'ogrencino': model["ogrencino"],
          'condition_value': model["id"],
        },
      );
    } else if (tableName == SqlTableName.hoca) {
      debugPrint("gelenModel => ${model.toString()}");
      await PostgreSql.connection!.query(
        'UPDATE "${tableName.getSqlTableName}" SET ad = @ad , soyad = @soyad , sifre = @sifre , sicilno = @sicilno , kalankontenjan = @kalankontenjan , baslangickontenjan = @baslangickontenjan , firstentry = @firstentry  WHERE id = @condition_value',
        substitutionValues: {
          'ad': model["ad"],
          'soyad': model["soyad"],
          'sifre': model["sifre"],
          'sicilno': model["sicilno"],
          'firstentry': model["firstentry"],
          'baslangickontenjan': model["baslangickontenjan"],
          'kalankontenjan': model["kalankontenjan"],
          'condition_value': model["id"],
        },
      );
    } else if (tableName == SqlTableName.ilgiAlanlari) {
      await PostgreSql.connection!.query(
        'UPDATE "${tableName.getSqlTableName}" SET ilgialani = @ilgialani  WHERE id = @condition_value',
        substitutionValues: {
          'ilgialani': model["ilgialani"],
          'condition_value': model["id"],
        },
      );
    } else if (tableName == SqlTableName.dersler) {
      await PostgreSql.connection!.query(
        'UPDATE "${tableName.getSqlTableName}" SET dersadi = @dersadi  WHERE id = @condition_value',
        substitutionValues: {
          'dersadi': model["dersadi"],
          'condition_value': model["id"],
        },
      );
    }
  }

  static Future<void> kullaniciLateSetupUpdate(int id,String ogrenciNo,double ogrenciGenelNotOrt,SqlTableName tableName) async {
    if (tableName == SqlTableName.ogrenci) {
      await PostgreSql.connection!.query(
        'UPDATE "${tableName.getSqlTableName}" SET firstentry = @firstentry , pdf = @pdf ,ogrencino = @ogrencino ,genelnotort = @genelnotort WHERE id = @condition_value',
        substitutionValues: {
          'firstentry': "true",
          'pdf': "true",
          'ogrencino' :ogrenciNo,
          'genelnotort' : ogrenciGenelNotOrt,
          'condition_value': id,
        },
      );
    } else {
      await PostgreSql.connection!.query(
        'UPDATE "${tableName.getSqlTableName}" SET firstentry = @firstentry  WHERE id = @condition_value',
        substitutionValues: {
          'firstentry': "true",
          'condition_value': id,
        },
      );
    }
  }

  static Future<void> OgrenciTalepTableUpdate(int id, String durum) async {
    await PostgreSql.connection!.query(
      'UPDATE ogrencitaleptable SET talepdurum = @talepdurum  WHERE id = @condition_value',
      substitutionValues: {
        'talepdurum': durum,
        'condition_value': id,
      },
    );
  }

  static Future<void> hocaTalepTableUpdate(int id, String durum) async {
    await PostgreSql.connection!.query(
      'UPDATE hocataleptable SET talepdurum = @talepdurum  WHERE id = @condition_value',
      substitutionValues: {
        'talepdurum': durum,
        'condition_value': id,
      },
    );
  }

  static Future<void> addDersSecimAyarlari(String baslangicDate, String bitisDate,String durum) async {
    final sistemId = await SqlSelectService.getSistemAyarlari();
    await PostgreSql.connection!.query(
      'UPDATE sistemayarlartable SET  derssecimbaslamatarihi = @derssecimbaslamatarihi , derssecimibitistarihi = @derssecimibitistarihi ,derssecimdurum = @derssecimdurum WHERE id = @id',
      substitutionValues: {
        'derssecimbaslamatarihi': baslangicDate,
        'derssecimibitistarihi': bitisDate,
        'derssecimdurum' : durum,
        'id': sistemId[0],
      },
    );
  }

  static Future<void> updateDersSecimBitisDateAyarlari(String bitisDate) async {
    final sistemId = await SqlSelectService.getSistemAyarlari();
    await PostgreSql.connection!.query(
      'UPDATE sistemayarlartable SET derssecimibitistarihi = @derssecimibitistarihi  WHERE id = @id',
      substitutionValues: {
        'derssecimibitistarihi': bitisDate,
        'id': sistemId[0],
      },
    );
  }

  static Future<void> updateSistemSecimDurumu(String durum) async {
    final sistemId = await SqlSelectService.getSistemAyarlari();
    await PostgreSql.connection!.query(
      'UPDATE sistemayarlartable SET derssecimdurum = @derssecimdurum  WHERE id = @id',
      substitutionValues: {
        'derssecimdurum': durum,
        'id': sistemId[0],
      },
    );
  }

  static Future<void> updateHocaKalanKontenjanSayisi(int hocaId, String yeniKalanKontenjanDegeri) async {
    await PostgreSql.connection!.query(
      'UPDATE hocatable SET kalankontenjan = @kalankontenjan  WHERE id = @id',
      substitutionValues: {
        'kalankontenjan': yeniKalanKontenjanDegeri,
        'id': hocaId,
      },
    );
  }
     static Future<void> updateOgrenciDersKalanTalepSayisi(int ogrenciId,int dersId,String talepSay) async
      {
        debugPrint("ders id ==> $dersId");
        debugPrint("ogrenci id ==> $ogrenciId");
        debugPrint("talepSayisi ==> $talepSay");
             await PostgreSql.connection!.query(
      'UPDATE ogrencidersleritable SET kalantalepsayisi = @kalantalepsayisi  WHERE ogrenciid = @ogrenciid AND dersid = @dersid',
      substitutionValues: {
        'kalantalepsayisi': talepSay,
        'ogrenciid': ogrenciId,
        'dersid' : dersId
      },
    );
      }
      
  static Future<void> updateSistemAyarlari(List<dynamic> updateValues) async {
    debugPrint("updateSistemAyarlari =>> $updateValues");
    await PostgreSql.connection!.query(
      'UPDATE sistemayarlartable SET minilgialani = @minilgialani, hocamindersverme = @hocamindersverme , hocamaxdersverme = @hocamaxdersverme , ogrencimindersalma = @ogrencimindersalma , ogrencimaxdersalma = @ogrencimaxdersalma , ogrencitalepsayi = @ogrencitalepsayi, ogrencifarklihocasecme = @ogrencifarklihocasecme, hocakontenjan = @hocakontenjan,mesajkarektersayi = @mesajkarektersayi   WHERE id = @id',
      substitutionValues: {
        'id': updateValues[0],
        'minilgialani': updateValues[1],
        'hocamindersverme': updateValues[2],
        'hocamaxdersverme': updateValues[3],
        'ogrencimindersalma': updateValues[4],
        'ogrencimaxdersalma': updateValues[5],
        'ogrencitalepsayi': updateValues[6],
        'ogrencifarklihocasecme': updateValues[7],
        'hocakontenjan': updateValues[8],
        'mesajkarektersayi': updateValues[9]
      },
    );
  }
}
