import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../../../core/services/sql_select_service.dart';
import '../../../../../../core/services/sql_update_service.dart';
import '../../../../../../core/components/space_widgets/horizontal_space_widget.dart';
import '../../../../../../core/constants/app_constant_dimensions/app_dimensions.dart';
import '../../../../hoca_panel_folder/model/hoca_model.dart';
import '../view_modal/hoca_main_page_view_model.dart';

class HocaMainTalepOlusturanlarShowAlertWidget extends StatefulWidget {
  const HocaMainTalepOlusturanlarShowAlertWidget({required HocaMainViewModel state, required HocaModel model, super.key})
      : _state = state,
        _model = model;
  final HocaMainViewModel _state;
  final HocaModel _model;

  @override
  State<HocaMainTalepOlusturanlarShowAlertWidget> createState() => _HocaMainTalepOlusturanlarShowAlertWidgetState();
}

class _HocaMainTalepOlusturanlarShowAlertWidgetState extends State<HocaMainTalepOlusturanlarShowAlertWidget> {
  @override
  void initState() {
    debugPrint("hoca_talep_olusturanlar_init metod is build");
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
                  return widget._state.isHocaTalepOlusturanlarListLoading
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
                                              "${index + 1}. Talep  | ${widget._state.hocaTalepOlusturanlarDataList[index]["dersData"][1]} Dersi| Ogrenci : ${widget._state.hocaTalepOlusturanlarDataList[index]["ogrenciData"][1]} ${widget._state.hocaTalepOlusturanlarDataList[index]["ogrenciData"][2]} "),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: ElevatedButton(
                                        onPressed: widget._state.dersSecimDurum != "0" ? null :   () async {
                                            if(int.parse(widget._model.kalankontenjan!) != 0)
                                           {
                                             await widget._state.onaylaButtonUpdate(index, widget._model.id!);
                                             await SqlUpdateService.updateHocaKalanKontenjanSayisi(widget._model.id!,"${int.parse(widget._model.kalankontenjan!) -1}");
                                           }
                                           else{
                                            String kalanTalep= await SqlSelectService.getSpecialOgrenciDersTalepSayisi(widget._state.hocaTalepOlusturanlarDataList[index]["ogrenciData"][0],widget._state.hocaTalepOlusturanlarDataList[index]["dersData"][0]);
                                        String yeniKalanTlep = "${int.parse(kalanTalep) + 1}";
                                             await SqlUpdateService.updateOgrenciDersKalanTalepSayisi(widget._state.hocaTalepOlusturanlarDataList[index]["ogrenciData"][0],widget._state.hocaTalepOlusturanlarDataList[index]["dersData"][0],yeniKalanTlep);
                                            _bildirimWidget(context);
                                           }
                                        },
                                        child: const Text("Onayla")),
                                  ),
                                  ElevatedButton(
                                      onPressed: widget._state.dersSecimDurum != "0" ? null :  () async {
                                        await widget._state.reddetButtonUpdate(index, widget._model.id!);
                                        String kalanTalep= await SqlSelectService.getSpecialOgrenciDersTalepSayisi(widget._state.hocaTalepOlusturanlarDataList[index]["ogrenciData"][0],widget._state.hocaTalepOlusturanlarDataList[index]["dersData"][0]);
                                        String yeniKalanTlep = "${int.parse(kalanTalep) + 1}";
                                        await SqlUpdateService.updateOgrenciDersKalanTalepSayisi(widget._state.hocaTalepOlusturanlarDataList[index]["ogrenciData"][0],widget._state.hocaTalepOlusturanlarDataList[index]["dersData"][0],yeniKalanTlep);
                                      },
                                      child: const Text("Reddet")),
                                ],
                              ),
                            );
                          },
                          itemCount: widget._state.hocaTalepOlusturanlarDataList.length,
                        );
                }),
              ))
            ],
          )),
    );
  }

  Future<dynamic> _bildirimWidget(BuildContext context) {
    return showDialog(context: context, builder:(context) {
                                                                               return AlertDialog(
                                                                                   content: SizedBox(
                                                                                      width: MediaQuery.of(context).size.width*.7,
                                                                                      height: MediaQuery.of(context).size.height*.3,
                                                                                     child: Column(
                                                                                      children: [
                                                                                         Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                          children: [
                                                    const SizedBox(),
                                                    const Text("Bilgilendirme !!!"),
                                                    IconButton(onPressed: () {
                                                          Navigator.pop(context);
                                                    }, icon: const Icon(Icons.close))
                                                                                          ],
                                                                                         ),
                                                                                     const Divider(),
                                                                      const Center(child: Text("Kontenjan Dolu O Yüzden Ekleyemzsiniz"))              

                                                                                      ],
                                                                                     ),
                                                                                   ),
                                                                               );
                                                                           },);
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
        "Talep Olusturanlar Ekranı",
        style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
      );

  HorizontalSpaceWidget _horizontalSmallSpaceWidget() => const HorizontalSpaceWidget(widget: AppConstantsDimensions.appSpaceSmall);

  HorizontalSpaceWidget _horizontalNormalSpaceWidget() => const HorizontalSpaceWidget(widget: AppConstantsDimensions.appSpaceNormal);
}
