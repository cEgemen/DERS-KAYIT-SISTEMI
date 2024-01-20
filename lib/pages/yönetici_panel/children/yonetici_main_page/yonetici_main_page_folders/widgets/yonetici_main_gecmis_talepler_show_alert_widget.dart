import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../../core/components/space_widgets/horizontal_space_widget.dart';
import '../../../../../../core/constants/app_constant_dimensions/app_dimensions.dart';
import '../view_modal/yonetici_main_page_view_modal.dart';

class YoneticiMainSistemdekiTaleplerShowAlertWidget extends StatefulWidget {
  const YoneticiMainSistemdekiTaleplerShowAlertWidget({required YoneticiMainPageViewModal state, super.key}) : _state = state;
  final YoneticiMainPageViewModal _state;

  @override
  State<YoneticiMainSistemdekiTaleplerShowAlertWidget> createState() => _YoneticiMainSistemdekiTaleplerShowAlertWidgetState();
}

class _YoneticiMainSistemdekiTaleplerShowAlertWidgetState extends State<YoneticiMainSistemdekiTaleplerShowAlertWidget> {
  @override
  void initState() {
    debugPrint("yonetici_gecmis_talepler_init metod is build");
    super.initState();
    widget._state.getAllGecmisTalepDataList();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      content: SizedBox(
          width: MediaQuery.of(context).size.width * .8,
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
                  return widget._state.isGecmisTaleplerLoading
                      ?const Center(
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
                                              "${index + 1}. Talep | Talepte Bulunan : ${widget._state.gecmisTaleplerDataList[index]["talepteBulunan"]} | Talebi Alan :  ${widget._state.gecmisTaleplerDataList[index]["talebiAlan"]} | Ders : ${widget._state.gecmisTaleplerDataList[index]["dersAd"][0]}"),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: ElevatedButton(
                                        onPressed: () async {
                                          await widget._state.onaylaButtonUpdate(index,context);
                                        },
                                        child:const Text("Talebi Onayla")),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: ElevatedButton(
                                        onPressed: () async {
                                          await widget._state.reddetButtonUpdate(index);
                                        },
                                        child:const Text("Talebi Reddet")),
                                  ),
                                  ElevatedButton(
                                      onPressed: () async {
                                        await widget._state.silButtonUpdate(index);
                                      },
                                      child:const Text("Talbi Sil")),
                                ],
                              ),
                            );
                          },
                          itemCount: widget._state.gecmisTaleplerDataList.length,
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
        "Gecmis Talepler Ekranı",
        style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
      );

  HorizontalSpaceWidget _horizontalSmallSpaceWidget() => const HorizontalSpaceWidget(widget: AppConstantsDimensions.appSpaceSmall);

  HorizontalSpaceWidget _horizontalNormalSpaceWidget() => const HorizontalSpaceWidget(widget: AppConstantsDimensions.appSpaceNormal);
}
