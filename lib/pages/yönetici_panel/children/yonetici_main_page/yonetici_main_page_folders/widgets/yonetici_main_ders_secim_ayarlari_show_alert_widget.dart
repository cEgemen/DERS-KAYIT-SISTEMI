import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../../core/services/sql_update_service.dart';
import '../../../../../y%C3%B6netici_panel/children/yonetici_main_page/yonetici_main_page_folders/view_modal/yonetici_main_page_view_modal.dart';

class YoneticiMainBitisDateAyarlariBaslatmaShowAlertWidget extends StatefulWidget {
  const YoneticiMainBitisDateAyarlariBaslatmaShowAlertWidget({required YoneticiMainPageViewModal state, super.key}) : _state = state;
  final YoneticiMainPageViewModal _state;
  @override
  State<YoneticiMainBitisDateAyarlariBaslatmaShowAlertWidget> createState() => _YoneticiMainBitisDateAyarlariBaslatmaShowAlertWidgetState();
}

class _YoneticiMainBitisDateAyarlariBaslatmaShowAlertWidgetState extends State<YoneticiMainBitisDateAyarlariBaslatmaShowAlertWidget> {
  late final TextEditingController _textCtrl;
  @override
  void initState() {
    super.initState();
    widget._state.getDersSecimDates();
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
                            hintText: "Bitis Kac Gun Ertelenecek",
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                             if(_textCtrl.text.isNotEmpty)
                          {
                            
                              widget._state.getSetBitisDate(int.parse(_textCtrl.text));
                          }
                          },
                          icon: const Icon(Icons.done))
                    ],
                  ),
            _defaultDividerWidget(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Observer(builder:(context) => widget._state.bitisDateSetLoading ? const Text("Bitis Tarihi : ***") :  Text("Bitis Tarihi : ${widget._state.bitisData}") ,),
               Observer(builder:(context) => widget._state.bitisDateSetLoading ? const Text("Guncel Bitis Tarihi : ***") :  Text("Guncel Bitis Tarihi : ${widget._state.guncelDate}"))
              ],
            ),
            _defaultDividerWidget(),
            Center(
              child: ElevatedButton(
                  onPressed: () async{
                   if(widget._state.guncelDate != "***")
                {   await SqlUpdateService.updateDersSecimBitisDateAyarlari(widget._state.guncelDate).then((value) {
                      Navigator.pop(context);
                    });}
                  },
                  child: const Text("Guncelle")),
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
        const Text("Bitis Tarihini Guncelle "),
        IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.close))
      ],
    );
  }
}
