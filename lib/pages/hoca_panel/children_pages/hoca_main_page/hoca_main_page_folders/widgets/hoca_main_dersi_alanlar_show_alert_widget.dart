import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../../../core/components/space_widgets/horizontal_space_widget.dart';
import '../../../../../../core/constants/app_constant_dimensions/app_dimensions.dart';
import '../../../../hoca_panel_folder/model/hoca_model.dart';
import '../view_modal/hoca_main_page_view_model.dart';

class HocaMainDersiAlanlarShowAlertWidget extends StatefulWidget {
  const HocaMainDersiAlanlarShowAlertWidget({required HocaMainViewModel state, required HocaModel model, super.key})
      : _state = state,
        _model = model;
  final HocaMainViewModel _state;
  final HocaModel _model;

  @override
  State<HocaMainDersiAlanlarShowAlertWidget> createState() => _HocaMainDersiAlanlarShowAlertWidgetState();
}

class _HocaMainDersiAlanlarShowAlertWidgetState extends State<HocaMainDersiAlanlarShowAlertWidget> {
  @override
  void initState() {
    debugPrint("hoca_dersi_alanlar_init metod is build");
    super.initState();
    widget._state.getDersiOnaylananlarDataList(widget._model.id!);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      content: SizedBox(
          width: MediaQuery.of(context).size.width * .7,
          height: MediaQuery.of(context).size.height * .8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _horizontalSmallSpaceWidget(),
              _customAppBar(context),
              _horizontalNormalSpaceWidget(),
              Expanded(
                  child: Container(
                decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                child: Observer(builder: (_) {
                  return widget._state.isDersiAlanlarLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 15.0, left: 10, right: 20, top: 5),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 5.0),
                                      child: Container(
                                        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 10.0, bottom: 10, left: 15),
                                          child: Text(
                                              "${index + 1}. Ogrenci | ${widget._state.dersOnaylananlar[index]["ogrenciData"][1]} ${widget._state.dersOnaylananlar[index]["ogrenciData"][2]} | Ders : ${widget._state.dersOnaylananlar[index]["dersData"][1]}"),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          debugPrint("ilgiAlanlari => ${widget._state.dersOnaylananlar[index]["ogrenciIlgiAlanData"]}");
                                          debugPrint("dersler => ${widget._state.dersOnaylananlar[index]["ogrencidersData"]}");
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
                                                          SizedBox(),
                                                          Text("Ogrenci Ilgi Alanlari"),
                                                          IconButton(
                                                              onPressed: () {
                                                                Navigator.pop(context);
                                                              },
                                                              icon: Icon(Icons.close))
                                                        ],
                                                      ),
                                                      Divider(),
                                                      Expanded(
                                                          child: Container(
                                                        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                                                        child: ListView.builder(
                                                          itemBuilder: (context, index2) {
                                                            return Padding(
                                                              padding: const EdgeInsets.all(10.0),
                                                              child: Container(
                                                                decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                                                                child: Padding(
                                                                  padding: const EdgeInsets.only(top: 10.0, bottom: 10, left: 15),
                                                                  child: Text(
                                                                      "${index2 + 1}. Ilgi Alani : ${widget._state.dersOnaylananlar[index]["ogrenciIlgiAlanData"][index2]} "),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          itemCount: widget._state.dersOnaylananlar[index]["ogrenciIlgiAlanData"].length,
                                                        ),
                                                      ))
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: Text("Ilgi Alanlari")),
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
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
                                                        SizedBox(),
                                                        Text("Ogrenci Sectigi Dersler"),
                                                        IconButton(
                                                            onPressed: () {
                                                              Navigator.pop(context);
                                                            },
                                                            icon: Icon(Icons.close))
                                                      ],
                                                    ),
                                                    Divider(),
                                                    Expanded(
                                                        child: Container(
                                                      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                                                      child: ListView.builder(
                                                        itemBuilder: (context, index2) {
                                                          return Padding(
                                                            padding: const EdgeInsets.all(10.0),
                                                            child: Container(
                                                              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                                                              child: Padding(
                                                                padding: const EdgeInsets.only(top: 10.0, left: 10),
                                                                child: Text(
                                                                    "${index2 + 1}. Sectigi Dersler : ${widget._state.dersOnaylananlar[index]["ogrenciDersData"][index2]} "),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        itemCount: widget._state.dersOnaylananlar[index]["ogrenciDersData"].length,
                                                      ),
                                                    ))
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Text("Sectigi Dersler")),
                                ],
                              ),
                            );
                          },
                          itemCount: widget._state.dersOnaylananlar.length,
                        );
                }),
              ))
            ],
          )),
    );
  }

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

  Text _pageTitle(BuildContext context) => Text(
        "Dersi Alanlar Ekranı",
        style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
      );

  HorizontalSpaceWidget _horizontalLargeSpaceWidget() => const HorizontalSpaceWidget(widget: AppConstantsDimensions.appSpaceLarge);

  HorizontalSpaceWidget _horizontalSmallSpaceWidget() => const HorizontalSpaceWidget(widget: AppConstantsDimensions.appSpaceSmall);

  HorizontalSpaceWidget _horizontalNormalSpaceWidget() => const HorizontalSpaceWidget(widget: AppConstantsDimensions.appSpaceNormal);
}
