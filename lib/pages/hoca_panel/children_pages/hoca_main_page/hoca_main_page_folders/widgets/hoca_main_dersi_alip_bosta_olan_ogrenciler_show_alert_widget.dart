import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../../core/components/space_widgets/horizontal_space_widget.dart';
import '../../../../../../core/constants/app_constant_dimensions/app_dimensions.dart';
import '../../../../../../core/services/sql_insert_service.dart';
import '../../../../hoca_panel_folder/model/hoca_model.dart';
import '../view_modal/hoca_main_page_view_model.dart';

List<Map<String,dynamic>> secileDersData = [];
class HocaMainDersiAlanBosOgrencilerShowAlertWidget extends StatefulWidget {
  const HocaMainDersiAlanBosOgrencilerShowAlertWidget({required HocaMainViewModel state, required HocaModel model, super.key})
      : _state = state,
        _model = model;
  final HocaMainViewModel _state;
  final HocaModel _model;

  @override
  State<HocaMainDersiAlanBosOgrencilerShowAlertWidget> createState() => _HocaMainDersiAlanBosOgrencilerShowAlertWidgetState();
}

class _HocaMainDersiAlanBosOgrencilerShowAlertWidgetState extends State<HocaMainDersiAlanBosOgrencilerShowAlertWidget> {
  @override
  void initState() {
    debugPrint("hoca_main_ders_alanlar_fakat_bosta_olanlar_widget_init metod is build");
    super.initState();
    widget._state.getDersData(widget._model.hocaDerslerId);
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
                        return widget._state.isDersloading
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
                                          hintText: "Not Ortalaması Search",
                                          prefixIcon: Icon(Icons.search_outlined),
                                          border: OutlineInputBorder(borderRadius: BorderRadius.zero)),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      itemBuilder: (context, index) {
                                        debugPrint("index => $index AND list.length => ${widget._state.hocaDersData.length}");
                                        return index == widget._state.hocaDersData.length
                                            ? _topButtonsWidget("Bütün Dersler", index)
                                            : _topButtonsWidget(widget._state.hocaDersData[index][1], index);
                                      },
                                      itemCount: widget._state.hocaDersData.length + 1,
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
                          builder: (context) => widget._state.isFilterOgrenciLoading
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
                                                Text("${index + 1}. Ogrenci"),
                                                Text("Ad : ${widget._state.filterOgrenciData[index]["ogrenciData"][1]}"),
                                                Text("Soyad : ${widget._state.filterOgrenciData[index]["ogrenciData"][2]}"),
                                                Text("Ders : ${widget._state.filterOgrenciData[index]["dersData"][1]}")
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
                                                        onPressed: () async {
                                                          widget._state.getCurrentOgrenciIlgiAlanlari(
                                                              widget._state.filterOgrenciData[index]["ogrenciData"][0]);
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
                                                                              builder: (_) => widget._state.isCurrentOgrenciIlgiAlanlariLoading
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
                                                                                                  "${index + 1}. Ilgi Alani : ${widget._state.currentOgrenciIlgiAlanlari[index]}"),
                                                                                            ),
                                                                                          ),
                                                                                        );
                                                                                      },
                                                                                      itemCount: widget._state.currentOgrenciIlgiAlanlari.length,
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
                                                          widget._state
                                                              .getCurrentOgrenciDersler(widget._state.filterOgrenciData[index]["ogrenciData"][0]);
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
                                                                          const Text("Aldıgı Dersler"),
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
                                                                              builder: (_) => widget._state.isCurrentOgrenciDerslerLoading
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
                                                                                                  "${index + 1}. Ders : ${widget._state.currentOgrenciDersler[index]}"),
                                                                                            ),
                                                                                          ),
                                                                                        );
                                                                                      },
                                                                                      itemCount: widget._state.currentOgrenciDersler.length,
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
                                                        child: const Text("Aldıgı Dersler")),
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
                                                                        height: MediaQuery.of(context).size.height * .6,
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
                                                                                        if (mesaj.isNotEmpty) {
                                                                                          await SqlInsertService.addMesaj(
                                                                                              widget._model.id!,
                                                                                              widget._state.filterOgrenciData[index]["ogrenciData"]
                                                                                                  [0],
                                                                                              mesaj,
                                                                                              "Hoca");
                                                                                        }
                                                                                        debugPrint("hocaTalep hocaid => ${widget._model.id!}");
                                                                                        debugPrint(
                                                                                            "hocaTalep ogrenciid => ${widget._state.filterOgrenciData[index]["ogrenciData"][0]}");
                                                                                        debugPrint(
                                                                                            "hocaTalep dersid => ${widget._state.filterOgrenciData[index]["dersData"][0]}");
                                                                                        await SqlInsertService.addHocaTalep(
                                                                                            widget._model.id!,
                                                                                            widget._state.filterOgrenciData[index]["ogrenciData"][0],
                                                                                            widget._state.filterOgrenciData[index]["dersData"][0]).then((value) {
  Navigator.pop(context);
                                                                                            });

                                                                                       
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
                                  itemCount: widget._state.filterOgrenciData.length,
                                ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ])));
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
        await widget._state.getFilteOgrenciData(index, widget._state.textCtrl.text);
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

