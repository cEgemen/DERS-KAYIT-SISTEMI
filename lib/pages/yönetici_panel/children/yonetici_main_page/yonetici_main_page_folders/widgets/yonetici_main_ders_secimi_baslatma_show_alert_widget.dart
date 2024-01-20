import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../../core/services/sql_update_service.dart';
import '../../../../../y%C3%B6netici_panel/children/yonetici_main_page/yonetici_main_page_folders/view_modal/yonetici_main_page_view_modal.dart';

class YoneticiMainDersSecimiBaslatmaShowAlertWidget extends StatefulWidget {
  const YoneticiMainDersSecimiBaslatmaShowAlertWidget({required YoneticiMainPageViewModal state, super.key}) : _state = state;
  final YoneticiMainPageViewModal _state;
  @override
  State<YoneticiMainDersSecimiBaslatmaShowAlertWidget> createState() => _YoneticiMainDersSecimiBaslatmaShowAlertWidgetState();
}

class _YoneticiMainDersSecimiBaslatmaShowAlertWidgetState extends State<YoneticiMainDersSecimiBaslatmaShowAlertWidget> {
  late final TextEditingController _textCtrl;

  @override
  void initState() {
    super.initState();
    widget._state.getBaslamaDate();
    _textCtrl = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: MediaQuery.of(context).size.width * .5,
        height: MediaQuery.of(context).size.height * .4,
        child: Column(
          children: [
            _pageAppBarWidget(context),
            _defaultDividerWidget(),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      hintText: "Devam Edecek Gün Sayısı",
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      if (_textCtrl.text.isNotEmpty) {
                        widget._state.getBitisDate(int.parse(_textCtrl.text));
                      }
                    },
                    icon: const Icon(Icons.done))
              ],
            ),
            _defaultDividerWidget(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Baslama Tarihi : ${widget._state.baslamaDate}"),
                Observer(
                    builder: (context) =>
                        widget._state.dersBitisLoading ? const Text("Bitis Tarihi : ?") : Text("Bitis Tarihi : ${widget._state.bitisData}"))
              ],
            ),
            _defaultDividerWidget(),
            Center(
              child: ElevatedButton(
                  onPressed: () async{
                    if (widget._state.baslamaDate != "***" && widget._state.bitisData!="***") {
                     await SqlUpdateService.addDersSecimAyarlari(widget._state.baslamaDate, widget._state.bitisData, "0").then((value) {
                        widget._state.isDersSecimiReady = true;
                        Navigator.pop(context);
                      });
                    }
                  },
                  child: const Text("Ders Secimini Baslat")),
            )
          ],
        ),
      ),
    );
  }

  Divider _defaultDividerWidget() => const Divider();

  Row _pageAppBarWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(),
        const Text("Ders Secimini Baslatma"),
        IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.close))
      ],
    );
  }
}
