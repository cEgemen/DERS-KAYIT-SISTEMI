import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

import '../../../../../../core/enums/sql_table_names_enum.dart';
import '../../../../../../core/enums/yonetici_panel_children_pages_name_enum.dart';
import '../../../../../../core/services/sql_delete_service.dart';
import '../../../../../../core/services/sql_insert_service.dart';
import '../../../../../../core/services/sql_select_service.dart';
import '../../../../../../core/services/sql_update_service.dart';
import '../../../../../y%C3%B6netici_panel/children/yonetici_main_page/children_pages/ayarlar_page/ayarlar_page_folder/view/ayarlar_page.dart';
import '../../../../../y%C3%B6netici_panel/children/yonetici_main_page/yonetici_main_page_folders/constants/yonetici_main_page_constants_strings/yonetici_main_page_constants_strings.dart';
import '../../children_pages/kullanicilar_page/view/kullanicilar_listesi_page.dart';

part 'yonetici_main_page_view_modal.g.dart';

class YoneticiMainPageViewModal = _YoneticiMainPageViewModalBase with _$YoneticiMainPageViewModal;

abstract class _YoneticiMainPageViewModalBase with Store {
  final YoneticiMainPageConstantsStrings _strings = YoneticiMainPageConstantsStrings.init;
  final TextEditingController _kullaniciNameCtrl = TextEditingController();
  final TextEditingController _kullaniciLastNameCtrl = TextEditingController();
  List<Map<String, dynamic>> gecmisTaleplerDataList = [];
  List<Map<String, dynamic>> mesajlar = [];
  List<dynamic> sistemAyarlariDataList = [];
  List<dynamic> dersSecimSistemAyarlariData = [];
  List<int> oncelikSirasi = [];
  List<int> atamaYapilacakDersler = [];
  List<String> sistemAyarlariNameList = [
    "id",
    "ilgi alani min sayi",
    "hoca min ders verme sayi",
    "hoca max ders verme sayi",
    "ogrenci min ders alma",
    "ogrenci max ders alma",
    "ogrenci talep sayi",
    "ogrenci farkli hoca secimi",
    "hoca kontenjan",
    "mesaj karekteri",
    "ders secim baslangıc",
    "ders secim bitis",
    "ders secim durum"
  ];
  final List<String> _kullaniciList = ["Hoca", "Ogrenci"];
  String _currentKullanici = "Hoca";
  DateTime? baslangic;
  DateTime? bitis;
  DateTime? guncelBitis;
  bool isDersSecimiReady = false;
  String baslamaDate = "***";
  String bitisData = "***";
  String guncelDate = "***";
  int maxMesajLength = -1;


  @observable
  bool isNext = false;

  @observable
  bool _isHaveMessage = false;

  @observable
  bool bitisDateSetLoading = false;

  @observable
  bool dersBitisLoading = false;

  @observable
  bool _isReadyReset = false;

  @observable
  bool _isReadyKayit = false;

  @observable
  bool _isGecmisTaleplerLoading = false;

  @observable
  bool _isSistemAyarlariLoading = false;

  YoneticiMainPageConstantsStrings get strings => _strings;
  TextEditingController get kullaniciNameCtrl => _kullaniciNameCtrl;
  TextEditingController get kullaniciLastNameCtrl => _kullaniciLastNameCtrl;
  bool get isReadyKayit => _isReadyKayit;
  bool get isReadReset => _isReadyReset;
  bool get isGecmisTaleplerLoading => _isGecmisTaleplerLoading;
  bool get isSistemAyarlariLoading => _isSistemAyarlariLoading;
  bool get isHaveMessage => _isHaveMessage;
  String get currentKullanici => _currentKullanici;
  List<String> get kullaniciList => _kullaniciList;

  @action
  Future<void> getAllGecmisTalepDataList() async {
    _isGecmisTaleplerLoading = true;
    gecmisTaleplerDataList = await SqlSelectService.getAllTalepler();
    _isGecmisTaleplerLoading = false;
  }

  @action
  void nextPage() {
    isNext = !isNext;
  }

  void getBaslamaDate() {
    baslangic = DateTime.now();
    Future.delayed(const Duration(milliseconds: 300));
    baslamaDate = DateFormat('yyyy-MM-dd').format(baslangic!);
    debugPrint("date => $baslamaDate");
  }

  @action
  void getBitisDate(int day) {
    dersBitisLoading = true;
    bitis = baslangic!.add(Duration(days: day));
    Future.delayed(const Duration(milliseconds: 300));
    bitisData = DateFormat('yyyy-MM-dd').format(bitis!);
    dersBitisLoading = false;
  }

  @action
  void getSetBitisDate(int day) {
    bitisDateSetLoading = true;
    guncelBitis = bitis!.add(Duration(days: day));
    Future.delayed(const Duration(milliseconds: 300));
    guncelDate = DateFormat('yyyy-MM-dd').format(guncelBitis!);
    bitisDateSetLoading = false;
  }

  Future<void> getDersSecimDates() async {
    dersSecimSistemAyarlariData = await SqlSelectService.getSistemAyarlariSpecilaValue();
    baslamaDate = dersSecimSistemAyarlariData[1];
    bitisData = dersSecimSistemAyarlariData[2];
    debugPrint("bitis String => $bitisData");
    bitis = DateTime.parse(bitisData);
    debugPrint("bitis DateTime => $bitis");
  }

  Future<void> onaylaButtonUpdate(int index, BuildContext context) async {
    final tabloName = gecmisTaleplerDataList[index]["tabloType"];
    if (tabloName == "ogrencitaleptable") {
      if (gecmisTaleplerDataList[index]["talepData"][4] != "Onaylandi") {
        String kalanKontenjan = gecmisTaleplerDataList[index]["hocaData"][7];
        if (int.parse(kalanKontenjan) > 0) {
          await SqlUpdateService.OgrenciTalepTableUpdate(gecmisTaleplerDataList[index]["talepData"][0], "Onaylandı");
          await SqlInsertService.addOnaylanmisDers(gecmisTaleplerDataList[index]["talepData"][2], gecmisTaleplerDataList[index]["talepData"][1],
              gecmisTaleplerDataList[index]["talepData"][3]);
          await SqlUpdateService.updateHocaKalanKontenjanSayisi(gecmisTaleplerDataList[index]["hocaData"][0], "${int.parse(kalanKontenjan) - 1}");
        } else {
          _kontenjanDoluBildirimWidget(context, index, "Ogrenci");
        }
      } else {
        _kontenjanDoluBildirimWidget2(context);
      }
    } else {
      if (gecmisTaleplerDataList[index]["talepData"][4] != "Onaylandi") {
        String kalanKontenjan = gecmisTaleplerDataList[index]["hocaData"][7];
        if (int.parse(kalanKontenjan) > 0) {
          bool isHaveThisLesson = await SqlSelectService.getSpecilDersAlindiMi(
              gecmisTaleplerDataList[index]["talepData"][3], gecmisTaleplerDataList[index]["talepData"][1]);
          if (isHaveThisLesson) {
            await SqlUpdateService.hocaTalepTableUpdate(gecmisTaleplerDataList[index]["talepData"][0], "Onaylandı");
            await SqlInsertService.addOnaylanmisDers(gecmisTaleplerDataList[index]["talepData"][2], gecmisTaleplerDataList[index]["talepData"][1],
                gecmisTaleplerDataList[index]["talepData"][3]);
            await SqlUpdateService.updateHocaKalanKontenjanSayisi(gecmisTaleplerDataList[index]["hocaData"][0], "${int.parse(kalanKontenjan) - 1}");
          } else {
            _kontenjanDoluBildirimWidget2(context);
          }
        } else {
          _kontenjanDoluBildirimWidget(context, index, "Hoca");
        }
      }
    }
  }

  Future<dynamic> _kontenjanDoluBildirimWidget2(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            width: MediaQuery.of(context).size.width * .6,
            height: MediaQuery.of(context).size.height * .3,
            child: Column(
              children: [
                Row(
                  children: [
                    const SizedBox(),
                    const Text("Bilgilendirme!!!"),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close))
                  ],
                ),
                const Divider(),
                const Center(
                  child: Text("Ogrenci Baska Bir Hocaya Kayitli"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> _kontenjanDoluBildirimWidget(BuildContext context, int index, String kullaniciType) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            width: MediaQuery.of(context).size.width * .6,
            height: MediaQuery.of(context).size.height * .3,
            child: Column(
              children: [
                Row(
                  children: [
                    const SizedBox(),
                    const Text("Bilgilendirme!!!"),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close))
                  ],
                ),
                const Divider(),
                const Center(
                  child: Text("Kontenjan Dolu !!!"),
                ),
                const Divider(),
                Center(
                  child: ElevatedButton(
                      onPressed: () async {
                        if (kullaniciType == "Ogrenci") {
                          await SqlUpdateService.OgrenciTalepTableUpdate(gecmisTaleplerDataList[index]["talepData"][0], "Onaylandı");
                        } else {
                          await SqlUpdateService.hocaTalepTableUpdate(gecmisTaleplerDataList[index]["talepData"][0], "Onaylandı");
                        }
                        await SqlInsertService.addOnaylanmisDers(gecmisTaleplerDataList[index]["talepData"][2],
                            gecmisTaleplerDataList[index]["talepData"][1], gecmisTaleplerDataList[index]["talepData"][3]);
                      },
                      child: const Text("Yinede Ekle")),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> reddetButtonUpdate(int index) async {
    final tabloName = gecmisTaleplerDataList[index]["tabloType"];
    debugPrint("tabbloName => $tabloName");
    if (tabloName == "ogrencitaleptable") {
      if (gecmisTaleplerDataList[index]["talepData"][4] != "Red Edildi") {
        await SqlUpdateService.OgrenciTalepTableUpdate(gecmisTaleplerDataList[index]["talepData"][0], "Red Edildi");
        if (gecmisTaleplerDataList[index]["talepData"][4] == "Onaylandi") {
          await SqlDeleteService.deletOanylanmisDersTableData(gecmisTaleplerDataList[index]["talepData"][1],
              gecmisTaleplerDataList[index]["talepData"][2], gecmisTaleplerDataList[index]["talepData"][3]);
          await SqlUpdateService.updateHocaKalanKontenjanSayisi(
              gecmisTaleplerDataList[index]["hocaData"][0], "${int.parse(gecmisTaleplerDataList[index]["hocaData"][7]) + 1}");
        }
        await SqlUpdateService.updateOgrenciDersKalanTalepSayisi(gecmisTaleplerDataList[index]["ogrenciData"][0],
            gecmisTaleplerDataList[index]["talepData"][3], "${int.parse(gecmisTaleplerDataList[index]["dersData"][3]) + 1}");
      }
    } else {
      if (gecmisTaleplerDataList[index]["talepData"][4] != "Red Edildi") {
        await SqlUpdateService.hocaTalepTableUpdate(gecmisTaleplerDataList[index]["talepData"][0], "Red Edildi");
        if (gecmisTaleplerDataList[index]["talepData"][4] == "Onaylandi") {
          await SqlDeleteService.deletOanylanmisDersTableData(gecmisTaleplerDataList[index]["talepData"][2],
              gecmisTaleplerDataList[index]["talepData"][1], gecmisTaleplerDataList[index]["talepData"][3]);
          await SqlUpdateService.updateHocaKalanKontenjanSayisi(
              gecmisTaleplerDataList[index]["hocaData"][0], "${int.parse(gecmisTaleplerDataList[index]["hocaData"][7]) + 1}");
        }
      }
    }
  }

  
  Future<void> silButtonUpdate(int index) async {
    final tabloName = gecmisTaleplerDataList[index]["tabloType"];
    if (tabloName == "ogrencitaleptable") {
      if (gecmisTaleplerDataList[index]["talepData"][4] == "Onaylandi") {
        await SqlDeleteService.deletOanylanmisDersTableData(gecmisTaleplerDataList[index]["talepData"][1],
            gecmisTaleplerDataList[index]["talepData"][2], gecmisTaleplerDataList[index]["talepData"][3]);
        await SqlUpdateService.updateHocaKalanKontenjanSayisi(
            gecmisTaleplerDataList[index]["hocaData"][0], "${int.parse(gecmisTaleplerDataList[index]["hocaData"][7]) + 1}");
      }
      await SqlDeleteService.deletData(gecmisTaleplerDataList[index]["talepData"][0], SqlTableName.ogrenciTalep);
      await SqlUpdateService.updateOgrenciDersKalanTalepSayisi(gecmisTaleplerDataList[index]["ogrenciData"][0],
          gecmisTaleplerDataList[index]["talepData"][3], "${int.parse(gecmisTaleplerDataList[index]["dersData"][3]) + 1}");
    } else {
      if (gecmisTaleplerDataList[index]["talepData"][4] == "Onaylandi") {
        await SqlDeleteService.deletOanylanmisDersTableData(gecmisTaleplerDataList[index]["talepData"][2],
            gecmisTaleplerDataList[index]["talepData"][1], gecmisTaleplerDataList[index]["talepData"][3]);
      }
      await SqlDeleteService.deletData(gecmisTaleplerDataList[index]["talepData"][0], SqlTableName.hoca);
    }
  }

  @action
  Future<void> getSistemAyarlari() async {
    _isSistemAyarlariLoading = true;
    List tmp = await SqlSelectService.getSistemAyarlari();
    maxMesajLength = int.parse(tmp[9]);
    isDersSecimiReady = tmp[tmp.length - 1] == "0" ? true : false;
    sistemAyarlariDataList = [];
    sistemAyarlariDataList.addAll(tmp);
    _isSistemAyarlariLoading = false;
  }

  Future<void> getMainPageSistemAyarlari() async {
    sistemAyarlariDataList = await SqlSelectService.getSistemAyarlari();
    isDersSecimiReady = sistemAyarlariDataList[sistemAyarlariDataList.length - 1] == "0" ? true : false;
    debugPrint("getMainPageSistemAyarlari =>>>> $sistemAyarlariDataList");
  }

  void _changeStateResetButton(bool value) {
    if (_isReadyReset != value) {
      _isReadyReset = value;
      return;
    }
  }

  void _changeStateKayitButton(bool value) {
    if (_isReadyKayit != value) {
      _isReadyKayit = value;
      return;
    }
  }

  void changeStateKullanici(String value) {
    if (_currentKullanici != value) {
      _currentKullanici = value;
      return;
    }
  }

  @action
  void kayitButtonState() {
    if (_kullaniciLastNameCtrl.text.isNotEmpty && _kullaniciNameCtrl.text.isNotEmpty) {
      _changeStateKayitButton(true);
      return;
    }
    _changeStateKayitButton(false);
  }

  @action
  void resetButtonState() {
    if (_kullaniciLastNameCtrl.text.isNotEmpty || _kullaniciNameCtrl.text.isNotEmpty) {
      _changeStateResetButton(true);
      return;
    }
    _changeStateResetButton(false);
  }

  void resetText() {
    _kullaniciNameCtrl.text = "";
    _kullaniciLastNameCtrl.text = "";
  }

  void toPage(BuildContext context, YoneticiPageChildrenPageName pageName) {
    switch (pageName) {
      case YoneticiPageChildrenPageName.ayarlar:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return const AyarlarPage();
          },
        ));
        break;
      case YoneticiPageChildrenPageName.islemKayitleri:
        break;
      case YoneticiPageChildrenPageName.kullanicilar:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return const KullanicilarListesiPage();
          },
        ));
        break;
      case YoneticiPageChildrenPageName.kullaniciEkle:
        throw Exception("Kullanici Ekle Sayfası Hatası");
    }
  }

  Future<void> randomOgrenciAtama() async {
    debugPrint("rastgele atama basladi");
    final dersHocaOgrenciMegaDataList = await SqlSelectService.getdersHocaOgrenciDataList();
    if (dersHocaOgrenciMegaDataList.isNotEmpty) {
      for (final megaDataMap in dersHocaOgrenciMegaDataList) {
        debugPrint("megaDataMap ===>>> $megaDataMap");
        bool almisMi = await SqlSelectService.getSpecilDersAlindiMi(megaDataMap["dersData"][0], megaDataMap["ogrenciData"].id);
        debugPrint("ogrenci dersi almis mi ===>>> $almisMi");
        if (!almisMi) {
          int randomHocaIndex = Random().nextInt(megaDataMap["hocaData"].length);
          debugPrint("dersi veren hoca sayisi => ${megaDataMap["hocaData"].length} AND üretilen random sayi => $randomHocaIndex");
          List<int> randomSayiList = [];
          while (true) {
            int hocaKalanKontenjanSayisi = int.parse(megaDataMap["hocaData"][randomHocaIndex]["hocaData"][7]);
            if (hocaKalanKontenjanSayisi > 0) {
              await SqlInsertService.addOnaylanmisDers(
                  megaDataMap["hocaData"][randomHocaIndex]["hocaData"][0], megaDataMap["ogrenciData"].id, megaDataMap["dersData"][0]);
              await SqlUpdateService.updateHocaKalanKontenjanSayisi(megaDataMap["hocaData"][randomHocaIndex]["hocaData"][0],
                  "${int.parse(megaDataMap["hocaData"][randomHocaIndex]["hocaData"][7]) - 1}");
              final tmpList = await SqlSelectService.getUser(megaDataMap["hocaData"][randomHocaIndex]["hocaData"][0], SqlTableName.hoca);
              debugPrint("eski hocaDataList ==>> ${megaDataMap["hocaData"][randomHocaIndex]["hocaData"]}");
              for (final tmpMegaDataMap in dersHocaOgrenciMegaDataList) {
                for (final tmp in tmpMegaDataMap["hocaData"]) {
                  if (tmp["hocaData"][0] == megaDataMap["hocaData"][randomHocaIndex]["hocaData"][0]) {
                    tmp["hocaData"] = [];
                    tmp["hocaData"].addAll(tmpList);
                    debugPrint("yeni hocaDataList ==>> ${tmp["hocaData"]}");
                  }
                }
              }

              break;
            }
            randomSayiList.add(randomHocaIndex);
            if (randomSayiList.length == megaDataMap["hocaData"].length) {
              await SqlInsertService.addOnaylanmisDers(
                  megaDataMap["hocaData"][randomHocaIndex]["hocaData"][0], megaDataMap["ogrenciData"].id, megaDataMap["dersData"][0]);
              break;
            }
            while (true) {
              randomHocaIndex = Random().nextInt(megaDataMap["hocaData"].length);
              int count = 0;
              for (final randomSayi in randomSayiList) {
                if (randomSayi == randomHocaIndex) {
                  count++;
                }
              }
              if (count == randomSayiList.length) {
                break;
              }
            }
          }
        }
      }
    }
  }

  @action
  Future<void> getAllMessageYonetici() async {
    final yoneticiData = await SqlSelectService.getYoneticiData();
    mesajlar = await SqlSelectService.getUserMesaj(yoneticiData[0]);
    if (mesajlar.isNotEmpty) {
      if (_isHaveMessage != true) {
        _isHaveMessage = true;
        return;
      }
    }
    if (_isHaveMessage != false) {
      _isHaveMessage = false;
    }
    return;
  }

  Future<void> genelNotOrtGoreDersEkleme() async {
    final dersHocaOgrenciMegaDataList = await SqlSelectService.getdersHocaOgrenciDataList2();
    debugPrint("genel not ort gore atama basladi AND DATA:LENGTH ==> ${dersHocaOgrenciMegaDataList.length}");
    if (dersHocaOgrenciMegaDataList.isNotEmpty) {
      for (final megaDataMap in dersHocaOgrenciMegaDataList) {
        debugPrint("basss  ");
        bool almisMi = await SqlSelectService.getSpecilDersAlindiMi(megaDataMap["dersData"][0], megaDataMap["ogrenciData"].id);
        debugPrint("ogrenci dersi almis mi ===>>> $almisMi");
        int doluHocaSayisi = 0;
        bool isAdd = false;
        if (!almisMi) {
          for (int oncelik in oncelikSirasi) {
            if (isAdd == false) {
              debugPrint("oncelik sirasi List ===> $oncelikSirasi");
              for (final hocaDataList in megaDataMap["hocaData"]) {
                debugPrint("oncelik bass $oncelik");
                if (oncelik == hocaDataList["hocaData"][0]) {
                  int hocaKalanKontenjanSayisi = int.parse(hocaDataList["hocaData"][7]);
                  if (hocaKalanKontenjanSayisi > 0) {
                    await SqlInsertService.addOnaylanmisDers(hocaDataList["hocaData"][0], megaDataMap["ogrenciData"].id, megaDataMap["dersData"][0]);
                    await SqlUpdateService.updateHocaKalanKontenjanSayisi(
                        hocaDataList["hocaData"][0], "${int.parse(hocaDataList["hocaData"][7]) - 1}");
                    final tmpList = await SqlSelectService.getUser(hocaDataList["hocaData"][0], SqlTableName.hoca);
                    debugPrint("eski hocaDataList ==>> ${hocaDataList["hocaData"]}");
                    for (final tmpMegaDataMap in dersHocaOgrenciMegaDataList) {
                      for (final tmp in tmpMegaDataMap["hocaData"]) {
                        if (tmp["hocaData"][0] == hocaDataList["hocaData"][0]) {
                          tmp["hocaData"] = [];
                          tmp["hocaData"].addAll(tmpList);
                          debugPrint("yeni hocaDataList ==>> ${tmp["hocaData"]}");
                        }
                      }
                    }
                    debugPrint("eklemeden cikis");
                    isAdd = true;
                    break;
                  } else {
                    doluHocaSayisi++;
                    debugPrint("kontenjan arttırımından cıkıs");
                    break;
                  }
                }
              }
            } else {
              break;
            }
          }
          if (doluHocaSayisi == megaDataMap["hocaData"].length) {
            final randomIndex = Random().nextInt(megaDataMap["hocaData"].length);
            await SqlInsertService.addOnaylanmisDers(
                megaDataMap["hocaData"][randomIndex]["hocaData"][0], megaDataMap["ogrenciData"].id, megaDataMap["dersData"][0]);
          }
        }
      }
    }
  }

  Future<void> belirliDerslereGoreDersEkleme() async {
    final dersHocaOgrenciMegaDataList = await SqlSelectService.getdersHocaOgrenciDataList3(atamaYapilacakDersler);
    debugPrint("belirli derslere gore atama basladi AND DATA:LENGTH ==> ${dersHocaOgrenciMegaDataList.length}");
    if (dersHocaOgrenciMegaDataList.isNotEmpty) {
      for (final megaData in dersHocaOgrenciMegaDataList) {
        debugPrint("basss  ");
        for (final ogrenciMapData in megaData["ogrenciData"]) {
          bool almisMi = await SqlSelectService.getSpecilDersAlindiMi(megaData["dersData"]["modalData"].id, ogrenciMapData["ogrenciData"][0]);
          debugPrint("ogrenci dersi almis mi ===>>> $almisMi");
          int doluHocaSayisi = 0;
          bool isAdd = false;
          if (!almisMi) {
            for (int oncelik in oncelikSirasi) {
              if (isAdd == false) {
                debugPrint("oncelik sirasi List ===> $oncelikSirasi");
                for (final hocaDataList in megaData["hocaData"]) {
                  debugPrint("oncelik bass $oncelik");
                  if (oncelik == hocaDataList["hocaData"][0]) {
                    int hocaKalanKontenjanSayisi = int.parse(hocaDataList["hocaData"][7]);
                    if (hocaKalanKontenjanSayisi > 0) {
                      await SqlInsertService.addOnaylanmisDers(
                          hocaDataList["hocaData"][0], ogrenciMapData["ogrenciData"][0], megaData["dersData"]["modalData"].id);
                      await SqlUpdateService.updateHocaKalanKontenjanSayisi(
                          hocaDataList["hocaData"][0], "${int.parse(hocaDataList["hocaData"][7]) - 1}");
                      final tmpList = await SqlSelectService.getUser(hocaDataList["hocaData"][0], SqlTableName.hoca);
                      debugPrint("eski hocaDataList ==>> ${hocaDataList["hocaData"]}");
                      for (final tmpMegaDataMap in dersHocaOgrenciMegaDataList) {
                        for (final tmp in tmpMegaDataMap["hocaData"]) {
                          if (tmp["hocaData"][0] == hocaDataList["hocaData"][0]) {
                            tmp["hocaData"] = [];
                            tmp["hocaData"].addAll(tmpList);
                            debugPrint("yeni hocaDataList ==>> ${tmp["hocaData"]}");
                          }
                        }
                      }
                      debugPrint("eklemeden cikis");
                      isAdd = true;
                      break;
                    } else {
                      doluHocaSayisi++;
                      debugPrint("kontenjan arttırımından cıkıs");
                      break;
                    }
                  }
                }
              } else {
                break;
              }
            }
            if (doluHocaSayisi == megaData["hocaData"].length) {
              final randomIndex = Random().nextInt(megaData["hocaData"].length);
              await SqlInsertService.addOnaylanmisDers(
                  megaData["hocaData"][randomIndex]["hocaData"][0], ogrenciMapData["ogrenciData"][0], megaData["dersData"]["modalData"].id);
            }
          }
        }
      }
    }
  }

  void dispose() {
    _strings.dispose();
  }
}
