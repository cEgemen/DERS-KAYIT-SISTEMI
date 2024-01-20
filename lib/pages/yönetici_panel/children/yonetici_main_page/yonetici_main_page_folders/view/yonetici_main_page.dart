import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:yaz_lab_proje_1/core/services/sql_insert_service.dart';
import '../../../../../y%C3%B6netici_panel/children/yonetici_main_page/children_pages/ayarlar_page/ayarlar_page_folder/view/ayarlar_page.dart';
import '../../../../../y%C3%B6netici_panel/children/yonetici_main_page/yonetici_main_page_folders/widgets/yonetici_main_ders_secimi_baslatma_show_alert_widget.dart';
import '../../../../../../core/enums/yonetici_panel_children_pages_name_enum.dart';
import '../../../../../../core/extensions/enums_extensions/yonetici_panel_children_page_name_extension.dart';
import '../../../../../y%C3%B6netici_panel/children/yonetici_main_page/yonetici_main_page_folders/widgets/y%C3%B6netici_main_page_kullan%C4%B1c%C4%B1_ekle_show_alert_widget.dart';
import '../../../../../../core/components/space_widgets/horizontal_space_widget.dart';
import '../../../../../../core/constants/app_constant_dimensions/app_dimensions.dart';
import '../view_modal/yonetici_main_page_view_modal.dart';
import '../widgets/yonetici_main_ayarlar_show_aleret_widget.dart';
import '../widgets/yonetici_main_belirli_derslere_gore_ekleme_show_alert_widget.dart';
import '../widgets/yonetici_main_ders_secim_ayarlari_show_alert_widget.dart';
import '../widgets/yonetici_main_gecmis_talepler_show_alert_widget.dart';
import '../widgets/yonetici_main_genel_not_ort_gore_ekleme_show_alert_widget.dart';
import '../widgets/yonetici_main_mesaj_show_alert_widget.dart';

class YoneticiMainPage extends StatefulWidget {
  const YoneticiMainPage({super.key});

  @override
  State<YoneticiMainPage> createState() => _YoneticiMainPageState();
}

class _YoneticiMainPageState extends State<YoneticiMainPage> {
  final YoneticiMainPageViewModal _state = YoneticiMainPageViewModal();
  @override
  void initState() {
    super.initState();
    _state.getMainPageSistemAyarlari();
    _state.getAllMessageYonetici();
    _state.getSistemAyarlari();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Text(
                "Yonetici Sistem Ekranı",
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
              ),
              IconButton(onPressed: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return YoneticiMainMesajShowAlertWidget(
                      state: _state,
                    );
                  },
                );
              }, icon: Observer(builder: (_) {
                return _state.isHaveMessage ? const Icon(Icons.mark_email_unread_outlined) : const Icon(Icons.local_post_office_outlined);
              }))
            ],
          ),
          _horizontalNormalSpace(),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _yoneticiMainPageCardWidget(context, YoneticiPageChildrenPageName.ayarlar),
                _yoneticiMainPageCardWidget(context, YoneticiPageChildrenPageName.islemKayitleri),
                _yoneticiMainPageCardWidget(context, YoneticiPageChildrenPageName.kullanicilar),
                _yoneticiMainPageCardWidget(context, YoneticiPageChildrenPageName.kullaniciEkle),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _asamaButonlariWidget("Ders Secimini Baslat", 0),
              _asamaButonlariWidget("2. Asamaya Geç", 1),
              _asamaButonlariWidget("Ders Secim Tarihleri Ayarı", 2),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.keyboard_double_arrow_left_outlined,
                    size: AppConstantsDimensions.appIconLarge,
                  )),
              SizedBox(
                width: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          _otomatikOlarakKullaniciEklemeWidget(context);
                        },
                        icon: const Icon(Icons.group_add_outlined)),
                    IconButton(
                        onPressed: () {
                          _state.getSistemAyarlari().then((value) {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => YoneticiMainAyarlarShowAlertWidget(
                                state: _state,
                              ),
                            );
                          });
                        },
                        icon: const Icon(Icons.settings)),
                  ],
                ),
              )
            ],
          ),
          _horizontalNormalSpace()
        ],
      ),
    );
  }

  Future<dynamic> _otomatikOlarakKullaniciEklemeWidget(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            width: MediaQuery.of(context).size.width * .6,
            height: MediaQuery.of(context).size.height * .3,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    const Text("Otomatik Kullanici Ekleme"),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close))
                  ],
                ),
                const Divider(),
                const Center(
                  child: Text("Otomatik Olarak Hangi  Kullanici Tipinde  Ekleme Yapmak İcin Asagıdaki Seceneklerden Secebilirsiniz"),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(onPressed: () async{
                            await SqlInsertService.otomatikOgrenciEkle(_state.sistemAyarlariDataList).then((value) {
                               Navigator.pop(context);
                            }); 
                      }, child: const Text("Ogrenci Ekle")),
                      ElevatedButton(onPressed: () {
                          String eklenecekHocaSayisi = "";
                              showDialog(barrierDismissible:false,context: context, builder: (context) {
                                    return AlertDialog(
                                         content: SizedBox(
                                          width: MediaQuery.of(context).size.width*.4,
                                          height: MediaQuery.of(context).size.height*.3,
                                          child: Column(
                                            children: [
                                                   Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                       const SizedBox(),
                                                       const Text("Eklenecek Hoca Sayisi"),
                                                       IconButton(onPressed: () {
                                                          Navigator.pop(context);
                                                       }, icon:const Icon(Icons.close))
                                                    ],
                                                   ),
                                                   const Divider(),
                                                  TextField(
                                                       keyboardType: TextInputType.number,
                                                       decoration: const InputDecoration(
                                                        hintText: "Eklenecek Hoca Sayisi",
                                                        border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.zero
                                                        )
                                                       ),
                                                      onChanged: (value) {
                                                          eklenecekHocaSayisi = value;
                                                      },
                                                  ) ,
                                                  ElevatedButton(onPressed:() async{
                                                      await  SqlInsertService.otomatikHocaEkle(_state.sistemAyarlariDataList,int.parse(eklenecekHocaSayisi)).then((value) {
                                                            Navigator.pop(context);
                                                      });
                                                  }, child:const Text("Otomatik Hoca Ata"))
                                            ],
                                          ),
                                         ),  
                                    );
                              },);
                      }, child: const Text("Hoca Ekle"))
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  InkWell _asamaButonlariWidget(String text, int buttonIndex) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: () {
        switch (buttonIndex) {
          case 0:
            debugPrint(
                "_state.sistemAyarlariDataList[_state.sistemAyarlariDataList.length-1] ==> ${_state.sistemAyarlariDataList[_state.sistemAyarlariDataList.length - 1]}");
            if (_state.sistemAyarlariDataList[_state.sistemAyarlariDataList.length - 1] != "0") {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return YoneticiMainDersSecimiBaslatmaShowAlertWidget(state: _state);
                },
              );
            } else {
              _bildirimDialogWidget("Ders Secimi Devam Ettigi Icin Ders Secimini Baslatamazsınız");
            }
            break;
          case 1:
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: SizedBox(
                    width: MediaQuery.of(context).size.width * .6,
                    height: MediaQuery.of(context).size.height * .3,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(),
                            const Text("2. Aşama Ders Secimi"),
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.close))
                          ],
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    _rastgeleAtamaWidget(context);
                                  },
                                  child: const Text("Demo Kullanım")),
                              ElevatedButton(
                                  onPressed: () {
                                    String durum = _state.sistemAyarlariDataList[_state.sistemAyarlariDataList.length - 1];
                                    if (durum == "1") {
                                      _rastgeleAtamaWidget(context);
                                    } else {
                                      String durum = _state.sistemAyarlariDataList[_state.sistemAyarlariDataList.length - 1] == "0"
                                          ? "Ders Secimi Devam Ettigi "
                                          : "Ders Secimi Baslamadigi";
                                      _bildirimDialogWidget("$durum Icin Ders Secimini Biteremezsiniz");
                                    }
                                  },
                                  child: const Text("2. Aşamaya Geciş"))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );

            break;
          case 2:
            if (_state.isDersSecimiReady) {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return YoneticiMainBitisDateAyarlariBaslatmaShowAlertWidget(state: _state);
                },
              );
            } else {
              String durum =
                  _state.sistemAyarlariDataList[_state.sistemAyarlariDataList.length - 1] == "1" ? "Ders Secimi Bittigi " : "Ders Secimi Baslamadigi";
              _bildirimDialogWidget("$durum Icin Ders Seciminin Bitis Tarihini Guncelleyemezsiniz");
            }
            break;
        }
      },
      child: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(color: Colors.yellow, borderRadius: BorderRadius.circular(100)),
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }

  Future<dynamic> _rastgeleAtamaWidget(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            width: MediaQuery.of(context).size.width * .6,
            height: MediaQuery.of(context).size.height * .3,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    const Text("2. Aşama Ders Secimi"),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close))
                  ],
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            debugPrint("rastgele atama basladi");
                            await _state.randomOgrenciAtama();
                          },
                          child: const Text("Random Ders Secimi")),
                      ElevatedButton(
                          onPressed: () {
                            showDialog(
                              barrierDismissible: false,
                              barrierColor: Colors.transparent,
                              context: context,
                              builder: (context) {
                                return YoneticiMainGenelNotOrtGoreEklemeShowAlertWidget(state: _state);
                              },
                            );
                          },
                          child: const Text("Genel Not Ort. Gore Ders Secimi")),
                      ElevatedButton(
                          onPressed: () {
                            showDialog(
                              barrierDismissible: false,
                              barrierColor: Colors.transparent,
                              context: context,
                              builder: (context) {
                                return YoneticiMainBelirliDerslereGoreEklemeShowAlertWidget(state: _state);
                              },
                            );
                          },
                          child: const Text("Belirli Derslere Gore Atama"))
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> _bildirimDialogWidget(String text) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            width: MediaQuery.of(context).size.width * .7,
            height: MediaQuery.of(context).size.height * .2,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    const Text("Bilgilendirme !!!"),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close))
                  ],
                ),
                const Divider(),
                Text(text),
              ],
            ),
          ),
        );
      },
    );
  }

  SizedBox _yoneticiMainPageCardWidget(BuildContext context, YoneticiPageChildrenPageName pageName) {
    return SizedBox(
      width: 250,
      height: 250,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppConstantsDimensions.appCirculeAvatarMinRadiusNormal),
        onTap: () {
          if (pageName == YoneticiPageChildrenPageName.kullaniciEkle) {
            showDialog(
              context: context,
              builder: (context) => YoneticiMainPageKullaniciEkleShowDialogWidget(
                state: _state,
              ),
            );
            return;
          } else if (pageName == YoneticiPageChildrenPageName.islemKayitleri) {
            showDialog(
              context: context,
              builder: (context) => YoneticiMainSistemdekiTaleplerShowAlertWidget(
                state: _state,
              ),
            );
            return;
          } else if (pageName == YoneticiPageChildrenPageName.ayarlar) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return const AyarlarPage();
              },
            ));
            return;
          }
          _state.toPage(context, pageName);
        },
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstantsDimensions.appCirculeAvatarMinRadiusNormal)),
          child: Center(
              child: Text(
            pageName.getName,
            style: Theme.of(context).textTheme.titleLarge,
          )),
        ),
      ),
    );
  }

  HorizontalSpaceWidget _horizontalNormalSpace() => const HorizontalSpaceWidget(widget: AppConstantsDimensions.appSpaceNormal);
}
