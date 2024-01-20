import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:yaz_lab_proje_1/core/services/sql_insert_service.dart';
import '../../../../../core/enums/sql_table_names_enum.dart';
import '../../../../../core/services/sql_select_service.dart';
import '../../../ogrenci_panel_folders/model/ogrenci_model.dart';
part 'ogrenci_setup_view_modal.g.dart';

class OgrenciSetupViewModal = _OgrenciSetupViewModalBase with _$OgrenciSetupViewModal;

abstract class _OgrenciSetupViewModalBase with Store {
  int ? minAlinacakDers;
  int ? maxAlinacakDers;
  int ? minIlgiAlani;
  String  pdfOgrenciNo = "";
  double  pdfGenelNotOrt = 0.0;
  List<List<String>> pdfGecmisDersList = [];
  List<Map<String,dynamic>> pdfGecmisDersDataList = [];

  List<dynamic> _modelValuesList = [];
  OgrenciModel? _model;
  
  @observable
  List<Map<String , dynamic>> _ilgiAlanlari = [];

  @observable
  List<Map<String,dynamic>> _dersler = [];

  @observable
  bool _isModelLoading = false;

  @observable
  bool _isIlgiAlanlariLoading  = false;
 
  @observable
  bool _isDerslerLoading  = false;

  @observable
  FilePickerResult? _transkriptFile;

  List<dynamic>? get modelValues => _modelValuesList;
  List<Map<String , dynamic>> get ilgiAlanlari => _ilgiAlanlari;
  List<Map<String , dynamic>> get dersler => _dersler;
  OgrenciModel? get model => _model;
  bool get isModelLoading => _isModelLoading;
  bool get isIlgiAlanleriLoading => _isIlgiAlanlariLoading;
  bool get isDerslerLoading => _isDerslerLoading;
  FilePickerResult? get transkriptFile => _transkriptFile;

  @action
  Future<void> getCurrentUser(int id, SqlTableName tableName) async {
    _isModelLoading = true;
    _modelValuesList = await SqlSelectService.getUser(id, tableName);
    _model = OgrenciModel.fromListToModel(_modelValuesList);
    _isModelLoading = false;
  }
   
  @action
  Future<void> getAllIlgiAlani() async
  {
       _isIlgiAlanlariLoading =true;
       _ilgiAlanlari = await SqlSelectService.getAllIlgiAlani();
        _isIlgiAlanlariLoading =false;
  } 

   @action
  Future<void> getDersler() async
  {
       _isDerslerLoading =true;
       final tmpAllDersler = await SqlSelectService.getAllDersler();
       final tmpOgrenciGecmisVeriler = await SqlSelectService.getOgrenciGecmisData(_model!.id!);
       for(final tmp1 in tmpAllDersler)
       { 
         int syc = 0;
           for(final  tmp2 in tmpOgrenciGecmisVeriler)
           {
               if( tmp1["modalData"].id != tmp2[1])
               {
                    syc ++;
               }
               if(syc ==  tmpOgrenciGecmisVeriler.length)
               {
                 _dersler.add(tmp1);
               }
           }
       }
        _isDerslerLoading =false;
  } 
  
  Future<void> getSistemAyarlari() async
  {
     final sistemData  = await SqlSelectService.getSistemAyarlari();
     minAlinacakDers =int.parse(sistemData[4]);
     minIlgiAlani = int.parse(sistemData[1]);
     maxAlinacakDers =int.parse (sistemData[5]);
  }
 

  Future<void> gecmisVerileriEkle(int id) async
  {
          List<Map<String,dynamic>> allDers = [];
                  for(final gecmisDersMap in pdfGecmisDersDataList)
                  {    
                        int c = 0;
                       allDers =  await SqlSelectService.getAllDersler();
                        for(final dersDataMap in allDers)
           {
                         if(gecmisDersMap["dersAd"] != dersDataMap["modalData"].dersadi)
                         {
                          c++;
                         }
           }
                 if(c == allDers.length)
                  {
                      await SqlInsertService.addDers(gecmisDersMap["dersAd"],SqlTableName.dersler);
                  }
                     await SqlInsertService.addGecmisVeri(gecmisDersMap,id);  
                  }  
             
            

           }
  

  @action
  Future<void> pickFile() async {
    _transkriptFile = await FilePicker.platform.pickFiles();  
    final pdfFile = File(_transkriptFile!.paths[0]!);
    PdfDocument document =PdfDocument(inputBytes:pdfFile.readAsBytesSync());
    final toplamSayfaSayisi = document.pages.count;
   final List<TextLine> textLine =  PdfTextExtractor(document).extractTextLines(startPageIndex:0,endPageIndex:toplamSayfaSayisi-2);
      int count2 = 0;
      int syc = 0;
      List<Map<String,String>> datas = []; 
      String ogrenciNo =  "";
      String genelNotOrt = ""; 
      List<String> totalPdfData = [];
       for(final  line in textLine)
       {        
                     
             /*    debugPrint("${syc+1} . satır ==> ${line.text}");   */ 
                totalPdfData.add(line.text);
               syc++;
       }

       while(count2<syc)
  {
         count2++;
         debugPrint("while bas count22 ==> $count2");
         if(count2 == 5)
         { 
         debugPrint("ogrenci no");
          
            ogrenciNo =totalPdfData[count2-1];
         }
         if(count2 == 74)
          {
         debugPrint("genel not ort");

             genelNotOrt = totalPdfData[count2-1];
          }
         if(totalPdfData[count2-1].contains("Güz Dönemi") || totalPdfData[count2-1].contains("Bahar Dönemi") || totalPdfData[count2-1].contains("Muafiyet Dönemi") )
         { 
          debugPrint("ders veri alis");
             count2 += 15;
                  debugPrint("count22 ==> $count2");
             String dersAd = "";
             dersAd = totalPdfData[count2-1];
                  debugPrint("ders ad ==> ${totalPdfData[count2-1]}");
             String dersData = "";
             count2 += 2;
             dersData = totalPdfData[count2-1];
                  debugPrint("ders veri ==> ${totalPdfData[count2-1]}");
              datas.add({"dersAd":dersAd,"dersData":dersData});    
             bool isDersDataBitis = false;
              if(totalPdfData[count2].contains("DNO:") || totalPdfData[count2].contains("1 2 /")  ||  totalPdfData[count2].contains("1 3 /") || totalPdfData[count2].contains("2 3 /")|| totalPdfData[count2].contains("1 4 /")  ||  totalPdfData[count2].contains("2 4 /") || totalPdfData[count2].contains("3 4 /"))
              {
                 isDersDataBitis = true;
              }

             while(true)
             {
         debugPrint("ders alis devam");
                if(isDersDataBitis)
                {
                   break;
                }
                count2+=1;
                dersAd = totalPdfData[count2-1];
                  debugPrint("ders ad ==> ${totalPdfData[count2-1]}");
             count2 += 2;
             dersData = totalPdfData[count2-1];
                  debugPrint("ders veri ==> ${totalPdfData[count2-1]}");
              datas.add({"dersAd":dersAd,"dersData":dersData});    
                if(totalPdfData[count2].contains("DNO:") || totalPdfData[count2].contains("1 2 /")  ||  totalPdfData[count2].contains("1 3 /") || totalPdfData[count2].contains("2 3 /")|| totalPdfData[count2].contains("1 4 /")  ||  totalPdfData[count2].contains("2 4 /") || totalPdfData[count2].contains("3 4 /"))
              {
                 isDersDataBitis = true;
              }
             }
         } 
  } 

         
        for(final dersMap in datas)
        {
       debugPrint("ders ad ==> ${dersMap["dersAd"]}  ||  ders data ==> ${dersMap["dersData"]}");
           
        }
        
       debugPrint("ogrenci no ==> $ogrenciNo");
       debugPrint("genel not ort ==> ${genelNotOrt.split(":")[0]}");
       pdfGenelNotOrt = double.parse(genelNotOrt.split(":")[0]);
       pdfOgrenciNo = ogrenciNo;
       for(final gecmisDersMap in datas)
       {
             final dersAdList = gecmisDersMap["dersAd"]!.split(" ");
             String ad =" ";
             int x = 0;
             for(final tmpAd in dersAdList)
             {
                if(x != 0)
                {
                    ad += " $tmpAd";
                }
                x++;
             } 
             List<String> tmpDersDataList = gecmisDersMap["dersData"]!.split(" ");
             final dersDataList = [];
              int sc = 0;
              for(final value in tmpDersDataList)
              {
                  if(sc != tmpDersDataList.length-2)
                  {
                      dersDataList.add(value);  
                  }
                  sc++;
              }
             debugPrint("dersDataList ===>>> $dersDataList");
             debugPrint("dersAd ===>>> $ad");
             pdfGecmisDersDataList.add({"dersAd":ad,"dersData":dersDataList});
       } 
      
  }
}