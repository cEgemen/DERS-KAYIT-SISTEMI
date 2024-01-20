import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:yaz_lab_proje_1/core/services/sql_select_service.dart';
import '../view_model/ogrenci_dersler_ve_alanlar_view_model.dart';

import '../../../../../../../../core/components/space_widgets/horizontal_space_widget.dart';
import '../../../../../../../../core/constants/app_constant_dimensions/app_dimensions.dart';
import '../../../../../../ogrenci_panel_folders/model/ogrenci_model.dart';

class OgrenciIlgiAlanlariVeDersleri extends StatefulWidget {
  const OgrenciIlgiAlanlariVeDersleri({required OgrenciModel model, super.key}) : _model = model;
  final OgrenciModel _model;
  @override
  State<OgrenciIlgiAlanlariVeDersleri> createState() => _OgrenciIlgiAlanlariVeDersleriState();
}

class _OgrenciIlgiAlanlariVeDersleriState extends State<OgrenciIlgiAlanlariVeDersleri> {
  final OgrenciIlgiAlanlariVeDersleriViewModel _state = OgrenciIlgiAlanlariVeDersleriViewModel();
  @override
  void initState() {
    super.initState();
    _state.getDersData(widget._model.id!, widget._model.ogrenciDerslerId);
    _state.getIlgiAlanlariData(widget._model.ogrenciIlgiAlanlariId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _pageText(context),
          _horizontalNormalSpace(),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _ilgiAlanlariListesi(context),
                _dersListesi(context),
              ],
            ),
          ),
          _backButton(context),
        ],
      ),
    );
  }

  Widget _ilgiAlanlariListesi(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * .48,
        child: Column(
          children: [
            Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height * (.85),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "Ilgi Alanlari",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Expanded(child: Observer(builder: (_) {
                    return _state.isIlgiAlanlariLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 20),
                                child: Container(
                                  height: 60,
                                  decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 8.0, left: 5),
                                    child: Text("${index + 1}. Ilgi Alani : ${_state.ogrenciIlgiAlanlariData[index][1]}"),
                                  ),
                                ),
                              );
                            },
                            itemCount: _state.ogrenciIlgiAlanlariData.length,
                          );
                  }))
                ],
              ),
            ),
          ],
        ));
  }

  Widget _dersListesi(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * .48,
        child: Column(
          children: [
            Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height * (.85),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "Secilen Ders Durumları",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Expanded(child: Observer(builder: (_) {
                    return _state.isDerslerLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 20),
                                child: InkWell(
                                  onTap: _state.ogrenciDersData[index]["hocaData"].isEmpty
                                      ? null
                                      : () async {
                                          final hocaDersDataList =
                                              await SqlSelectService.getSpecialHocaDerslerData(_state.ogrenciDersData[index]["hocaData"][0]);
                                          await SqlSelectService.getSpecialHocaIlgiAlanlariData(_state.ogrenciDersData[index]["hocaData"][0])
                                              .then((value) {
                                            showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  content: SizedBox(
                                                    width: MediaQuery.of(context).size.width * .8,
                                                    height: MediaQuery.of(context).size.height * .7,
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            const SizedBox(),
                                                            const Text("Hoca Bilgileri"),
                                                            IconButton(
                                                                onPressed: () {
                                                                  Navigator.pop(context);
                                                                },
                                                                icon: const Icon(Icons.close))
                                                          ],
                                                        ),
                                                        const Divider(),
                                                        Expanded(
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Container(
                                                                  width: MediaQuery.of(context).size.width * .36,
                                                                  decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                                                                  child: Column(
                                                                    children: [
                                                                      const Center(
                                                                        child: Text("Hoca Ders Bilgileri"),
                                                                      ),
                                                                      Expanded(
                                                                        child: ListView.builder(
                                                                          itemBuilder: (context, index) {
                                                                            return Padding(
                                                                              padding: const EdgeInsets.all(10),
                                                                              child: Container(
                                                                                height: 60,
                                                                                decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.only(top: 20.0),
                                                                                  child: Text("Ders Adi : ${hocaDersDataList[index][1]}"),
                                                                                ),
                                                                              ),
                                                                            );
                                                                          },
                                                                          itemCount: hocaDersDataList.length,
                                                                        ),
                                                                      )
                                                                    ],
                                                                  )),
                                                              Container(
                                                                  width: MediaQuery.of(context).size.width * .36,
                                                                  decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                                                                  child: Column(
                                                                    children: [
                                                                      const Center(
                                                                        child: Text("Hoca IlgiAlanlari Bilgileri"),
                                                                      ),
                                                                      Expanded(
                                                                        child: ListView.builder(
                                                                          itemBuilder: (context, index) {
                                                                            return Padding(
                                                                              padding: const EdgeInsets.all(10),
                                                                              child: Container(
                                                                                height: 60,
                                                                                decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.only(top: 20.0),
                                                                                  child: Text("Ilgi Alani Adi : ${value[index][1]}"),
                                                                                ),
                                                                              ),
                                                                            );
                                                                          },
                                                                          itemCount: value.length,
                                                                        ),
                                                                      )
                                                                    ],
                                                                  )),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          });
                                        },
                                  child: Container(
                                    height: 60,
                                    decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 8.0, left: 5),
                                      child: Text(
                                          "${index + 1}. Ders : ${_state.ogrenciDersData[index]["dersData"][1]}  Hoca :${_state.ogrenciDersData[index]["hocaAd"]} "),
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: _state.ogrenciDersData.length,
                          );
                  }))
                ],
              ),
            ),
          ],
        ));
  }

  Center _pageText(BuildContext context) => Center(
        child: Text(
          "Ogrenci Ilgi Alanlari Ve Dersleri",
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
        ),
      );

  Row _backButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.keyboard_double_arrow_left_outlined)),
        _horizontalNormalSpace(),
      ],
    );
  }

  HorizontalSpaceWidget _horizontalNormalSpace() => const HorizontalSpaceWidget(widget: AppConstantsDimensions.appSpaceNormal);
}
