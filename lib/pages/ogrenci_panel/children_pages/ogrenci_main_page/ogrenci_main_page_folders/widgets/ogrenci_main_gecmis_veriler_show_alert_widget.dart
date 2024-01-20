import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:yaz_lab_proje_1/pages/ogrenci_panel/children_pages/ogrenci_main_page/ogrenci_main_page_folders/view_model/ogrenci_main_view_model.dart';
import 'package:yaz_lab_proje_1/pages/ogrenci_panel/ogrenci_panel_folders/model/ogrenci_model.dart';

import '../../../../../../core/components/space_widgets/horizontal_space_widget.dart';
import '../../../../../../core/constants/app_constant_dimensions/app_dimensions.dart';

class OgrenciMainGecmisVerilerShowAlertWidget extends StatefulWidget {
  const OgrenciMainGecmisVerilerShowAlertWidget({required OgrenciMainViewModel state, required OgrenciModel model, super.key})
      : _state = state,
        _model = model;

  final OgrenciMainViewModel _state;
  final OgrenciModel _model;

  @override
  State<OgrenciMainGecmisVerilerShowAlertWidget> createState() => _OgrenciMainGecmisVerilerShowAlertWidgetState();
}

class _OgrenciMainGecmisVerilerShowAlertWidgetState extends State<OgrenciMainGecmisVerilerShowAlertWidget> {
  @override
  void initState() {
    debugPrint("ogrenci_gecmis_veriler_init metod is build");
    super.initState();
    widget._state.getAllGecmisVeri(widget._model.id!);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      content: SizedBox(
          width: MediaQuery.of(context).size.width * .9,
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
                  return widget._state.gecmisVerilerLoading
                      ? const Center(
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
                                      padding: const EdgeInsets.all(20.0),
                                      child: Container(
                                        height: 70,
                                        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                                          child: Text(
                                              "Ders : ${widget._state.ogrenciGecmisVeriler[index]["dersAd"]} | Ders Statü : ${widget._state.ogrenciGecmisVeriler[index]["dersData"][3]} | Ogretim Dili : ${widget._state.ogrenciGecmisVeriler[index]["dersData"][4]} | T: ${widget._state.ogrenciGecmisVeriler[index]["dersData"][5]} | U : ${widget._state.ogrenciGecmisVeriler[index]["dersData"][6]} | UK : ${widget._state.ogrenciGecmisVeriler[index]["dersData"][7]} |  AKTS : ${widget._state.ogrenciGecmisVeriler[index]["dersData"][8]} | Not : ${widget._state.ogrenciGecmisVeriler[index]["dersData"][9]} | Puan : ${widget._state.ogrenciGecmisVeriler[index]["dersData"][10]} |  Aciklama : ${widget._state.ogrenciGecmisVeriler[index]["dersData"][11]} "),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          itemCount: widget._state.ogrenciGecmisVeriler.length,
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
        "Gecmis Veri Bilgileri",
        style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
      );

  HorizontalSpaceWidget _horizontalSmallSpaceWidget() => const HorizontalSpaceWidget(widget: AppConstantsDimensions.appSpaceSmall);

  HorizontalSpaceWidget _horizontalNormalSpaceWidget() => const HorizontalSpaceWidget(widget: AppConstantsDimensions.appSpaceNormal);
}
