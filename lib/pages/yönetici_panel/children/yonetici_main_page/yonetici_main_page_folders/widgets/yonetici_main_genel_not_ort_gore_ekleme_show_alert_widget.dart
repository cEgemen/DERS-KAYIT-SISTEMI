import 'package:flutter/material.dart';

import '../../../../../../core/services/sql_select_service.dart';
import '../../../../../y%C3%B6netici_panel/children/yonetici_main_page/yonetici_main_page_folders/view_modal/yonetici_main_page_view_modal.dart';

List<Map<String, dynamic>> _hocaDatas = [];

class YoneticiMainGenelNotOrtGoreEklemeShowAlertWidget extends StatefulWidget {
  const YoneticiMainGenelNotOrtGoreEklemeShowAlertWidget({required YoneticiMainPageViewModal state, super.key}) : _state = state;
  final YoneticiMainPageViewModal _state;

  @override
  State<YoneticiMainGenelNotOrtGoreEklemeShowAlertWidget> createState() => _YoneticiMainGenelNotOrtGoreEklemeShowAlertWidgetState();
}

class _YoneticiMainGenelNotOrtGoreEklemeShowAlertWidgetState extends State<YoneticiMainGenelNotOrtGoreEklemeShowAlertWidget> {
  @override
  void initState() {
    super.initState();
    _pageInit();
  }

  bool _isInit = false;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: MediaQuery.of(context).size.width * .6,
        height: MediaQuery.of(context).size.height * .6,
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const SizedBox(),
              const Text("Hoca Onceligini Belirleme"),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close))
            ]),
            const Divider(),
            Expanded(
                child: Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: _isInit
                  ? ListView.builder(
                      itemBuilder: (context, index) {
                        return _SpecialClass(state: widget._state, index: index);
                      },
                      itemCount: _hocaDatas.length,
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            )),
            Center(
              child: ElevatedButton(
                  onPressed: () async {
                    if (widget._state.oncelikSirasi.length == _hocaDatas.length) {
                      await widget._state.genelNotOrtGoreDersEkleme();
                    } else {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: SizedBox(
                              width: MediaQuery.of(context).size.width * .7,
                              height: MediaQuery.of(context).size.height * .2,
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
                                  const Text("Lütfen Hoca Önceligine Göre İşaretlemeyi Tamamlayınız"),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                  child: const Text("Ders Eklemeye Gec")),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _pageInit() async {
    widget._state.oncelikSirasi.clear();
    _hocaDatas = await SqlSelectService.getAllHoca();
    _isInit = true;
    setState(() {});
  }
}

class _SpecialClass extends StatefulWidget {
  const _SpecialClass({required YoneticiMainPageViewModal state, required int index, super.key})
      : _state = state,
        _index = index;

  final YoneticiMainPageViewModal _state;
  final int _index;
  @override
  State<_SpecialClass> createState() => __SpecialClassState();
}

class __SpecialClassState extends State<_SpecialClass> {
  @override
  Widget build(BuildContext context) {
    debugPrint("oncelikList => ${widget._state.oncelikSirasi}");
    return Row(
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 60,
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child:
                  Text("${widget._index + 1}. Hoca : ${_hocaDatas[widget._index]["modalData"].ad} ${_hocaDatas[widget._index]["modalData"].soyad}"),
            ),
          ),
        )),
        InkWell(
          onTap: () {
            setState(() {
              if (widget._state.oncelikSirasi.contains(_hocaDatas[widget._index]["modalData"].id)) {
                widget._state.oncelikSirasi.remove(_hocaDatas[widget._index]["modalData"].id);
              } else {
                widget._state.oncelikSirasi.add(_hocaDatas[widget._index]["modalData"].id);
              }
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Icon(
                Icons.done,
                color: widget._state.oncelikSirasi.contains(_hocaDatas[widget._index]["modalData"].id) ? Colors.grey : Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}
