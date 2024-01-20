
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../../core/components/space_widgets/horizontal_space_widget.dart';
import '../../../../../../core/constants/app_constant_dimensions/app_dimensions.dart';
import '../../../../../../core/services/sql_insert_service.dart';
import '../../../../../../core/services/sql_update_service.dart';
import '../../../../ogrenci_panel_folders/model/ogrenci_model.dart';
import '../view_model/ogrenci_main_view_model.dart';

class OgrenciMainGelenTalepShowAlertWidget extends StatefulWidget {
  const OgrenciMainGelenTalepShowAlertWidget({required OgrenciMainViewModel state, required OgrenciModel model, super.key})
      : _state = state,
        _model = model;
  final OgrenciMainViewModel _state;
  final OgrenciModel _model;

  @override
  State<OgrenciMainGelenTalepShowAlertWidget> createState() => _OgrenciMainGelenTalepShowAlertWidgetState();
}

class _OgrenciMainGelenTalepShowAlertWidgetState extends State<OgrenciMainGelenTalepShowAlertWidget> {
  @override
  void initState() {
    debugPrint("ogrenci_gelen_talep_init metod is build");
    super.initState();
    widget._state.getHocaGelenTalepDataList(widget._model.id!);
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
                  return widget._state.isGelenTalepListLoading
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
                                              "${index + 1}. Talep  | ${widget._state.gelenTalepDataList[index]["dersData"][1]} Dersi| Hoca : ${widget._state.gelenTalepDataList[index]["hocaData"][1]} ${widget._state.gelenTalepDataList[index]["hocaData"][2]} "),
                                        ),
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                      onPressed:widget._state.dersSecimDurum != "0" ? null  :  () async {
               String kalanKontenjan =widget._state.gelenTalepDataList[index]["hocaData"][7]; 
        if(int.parse(kalanKontenjan) > 0)
        {
        await SqlUpdateService.hocaTalepTableUpdate(widget._state.gelenTalepDataList[index]["talepData"][0], "Onaylandı");
        await SqlInsertService.addOnaylanmisDers(widget._state.gelenTalepDataList[index]["talepData"][1], widget._state.gelenTalepDataList[index]["talepData"][2],
         widget._state.gelenTalepDataList[index]["talepData"][3]);
               await SqlUpdateService.updateHocaKalanKontenjanSayisi(widget._state.gelenTalepDataList[index]["hocaData"][0],"${int.parse(kalanKontenjan) -1 }"); 
            }
            else{
                   showDialog(context: context, builder: (context) {
                   return AlertDialog(
                          content: SizedBox(
                            width: MediaQuery.of(context).size.width*.6,
                            height: MediaQuery.of(context).size.height*.3,
                            child: Column(
                                children: [
                                    Row(
                                      children: [
                                        const SizedBox(),
                                        const Text("Bilgilendirme!!!"),
                                        IconButton(onPressed: () {
                                           Navigator.pop(context);
                                        }, icon:const Icon(Icons.close))
                                      ],
                                    ),
                                    const Divider(),
                                    const Center(child: Text("Kontenjan Dolu !!!"),),
                                ],
                            ),
                          ),
                   );
            },);

            }   
                                      },
                                      child:const Text("Onayla")),
                                      
                                ],
                              ),
                            );
                          },
                          itemCount: widget._state.gelenTalepDataList.length,
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
        "Gelen Talep Ekranı",
        style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
      );

  HorizontalSpaceWidget _horizontalSmallSpaceWidget() => const HorizontalSpaceWidget(widget: AppConstantsDimensions.appSpaceSmall);

  HorizontalSpaceWidget _horizontalNormalSpaceWidget() => const HorizontalSpaceWidget(widget: AppConstantsDimensions.appSpaceNormal);
}
