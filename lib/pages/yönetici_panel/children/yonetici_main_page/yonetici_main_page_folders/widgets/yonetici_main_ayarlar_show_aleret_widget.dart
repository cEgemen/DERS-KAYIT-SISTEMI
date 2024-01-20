import 'package:flutter/material.dart';
import '../../../../../y%C3%B6netici_panel/children/yonetici_main_page/yonetici_main_page_folders/view_modal/yonetici_main_page_view_modal.dart';
import '../../../../../../../core/components/space_widgets/horizontal_space_widget.dart';
import '../../../../../../../core/constants/app_constant_dimensions/app_dimensions.dart';
import '../../../../../../../core/services/sql_update_service.dart';

List<dynamic> _sistemAyarlariPropartyValues = [];

class YoneticiMainAyarlarShowAlertWidget extends StatefulWidget {
  const YoneticiMainAyarlarShowAlertWidget({required YoneticiMainPageViewModal state, super.key}) : _state = state;
  final YoneticiMainPageViewModal _state;
  @override
  State<YoneticiMainAyarlarShowAlertWidget> createState() => _YoneticiMainAyarlarShowAlertWidgetState();
}

class _YoneticiMainAyarlarShowAlertWidgetState extends State<YoneticiMainAyarlarShowAlertWidget> {
  @override
  void initState() {
    super.initState();
    _kullaniciPropartyListIniti(widget._state.sistemAyarlariDataList);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: MediaQuery.of(context).size.width * .5,
        height: MediaQuery.of(context).size.height * .8,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                Center(
                  child: Text(
                    "Sistem Ayarlari Ekranı",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon:const Icon(Icons.close))
              ],
            ),
           const Divider(),
            Expanded(
                child: Container(
                    decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return MySpecialClass(state: widget._state, index: index + 1);
                      },
                      itemCount: widget._state.sistemAyarlariDataList.length - 4,
                    ))),
            _horizontalNormalSpace(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      await SqlUpdateService.updateSistemAyarlari(_sistemAyarlariPropartyValues);
                    },
                    child:const  Text("Degişiklikleri Kaydet")),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _kullaniciPropartyListIniti(widget._state.sistemAyarlariDataList);
                      });
                    },
                    child: const Text("Baslangıc Bilgilerine Dön")),
              ],
            )
          ],
        ),
      ),
    );
  }

  HorizontalSpaceWidget _horizontalNormalSpace() => const HorizontalSpaceWidget(widget: AppConstantsDimensions.appSpaceNormal);

  void _kullaniciPropartyListIniti(List<dynamic> kullaniciOriginalPropartyValues) {
    _sistemAyarlariPropartyValues.clear();
    _sistemAyarlariPropartyValues.addAll(kullaniciOriginalPropartyValues);
    debugPrint("_sistemAyarlariPropartyValues ==>> $_sistemAyarlariPropartyValues");
  }
}

class MySpecialClass extends StatefulWidget {
  const MySpecialClass({required this.state, required this.index, super.key});
  final int index;
  final YoneticiMainPageViewModal state;
  @override
  State<MySpecialClass> createState() => _MySpecialClassState();
}

class _MySpecialClassState extends State<MySpecialClass> {
  late final TextEditingController _textCtrl;
  bool _isWantSetting = false;
  String value = "";
  @override
  void initState() {
    super.initState();
    _textCtrl = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    value = "${_sistemAyarlariPropartyValues[widget.index]}";
    _textCtrl.text = value;
    return _isWantSetting
        ? Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0, top: 20),
                    child: TextField(
                      controller: _textCtrl,
                      decoration:const InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.zero)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 4.0),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          if (_textCtrl.text.isNotEmpty) {
                            _sistemAyarlariPropartyValues[widget.index] = _textCtrl.text;
                          }
                          _isWantSetting = !_isWantSetting;
                          setState(() {});
                        },
                        icon:const Icon(Icons.done)),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            _isWantSetting = !_isWantSetting;
                          });
                        },
                        icon:const Icon(Icons.close)),
                  ],
                ),
              )
            ],
          )
        : Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                      height: 60,
                      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5.0, top: 20),
                        child: Text("${widget.state.sistemAyarlariNameList[widget.index]} : ${_sistemAyarlariPropartyValues[widget.index]}"),
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        _isWantSetting = !_isWantSetting;
                      });
                    },
                    icon:const Icon(Icons.settings)),
              )
            ],
          );
  }
}

  

