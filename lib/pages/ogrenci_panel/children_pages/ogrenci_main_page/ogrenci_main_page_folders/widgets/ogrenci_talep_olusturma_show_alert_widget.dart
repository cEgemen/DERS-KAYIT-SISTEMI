import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../../../core/services/sql_update_service.dart';
import '../../../../../../core/services/sql_insert_service.dart';

import '../../../../../../core/components/space_widgets/horizontal_space_widget.dart';
import '../../../../../../core/constants/app_constant_dimensions/app_dimensions.dart';
import '../../../../ogrenci_panel_folders/model/ogrenci_model.dart';
import '../view_model/ogrenci_main_view_model.dart';

class OgrenciTalepOlusturmaShowAlertWidget extends StatefulWidget {
  const OgrenciTalepOlusturmaShowAlertWidget({required OgrenciMainViewModel state, required OgrenciModel model, super.key})
      : _state = state,
        _model = model;
  final OgrenciMainViewModel _state;
  final OgrenciModel _model;

  @override
  State<OgrenciTalepOlusturmaShowAlertWidget> createState() => _OgrenciTalepOlusturmaShowAlertWidgetState();
}

class _OgrenciTalepOlusturmaShowAlertWidgetState extends State<OgrenciTalepOlusturmaShowAlertWidget> {
  @override
  void initState() {
    debugPrint("ogrenci_talep_olusturma_init metod is build");
    super.initState();
    widget._state.getDersData(widget._model.ogrenciDerslerId);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        scrollable: true,
        content: SizedBox(
            width: MediaQuery.of(context).size.width * .7,
            height: MediaQuery.of(context).size.height * .8,
            child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              _horizontalSmallSpaceWidget(),
              _customAppBar(context),
              _horizontalNormalSpaceWidget(),
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * .2,
                      decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey)),
                      child: Observer(builder: (_) {
                        return widget._state.isDerslerLoading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: TextField(
                                      controller: widget._state.textCtrl,
                                      decoration: const InputDecoration(
                                          hintText: "Ilgi Alanlari Search",
                                          prefixIcon: Icon(Icons.search_outlined),
                                          border: OutlineInputBorder(borderRadius: BorderRadius.zero)),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      itemBuilder: (context, index) {
                                        debugPrint("index => $index AND list.length => ${widget._state.ogrenciDersData.length}");
                                        return index == widget._state.ogrenciDersData.length
                                            ? _topButtonsWidget("Bütün Dersler", index)
                                            : _topButtonsWidget(widget._state.ogrenciDersData[index][1], index);
                                      },
                                      itemCount: widget._state.ogrenciDersData.length + 1,
                                    ),
                                  ),
                                ],
                              );
                      }),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey)),
                        child: Observer(
                          builder: (context) => widget._state.isFilterHocaLoading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : ListView.builder(
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 5, bottom: 15.0, left: 5, right: 5),
                                      child: Container(
                                        height: 150,
                                        width: 200,
                                        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                                        child: Row(
                                          children: [
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("${index + 1}. Hoca"),
                                                Text("Ad : ${widget._state.filterHocaData[index]["hocaData"][1]}"),
                                                Text("Soyad : ${widget._state.filterHocaData[index]["hocaData"][2]}"),
                                                Text("Ders : ${widget._state.filterHocaData[index]["dersData"][1]}")
                                              ],
                                            ),
                                            _defaultVerticalDivider(),
                                            Expanded(
                                                child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          widget._state
                                                              .getCurrentHocaIlgiAlanlari(widget._state.filterHocaData[index]["hocaData"][0]);
                                                          showDialog(
                                                            barrierDismissible: false,
                                                            context: context,
                                                            builder: (context) {
                                                              return AlertDialog(
                                                                content: SizedBox(
                                                                  width: MediaQuery.of(context).size.width * .4,
                                                                  height: MediaQuery.of(context).size.height * .6,
                                                                  child: Column(
                                                                    children: [
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          const SizedBox(),
                                                                          const Text("Ilgi Alanalri"),
                                                                          IconButton(
                                                                              onPressed: () {
                                                                                Navigator.pop(context);
                                                                              },
                                                                              icon: const Icon(Icons.close))
                                                                        ],
                                                                      ),
                                                                      Expanded(
                                                                        child: Container(
                                                                          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                                                                          child: Observer(
                                                                              builder: (_) => widget._state.isCurrentHocaIlgiAlanlariLoading
                                                                                  ? const Center(
                                                                                      child: CircularProgressIndicator(),
                                                                                    )
                                                                                  : ListView.builder(
                                                                                      itemBuilder: (context, index) {
                                                                                        return Padding(
                                                                                          padding: const EdgeInsets.all(10.0),
                                                                                          child: Container(
                                                                                            height: 50,
                                                                                            decoration:
                                                                                                BoxDecoration(border: Border.all(color: Colors.grey)),
                                                                                            child: Padding(
                                                                                              padding: const EdgeInsets.only(top: 10.0),
                                                                                              child: Text(
                                                                                                  "${index + 1}. Ilgi Alani : ${widget._state.currentHocaIlgiAlanlari[index]}"),
                                                                                            ),
                                                                                          ),
                                                                                        );
                                                                                      },
                                                                                      itemCount: widget._state.currentHocaIlgiAlanlari.length,
                                                                                    )),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        },
                                                        child: const Text("İlgi Alani")),
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          widget._state.getCurrentHocaDersler(widget._state.filterHocaData[index]["hocaData"][0]);
                                                          showDialog(
                                                            barrierDismissible: false,
                                                            context: context,
                                                            builder: (context) {
                                                              return AlertDialog(
                                                                content: SizedBox(
                                                                  width: MediaQuery.of(context).size.width * .4,
                                                                  height: MediaQuery.of(context).size.height * .6,
                                                                  child: Column(
                                                                    children: [
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          const SizedBox(),
                                                                          const Text("Verdigi Dersler"),
                                                                          IconButton(
                                                                              onPressed: () {
                                                                                Navigator.pop(context);
                                                                              },
                                                                              icon: const Icon(Icons.close))
                                                                        ],
                                                                      ),
                                                                      Expanded(
                                                                        child: Container(
                                                                          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                                                                          child: Observer(
                                                                              builder: (_) => widget._state.isCurrentHocaDerslerLoading
                                                                                  ? const Center(
                                                                                      child: CircularProgressIndicator(),
                                                                                    )
                                                                                  : ListView.builder(
                                                                                      itemBuilder: (context, index) {
                                                                                        return Padding(
                                                                                          padding: const EdgeInsets.all(10.0),
                                                                                          child: Container(
                                                                                            height: 50,
                                                                                            decoration:
                                                                                                BoxDecoration(border: Border.all(color: Colors.grey)),
                                                                                            child: Padding(
                                                                                              padding: const EdgeInsets.only(top: 10.0),
                                                                                              child: Text(
                                                                                                  "${index + 1}. Ders : ${widget._state.currentHocaDersler[index]}"),
                                                                                            ),
                                                                                          ),
                                                                                        );
                                                                                      },
                                                                                      itemCount: widget._state.currentHocaDersler.length,
                                                                                    )),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        },
                                                        child: const Text("Verdigi Dersler")),
                                                    ElevatedButton(
                                                        onPressed: widget._state.dersSecimDurum != "0"
                                                            ? null
                                                            : () {
                                                                String mesaj = "";
                                                                showDialog(
                                                                  barrierDismissible: false,
                                                                  context: context,
                                                                  builder: (context) {
                                                                    return AlertDialog(
                                                                      content: SizedBox(
                                                                        width: MediaQuery.of(context).size.width * .3,
                                                                        height: MediaQuery.of(context).size.height * .5,
                                                                        child: Column(
                                                                          children: [
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                const SizedBox(),
                                                                                const Text("Talep Olustur"),
                                                                                IconButton(
                                                                                    onPressed: () {
                                                                                      Navigator.pop(context);
                                                                                    },
                                                                                    icon: const Icon(Icons.close))
                                                                              ],
                                                                            ),
                                                                            TextField(
                                                                              maxLines: 7,
                                                                              maxLength: widget._state.maxMesajUzunlugu,
                                                                              onChanged: (value) {
                                                                                mesaj = value;
                                                                              },
                                                                              decoration: const InputDecoration(
                                                                                  border: OutlineInputBorder(borderRadius: BorderRadius.zero)),
                                                                            ),
                                                                            _horizontalSmallSpaceWidget(),
                                                                            ElevatedButton(
                                                                                onPressed: widget._state.dersSecimDurum != "0"
                                                                                    ? null
                                                                                    : () async {
                                                                                        await widget._state.getPermission(
                                                                                            widget._state.filterHocaData[index]["hocaData"][0],
                                                                                            widget._model.id!,
                                                                                            widget._state.filterHocaData[index]["dersData"][0]);
                                                                                        debugPrint(
                                                                                            "isPermession ===> ${widget._state.isHavePermission}");
                                                                                        debugPrint(
                                                                                            "isDersiAlmısMi ===> ${widget._state.isDersiAlmisMi}");
                                                                                        debugPrint(
                                                                                            "baskahocadan alma durumu ===> ${widget._state.ogrencifarklihocasecme}");
                                                                                        debugPrint(
                                                                                            "dersKalanTalepSayisi===> ${widget._state.ogrenciDersTalepSay}");
                                                                                        debugPrint(
                                                                                            "maxMesajLength ===> ${widget._state.maxMesajUzunlugu}");
                                                                                        if ((widget._state.ogrencifarklihocasecme == "true" ||
                                                                                                (widget._state.ogrencifarklihocasecme == "false" &&
                                                                                                    widget._state.isHavePermission)) &&
                                                                                            !widget._state.isDersiAlmisMi) {
                                                                                          if ((widget._state.ogrenciDersTalepSay != 0)) {
                                                                                            if (mesaj.isNotEmpty) {
                                                                                              await SqlInsertService.addMesaj(
                                                                                                  widget._model.id!,
                                                                                                  widget._state.filterHocaData[index]["hocaData"][0],
                                                                                                  mesaj,
                                                                                                  "Ogrenci");
                                                                                            }
                                                                           debugPrint(
                                                               "ogrenciTalep ogrenciid => ${widget._model.id!}");
                                                                                            debugPrint(
                                                                                                "ogrenciTalep hocaid => ${widget._state.filterHocaData[index]["hocaData"][0]}");
                                                                                            debugPrint(
                                                                                                "ogrenciTalep dersid => ${widget._state.filterHocaData[index]["dersData"][0]}");
                                                                                            await SqlInsertService.addOgrenciTalep(
                                                                                                widget._model.id!,
                                                                                                widget._state.filterHocaData[index]["hocaData"][0],
                                                                                                widget._state.filterHocaData[index]["dersData"][0]);
                                                                                            debugPrint("");
                                                                                            await SqlUpdateService.updateOgrenciDersKalanTalepSayisi(
                                                                                                widget._model.id!,
                                                                                                widget._state.filterHocaData[index]["dersData"][0],
                                                                                                "${widget._state.ogrenciDersTalepSay - 1}");
                                                                                            Navigator.pop(context);
                                                                                          } else {
                                                                                            // ignore: use_build_context_synchronously
                                                                                            _bildirimWidget(context);
                                                                                          }
                                                                                        } else {
                                                                                          // ignore: use_build_context_synchronously
                                                                                          _bildirimWidget(context);
                                                                                        }
                                                                                      },
                                                                                child: const Text("Talep Olustur"))
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                        child: const Text("Talep Olustur")),
                                                  ],
                                                )
                                              ],
                                            ))
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: widget._state.filterHocaData.length,
                                ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ])));
  }

  Future<dynamic> _bildirimWidget(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            width: MediaQuery.of(context).size.width * .7,
            height: MediaQuery.of(context).size.height * .3,
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
                const Text("Talimatlar Geregi Talep Olusturma Durumlarını Karsılamıyorusnuz")
              ],
            ),
          ),
        );
      },
    );
  }

  VerticalDivider _defaultVerticalDivider() => const VerticalDivider();

  Row _customAppBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(),
        _pageTitle(context),
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close))
      ],
    );
  }

  InkWell _topButtonsWidget(String buttonName, int index) {
    return InkWell(
      onTap: () async {
        debugPrint(buttonName);
        widget._state.changeStateTopButtons(buttonName);
        await widget._state.getFilteHocaData(index, widget._state.textCtrl.text);
        debugPrint("textCtrl.text => ${widget._state.textCtrl.text}");
        setState(() {});
      },
      child: SizedBox(
        width: 200,
        height: 60,
        child: widget._state.currentSelectButton == buttonName
            ? Card(
                color: Colors.purple.shade200,
                child: Center(child: Text(buttonName)),
              )
            : Card(
                color: Colors.grey.shade200,
                child: Center(child: Text(buttonName)),
              ),
      ),
    );
  }

  Text _pageTitle(BuildContext context) => Text(
        "Talep Olusturma Ekranı",
        style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
      );

  HorizontalSpaceWidget _horizontalSmallSpaceWidget() => const HorizontalSpaceWidget(widget: AppConstantsDimensions.appSpaceSmall);

  HorizontalSpaceWidget _horizontalNormalSpaceWidget() => const HorizontalSpaceWidget(widget: AppConstantsDimensions.appSpaceNormal);
}
