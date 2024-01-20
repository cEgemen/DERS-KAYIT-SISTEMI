import 'dart:math';

import 'package:flutter/material.dart';
import 'sql_select_service.dart';
import '../enums/sql_table_names_enum.dart';
import '../extensions/enums_extensions/sql_table_name_extension.dart';

import '../inits/postgreSql_init/postgreSql_init.dart';

class SqlInsertService {
  static Future<void> insertKullanici(String ad, String soyad, SqlTableName tableName) async {
     if(tableName.getSqlTableName == "ogrencitable")
     {
       await PostgreSql.connection?.query(
      'INSERT INTO "${tableName.getSqlTableName}" (ad, soyad,sifre) VALUES (@value1, @value2,@value3)',
      substitutionValues: {
        'value1': ad,
        'value2': soyad,
        'value3': -1,
      },
    );
     }
     else
    { 
      final sistemKontenjan = await SqlSelectService.getSistemAyarlari();
       await PostgreSql.connection?.query(
      'INSERT INTO "${tableName.getSqlTableName}" (ad, soyad,sifre,sicilno,kalankontenjan,baslangickontenjan) VALUES (@value1, @value2,@value3,@value4,@value5,@value6)',
      substitutionValues: {
        'value1': ad,
        'value2': soyad,
        'value3': -1,
        'value4':Random().nextInt(999999999)+100000000,
        'value5':sistemKontenjan[9],
        'value6':sistemKontenjan[9],

      },
    );
    }
  }
 
  static Future<void> addIlgiAlani(String ilgiAlani,SqlTableName tableName) async {
           await PostgreSql.connection?.query(
'INSERT INTO "${tableName.getSqlTableName}" (ilgialani) VALUES (@value1)',
      substitutionValues: {
        'value1': ilgiAlani,
      },
           );
  } 

   static Future<void> addDers(String dersadi,SqlTableName tableName) async {
           await PostgreSql.connection?.query(
'INSERT INTO "${tableName.getSqlTableName}" (dersadi) VALUES (@value1)',
      substitutionValues: {
        'value1': dersadi,
      },
           );
  }
  
    static Future<void> addOgrenciIlgiAlani(List<int> ilgiAlaniId,int ogrenciId,SqlTableName tableName) async {
           for(int ilgiAlaniId in ilgiAlaniId)
           {
           await PostgreSql.connection?.query(
'INSERT INTO "${tableName.getSqlTableName}" (ogrenciid,ilgialaniid) VALUES (@value1,@value2)',
      substitutionValues: {
        'value1': ogrenciId,
        'value2': ilgiAlaniId
      },
           );
           }
  }

  static Future<void> addOgrenciGecmisDers(List<int> gecmisDers,int ogrenciId) async {
           List<String> dersNotu = ["AA","BA","BB","CB","CC","DC","DD"];
           List<double> derece = [4,3.5,3,2.5,2,1.5,1];
           for(int gecmisDersId in gecmisDers)
           {
               final T = "${Random().nextInt(5)+1}";
               final U = "${Random().nextInt(4)}";
               final UK= "${Random().nextInt(4)+2}";
               final AKTS= "${Random().nextInt(6)+1}";
               final not = Random().nextInt(dersNotu.length);
               final puan = derece[not] * int.parse(AKTS);
           await PostgreSql.connection?.query(
 'INSERT INTO "ogrencigecmisverilertable" (dersid,ogrenciid,dersstatü,ogretimdili,teorikderssaat,uygulamaderssaat,ulusalkredi,avrupakreditransfersistem,dersnotu,puan,aciklama) VALUES (@value1,@value2,@value3,@value4,@value5,@value6,@value7,@value8,@value9,@value10,@value11)',
      substitutionValues: {
        'value1': gecmisDersId,
        'value2': ogrenciId,
         'value3': "Z",
        'value4': "Tr",
         'value5': T,
        'value6': U,
         'value7': UK,
        'value8': AKTS,
         'value9': dersNotu[not],
        'value10': puan.toStringAsFixed(1),
        'value11':"G"
      },
           );
           }
  }


     static Future<void> addHocaIlgiAlani(List<int> ilgiAlaniId,int hocaId,SqlTableName tableName) async {
           for(int ilgiAlaniId in ilgiAlaniId)
           {
           await PostgreSql.connection?.query(
'INSERT INTO "${tableName.getSqlTableName}" (hocaid,ilgialaniid) VALUES (@value1,@value2)',
      substitutionValues: {
        'value1': hocaId,
        'value2': ilgiAlaniId
      },
           );
           }
  }
  
   static Future<void> addHocaDers(List<int> dersId,int hocaId,SqlTableName tableName) async {
           for(int dersId in dersId)
           {
           await PostgreSql.connection?.query(
'INSERT INTO "${tableName.getSqlTableName}" (hocaid,dersid) VALUES (@value1,@value2)',
      substitutionValues: {
        'value1': hocaId,
        'value2': dersId
      },
           );
           }
  }
      static Future<void> addOgrenciDers(List<int> dersId,int ogrenciId,SqlTableName tableName) async {
          final sistemAyarlari =await SqlSelectService.getSistemAyarlari();
           for(int dersId in dersId)
           {
           await PostgreSql.connection?.query(
'INSERT INTO "${tableName.getSqlTableName}" (ogrenciid,dersid,kalantalepsayisi,baslangictalepsayisi) VALUES (@value1,@value2,@value3,@value4)',
      substitutionValues: {
        'value1': ogrenciId,
        'value2': dersId,
        'value3' : sistemAyarlari[6],
        'value4': sistemAyarlari[6],
      },
           );
           }
  }

    static Future<void> addMesaj(int gonderenId,int adliciId,String mesaj,String gonderenType) async {
            await PostgreSql.connection?.query(
'INSERT INTO mesajtable (gonderenid,aliciid,mesaj,gonderentype) VALUES (@value1,@value2,@value3,@value4)',
      substitutionValues: {
        'value1': gonderenId,
        'value2': adliciId,
        'value3': mesaj,
        'value4': gonderenType
      },
           );
  }
   
    static Future<void> insertOgrenci(String ad, String soyad,String ogrencino,double genelnotort) async {
 
    await PostgreSql.connection?.query(
      'INSERT INTO "ogrencitable" (ad, soyad,sifre,ogrencino,genelnotort) VALUES (@value1, @value2,@value3,@value4,@value5)',
      substitutionValues: {
        'value1': ad,
        'value2': soyad,
        'value3': -1,
        'value4':ogrencino,
        'value5':genelnotort,
      },
    );
     
  }
  

  static Future<void> otomatikOgrenciEkle(List<dynamic> sistemAyarlari) async
  {   
    final List<String> names = ["Ali",
  "Ayşe","Mehmet","Fatma","Veli","Hatice","Mustafa","Ahmet","Süleyman","Ayşegül","Merve","Zeynep","Emine","Volkan","Berrak", "Gül", "Gülcan", "Büşra", "Eda","Ege","Egemen","Muhammed","Burak","Hasan","Cagrı","Karaman","Sami","Ferit","Kemal","İlyas","Kuzey","Guney","Serdar","Mahzar","Suayip","Akcan","Fazlullah","Feyyaz","Gönen","İmge","Kubilay","Nursal","Numan","Oytun","Pamir","Renan","Sarp","Şenol","Şevket","Tansu","Teoman","Tonguç"];
 final List<String> surnames = [
  "Aksoy","Ates","Yüksel","Kose","Tas","Tekin","Sarı","Avcı","Kaplan","Isık","Ozer","Gul","Turan","Unal","Keskin","Bulut","Bozkurt","Gunes","Yalcın","Güler","Altas","Sen","Acar","Can","Yavuz","Korkmaz","Ozcan","Polat","Simsek","Ozkan","Kurt","Koc","Kara","Cetin","Aslan","Kılıc","Dogan","Arslan","Ozdemir","Aydın","Oztürk","Yıldırım","Yıldız","Sahin","Celik","Demir","Kaya","Yılmaz"
  "Ay","Dolunay"];

     final secilecekMaxDersSayisi = int.parse(sistemAyarlari[5]);
     final allOgrenci = await SqlSelectService.getAllOgrenci();
    final allIlgiAlanlariData = await SqlSelectService.getAllIlgiAlani();
     List<String> olusturulanOgrenciNumara = [];
     for(final ogrenci in allOgrenci)
     {
          olusturulanOgrenciNumara.add(ogrenci["modalData"].ogrencino);
     }
     List<Map<String,dynamic>> allDersDatas = await  SqlSelectService.getAllDersler();
   
     debugPrint("olusturulan Ogrenci Numara ===>>> $olusturulanOgrenciNumara");
           for(int i = 0 ; i < 50 ; i++)
           {           
              debugPrint("All Ders ===> ${allDersDatas.length}"); 
              List<int> eklenenAd = [];
       List<int> eklenenSoyad = []; 
          List<int> eklenenDersIdList = [];
          List<int> eklenenIlgiAlaniList = [];     
          double uretilenGenelNotOrt = Random().nextDouble()*4;
          while(true)
          {
               if(2.0 < uretilenGenelNotOrt)
               {
                   break;
               }
             uretilenGenelNotOrt = Random().nextDouble()*4;
          }
          int uretilenOgrenciNumara = Random().nextInt(999999999)+100000000;
            while(true)
             {   
              debugPrint("1. while basladı"); 
                        int syc4 = 0;
              for(final no in olusturulanOgrenciNumara)
                {
                      if(no != "$uretilenOgrenciNumara")
                      {
                          syc4 ++;
                      }
                }
                if(syc4 == olusturulanOgrenciNumara.length)
                {
                   olusturulanOgrenciNumara.add("$uretilenOgrenciNumara");
                   break;
                 }
                else{
                   uretilenOgrenciNumara = Random().nextInt(999999999)+100000000;
                }
            } 
            int adIndex = Random().nextInt(names.length);
            int soyadIndex = Random().nextInt(surnames.length); 
            
             while(true)
             {   
              debugPrint("4. while basladı"); 
                        int syc4 = 0;
              for(final ad in eklenenAd)
                {
                      if(ad != adIndex)
                      {
                          syc4 ++;
                      }
                }
                if(syc4 == eklenenAd.length)
                {
                   eklenenAd.add(adIndex);
                   break;
                 }
                else{
                  adIndex = Random().nextInt(names.length);
                }
            } 

               while(true)
             {   
              debugPrint("5. while basladı"); 
                        int syc4 = 0;
              for(final soyad in eklenenSoyad)
                {
                      if(soyad != soyadIndex)
                      {
                          syc4 ++;
                      }
                }
                if(syc4 == eklenenSoyad.length)
                {
                   eklenenSoyad.add(soyadIndex);
                   break;
                 }
                else{
                  soyadIndex = Random().nextInt(surnames.length);
                }
            } 

           await insertOgrenci(names[adIndex],surnames[soyadIndex],"$uretilenOgrenciNumara",double.parse(uretilenGenelNotOrt.toStringAsFixed(2)));
           debugPrint("ad ==>> ${names[adIndex]} || soyad ==>> ${surnames[soyadIndex]}   || numara ==> 200000000000 || not ==>> ${double.parse(uretilenGenelNotOrt.toStringAsFixed(2))}");
           final ogrenciIdData =await SqlSelectService.getSpecialValue("ogrencino","$uretilenOgrenciNumara","id",SqlTableName.ogrenci);
           debugPrint("ogrenci id ===>> ${ogrenciIdData[0]}");
            final secilecekDersSayisi = Random().nextInt(secilecekMaxDersSayisi)+1; 
            debugPrint("secilecek max ders sayisi ===>>> $secilecekMaxDersSayisi || secilecek ders sayisi ===>>> $secilecekDersSayisi");
           final secilecekIlgiAlaniSayisi = Random().nextInt(allIlgiAlanlariData.length)+1;
            debugPrint("all ilgi alanlari data size ===>>> ${allIlgiAlanlariData.length}  || secilecek ilgi alani  sayisi ===>>> $secilecekIlgiAlaniSayisi");
     debugPrint("son allDersData ==> ${allDersDatas.length}");

                 for(int j =0 ; j < secilecekDersSayisi ; j ++  )
                {
                  int secilenDersIndex = Random().nextInt(allDersDatas.length);
            while(true)
             {   
              debugPrint("2. while basladı"); 
                                int count = 0 ;
              for(final dersid in eklenenDersIdList)
                {
                      if(dersid != allDersDatas[secilenDersIndex]["modalData"].id)
                      {
                          count ++;
                      }
                }
                if(count == eklenenDersIdList.length)
                {
                      eklenenDersIdList.add(allDersDatas[secilenDersIndex]["modalData"].id);                   break;
                 }
                else{
                   secilenDersIndex = Random().nextInt(allDersDatas.length);
                }
            } 
                } 
                for(int j =0 ; j < secilecekIlgiAlaniSayisi ; j ++  )
                {
                  int secilenIlgiAlaniIndex = Random().nextInt(allIlgiAlanlariData.length);
                     while(true)
             {   
              debugPrint("3. while basladı"); 
                                int count = 0 ;
              for(final ilgialaniid in eklenenIlgiAlaniList)
                {
                      if(ilgialaniid != allIlgiAlanlariData[secilenIlgiAlaniIndex]["modalData"].id)
                      {
                          count ++;
                      }
                }
                if(count == eklenenIlgiAlaniList.length)
                {
                     eklenenIlgiAlaniList.add(allIlgiAlanlariData[secilenIlgiAlaniIndex]["modalData"].id);                   break;
                 }
                else{
                 secilenIlgiAlaniIndex = Random().nextInt(allIlgiAlanlariData.length);
                }
            } 
                }
              await addOgrenciIlgiAlani(eklenenIlgiAlaniList,ogrenciIdData[0],SqlTableName.ogrenciIlgiAlanlari);
               await addOgrenciDers(eklenenDersIdList,ogrenciIdData[0],SqlTableName.ogrenciDersleri);    
           }
  } 
  static Future<void> otomatikHocaEkle(List<dynamic> sistemAyarlari,int eklenecekHocaSayisi) async
  {

  }

    static Future<void> addOgrenciTalep(int ogrenciId,int hocaId,int dersId) async {
       debugPrint("ogrenciTalep ogrenciid => $ogrenciId");
       debugPrint("ogrenciTalep hocaid => $hocaId");
       debugPrint("ogrenciTalep dersid => $dersId");
            await PostgreSql.connection?.query(
'INSERT INTO ogrencitaleptable (ogrenciid,hocaid,dersid,talepdurum) VALUES (@value1,@value2,@value3,@value4)',
      substitutionValues: {
        'value1': ogrenciId,
        'value2': hocaId,
        'value3': dersId,
        'value4': "Beklemede"
      },
           );
  }
  
   static Future<void> addHocaTalep(int hocaId,int ogrenciId,int dersId) async {
            await PostgreSql.connection?.query(
'INSERT INTO hocataleptable (hocaid,ogrenciid,dersid) VALUES (@value1,@value2,@value3)',
      substitutionValues: {
        'value1': hocaId,
        'value2': ogrenciId,
        'value3': dersId,
      },
           );
  }
   
    static Future<void> addOnaylanmisDers(int hocaId,int ogrenciId,int dersId) async {
            await PostgreSql.connection?.query(
'INSERT INTO onaylanmisderstable (hocaid,ogrenciid,dersid) VALUES (@value1,@value2,@value3)',
      substitutionValues: {
        'value1': hocaId,
        'value2': ogrenciId,
        'value3': dersId,
      },
           );
  }
  
   static Future<void> addGecmisVeri( Map<String,dynamic> data,int ogrenciId) async {
        final dersId = await SqlSelectService.getSpecialValue("dersadi",data["dersAd"],"id",SqlTableName.dersler);   
            await PostgreSql.connection?.query(
'INSERT INTO ogrencigecmisverilertable (dersid,ogrenciid,dersstatü,ogretimdili,teorikderssaat,uygulamaderssaat,ulusalkredi,avrupakreditransfersistem,dersnotu,puan,aciklama) VALUES (@value1,@value2,@value3,@value4,@value5,@value6,@value7,@value8,@value9,@value10,@value11)',
      substitutionValues: {
        'value1': dersId[0],
        'value2': ogrenciId,
        'value3': data["dersData"][0],
        'value4': data["dersData"][1],
        'value5': data["dersData"][2],
        'value6': data["dersData"][3],
        'value7': data["dersData"][4],
        'value8': data["dersData"][5],
        'value9': data["dersData"][6],
        'value10': data["dersData"][7],
        'value11': data["dersData"][8],
      },
           );
  }
  
  


}
