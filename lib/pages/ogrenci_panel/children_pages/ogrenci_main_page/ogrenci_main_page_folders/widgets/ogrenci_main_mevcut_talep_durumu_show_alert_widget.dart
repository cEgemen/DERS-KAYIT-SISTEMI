import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../../../core/enums/sql_table_names_enum.dart';
import '../../../../../../core/services/sql_delete_service.dart';

import '../../../../../../core/components/space_widgets/horizontal_space_widget.dart';
import '../../../../../../core/constants/app_constant_dimensions/app_dimensions.dart';
import '../../../../../../core/services/sql_update_service.dart';
import '../../../../ogrenci_panel_folders/model/ogrenci_model.dart';
import '../view_model/ogrenci_main_view_model.dart';

class OgrenciMainMevcutTalepDurumuShowAlertWidget extends StatefulWidget {
  const OgrenciMainMevcutTalepDurumuShowAlertWidget({required OgrenciMainViewModel state, required OgrenciModel model, super.key})
      : _state = state,
        _model = model;
  final OgrenciMainViewModel _state;
  final OgrenciModel _model;

  @override
  State<OgrenciMainMevcutTalepDurumuShowAlertWidget> createState() => _OgrenciMainMevcutTalepDurumuShowAlertWidgetState();
}

class _OgrenciMainMevcutTalepDurumuShowAlertWidgetState extends State<OgrenciMainMevcutTalepDurumuShowAlertWidget> {
  @override
  void initState() {
    debugPrint("ogrenci_talep_durum_init metod is build");
    super.initState();
    widget._state.getOgrenciTalepDataList(widget._model.id!);
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
                  return widget._state.isOgrenciTalepDataLoading
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
                                      padding: const EdgeInsets.only(right: 5.0),
                                      child: Container(
                                        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                                          child: Text(
                                              "${index + 1}. Talep | Ders: ${widget._state.ogrenciTalepData[index]["dersAd"]} |Hoca: ${widget._state.ogrenciTalepData[index]["hocaData"][1]} |Talep Durum: ${widget._state.ogrenciTalepData[index]["talepData"][4]}"),
                                        ),
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                      onPressed: () async {
                                         await SqlUpdateService.updateOgrenciDersKalanTalepSayisi(widget._model.id!,widget._state.ogrenciTalepData[index]["dersData"][2],"${int.parse(widget._state.ogrenciTalepData[index]["dersData"][3])+1}");  
                                        await SqlDeleteService.deletData(
                                            widget._state.ogrenciTalepData[index]["talepData"][0], SqlTableName.ogrenciTalep);   
                                      },
                                      child: const Text("Sil")),
                                ],
                              ),
                            );
                          },
                          itemCount: widget._state.ogrenciTalepData.length,
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
        "Talep Gecmisi Ekranı",
        style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
      );
  HorizontalSpaceWidget _horizontalSmallSpaceWidget() => const HorizontalSpaceWidget(widget: AppConstantsDimensions.appSpaceSmall);

  HorizontalSpaceWidget _horizontalNormalSpaceWidget() => const HorizontalSpaceWidget(widget: AppConstantsDimensions.appSpaceNormal);
}
