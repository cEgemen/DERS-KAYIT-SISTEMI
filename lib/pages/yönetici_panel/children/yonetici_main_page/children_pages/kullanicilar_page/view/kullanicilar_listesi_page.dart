import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../../../../core/enums/kullanici_type_enum.dart';
import '../../../../../../../core/services/sql_select_service.dart';
import '../../../../../../y%C3%B6netici_panel/children/yonetici_main_page/children_pages/kullanicilar_page/view_modal/kullanicilar_listesi_page.dart';
import '../../../../../../y%C3%B6netici_panel/children/yonetici_main_page/children_pages/kullanicilar_page/widgets/hoca_settings_information_show_alert_widget.dart';
import '../../../../../../y%C3%B6netici_panel/children/yonetici_main_page/children_pages/kullanicilar_page/widgets/ogrenci_settings_information_show_alert_widget.dart';

import '../../../../../../../core/components/space_widgets/horizontal_space_widget.dart';
import '../../../../../../../core/constants/app_constant_dimensions/app_dimensions.dart';
import '../widgets/hoca_ders_ilgi_alani_settings_show_alert_widget.dart';
import '../widgets/ogrenci_ders_ilgi_alani_settings_show_alert_widget.dart';

class KullanicilarListesiPage extends StatefulWidget {
  const KullanicilarListesiPage({super.key});

  @override
  State<KullanicilarListesiPage> createState() => _KullanicilarListesiPageState();
}

class _KullanicilarListesiPageState extends State<KullanicilarListesiPage> {
  final KullanicilarListesiPageViewModal _state = KullanicilarListesiPageViewModal();
  @override
  void initState() {
    super.initState();
    _getAllOgrenciList();
    _getAllHocaList();
  }

  @override
  Widget build(BuildContext context) {
    SqlSelectService.getAllOgrenci();
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Text(
              "Sistemdeki Kullanıcılar",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          _horizontalNormalSpace(),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_ogrenciListesiWidget(context), _hocaListesiWidget(context)],
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.keyboard_double_arrow_left_outlined,
                    size: AppConstantsDimensions.appIconLarge,
                  ))
            ],
          ),
          _horizontalSmallSpace(),
        ],
      ),
    );
  }

  Widget _hocaListesiWidget(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width * .48,
      child: Column(
        children: [
          Center(
            child: Text(
              "Hoca Listesi",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Observer(
            builder: (context) => _state.isLoadingHocaListesi
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: Scrollbar(
                      controller: _state.hocaScroll,
                      child: ListView.builder(
                        controller: _state.hocaScroll,
                        itemBuilder: (context, index) {
                          final hoca = _state.hocaListesi[index];
                          return _listTileWithDividerWidget(hoca, index);
                        },
                        itemCount: _state.hocaListesi.length,
                      ),
                    ),
                  ),
          )
        ],
      ),
    );
  }

  Widget _kullaniciInformationWidget(Map<String, dynamic> kullanici, int index) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        height: 60,
        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("   ${index + 1}."),
            Text("Ad = ${kullanici["modalData"].ad}"),
            Text("Soyad = ${kullanici["modalData"].soyad}"),
            Text("Sifre = ${kullanici["modalData"].sifre}    "),
          ],
        ),
      ),
    );
  }

  Widget _ogrenciListesiWidget(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width * .48,
      child: Column(
        children: [
          Center(
            child: Text(
              "Ogrenci Listesi",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          _horizontalSmallSpace(),
          Observer(
            builder: (context) => _state.isLoadingOgremciListesi
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: Scrollbar(
                      controller: _state.ogrenciScroll,
                      trackVisibility: true,
                      child: ListView.builder(
                        controller: _state.ogrenciScroll,
                        itemBuilder: (context, index) {
                          final ogrenci = _state.ogrenciListesi[index];
                          return _listTileWithDividerWidget(ogrenci, index);
                        },
                        itemCount: _state.ogrenciListesi.length,
                      ),
                    ),
                  ),
          )
        ],
      ),
    );
  }

  Column _listTileWithDividerWidget(Map<String, dynamic> kullanici, int index) {
    return Column(
      children: [
        ListTile(
          title: _kullaniciInformationWidget(kullanici, index),
          shape: const RoundedRectangleBorder(side: BorderSide(color: Colors.transparent)),
          onTap: () {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                switch (kullanici["modalData"].kullaniciType) {
                  case KullaniciType.hoca:
                    return AlertDialog(
                      content: SizedBox(
                        width: MediaQuery.of(context).size.width * .6,
                        height: MediaQuery.of(context).size.height * .2,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(),
                                Center(
                                  child: Text("Hoca Bilgi Güncelleme Alani"),
                                ),
                                IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(Icons.close))
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) => HocaSettingsInformationShowAlertWidget(kullanici: kullanici["modalData"]),
                                      );
                                    },
                                    child: Text("Kisisel Bilgiler")),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      showDialog(barrierDismissible: false,context: context, builder: (context) => HocaDersVeIlgiAlaniSetShowAlertWidget(model: kullanici));
                                    },
                                    child: Text("Verdigi Ders ve Ilgi Alanlari")),
                              ],
                            )
                          ],
                        ),
                      ),
                    );

                  case KullaniciType.ogrenci:
                    return AlertDialog(
                      content: SizedBox(
                        width: MediaQuery.of(context).size.width * .6,
                        height: MediaQuery.of(context).size.height * .2,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(),
                                Center(
                                  child: Text("Ogrenci Bilgi Güncelleme Alani"),
                                ),
                                IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(Icons.close))
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      showDialog(
                                        barrierDismissible: false,
                                          context: context,
                                          builder: (context) => OgrenciSettingsInformationShowAlertWidget(kullanici: kullanici["modalData"]));
                                    },
                                    child: Text("Kisisel Bilgiler")),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      showDialog(barrierDismissible:false,context: context, builder: (context) => OgrenciDersVeIlgiAlaniSetShowAlertWidget(model: kullanici));
                                    },
                                    child: Text("Aldigi Ders ve Ilgi Alanlari")),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  default:
                    throw Exception("Kullanici Type HATASIIIIIIIII !!!!!!!!");
                }
              },
            );
          },
        ),
        const Divider()
      ],
    );
  }

  void _getAllHocaList() {
    _state.getAllHoca();
  }

  void _getAllOgrenciList() {
    _state.getAllOgrenci();
  }

  HorizontalSpaceWidget _horizontalNormalSpace() => const HorizontalSpaceWidget(widget: AppConstantsDimensions.appSpaceNormal);

  HorizontalSpaceWidget _horizontalSmallSpace() => const HorizontalSpaceWidget(widget: AppConstantsDimensions.appSpaceSmall);
}
