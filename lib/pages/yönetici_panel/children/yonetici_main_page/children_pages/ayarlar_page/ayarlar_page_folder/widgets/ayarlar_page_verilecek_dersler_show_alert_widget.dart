import 'package:flutter/material.dart';
import '../../../../../../../y%C3%B6netici_panel/children/yonetici_main_page/children_pages/ayarlar_page/ayarlar_page_folder/models/dersler_model.dart';

import '../../../../../../../../core/components/space_widgets/horizontal_space_widget.dart';
import '../../../../../../../../core/constants/app_constant_dimensions/app_dimensions.dart';
import '../../../../../../../../core/enums/sql_table_names_enum.dart';
import '../../../../../../../../core/services/sql_delete_service.dart';
import '../../../../../../../../core/services/sql_update_service.dart';

List<dynamic> _derslerPropartys = [];

class AyarlarPageDerslerShowAlertWidget extends StatefulWidget {
  const AyarlarPageDerslerShowAlertWidget({required DerslerModel model, super.key}) : _model = model;
  final DerslerModel _model;

  @override
  State<AyarlarPageDerslerShowAlertWidget> createState() => _AyarlarPageDerslerShowAlertWidgetState();
}

class _AyarlarPageDerslerShowAlertWidgetState extends State<AyarlarPageDerslerShowAlertWidget> {
  late final TextEditingController _textCtrl;
  String _dersPropartyValue = "";
  @override
  void initState() {
    super.initState();
    _derslerPropartysList();
    _textCtrl = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    _dersPropartyValue = "${_derslerPropartys[1]}";
    _textCtrl.text = _dersPropartyValue;
    return AlertDialog(
      content: SizedBox(
        width: MediaQuery.of(context).size.width * .3,
        height: MediaQuery.of(context).size.height * .3,
        child: Column(
          children: [
            _dersGuncellemeEkraniTitle(),
            _defaultDivider(),
            TextField(
              controller: _textCtrl,
              decoration: const InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.zero)),
            ),
            _horizontalLargeSpace(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      if (_textCtrl.text.isNotEmpty) {
                        _derslerPropartys[1] = _textCtrl.text;
                        SqlUpdateService.updateTablesValues(widget._model.fromListToMap(_derslerPropartys), SqlTableName.dersler)
                            .then((value) {
                          Navigator.of(context).pop();
                        });
                      }
                    },
                    child: const Text("Guncelle")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Geri")),
                ElevatedButton(
                    onPressed: () {
                      SqlDeleteService.deletData(widget._model.id!, SqlTableName.dersler).then((value) {
                        Navigator.pop(context);
                      });
                    },
                    child: const Text("Sil"))
              ],
            )
          ],
        ),
      ),
    );
  }

  Center _dersGuncellemeEkraniTitle() {
    return const Center(
      child: Text("Ders Guncelleme Ekranı"),
    );
  }

  Divider _defaultDivider() => const Divider();

  _derslerPropartysList() {
    _derslerPropartys = [];
    _derslerPropartys = widget._model.toList();
  }

  HorizontalSpaceWidget _horizontalLargeSpace() => const HorizontalSpaceWidget(widget: AppConstantsDimensions.appSpaceLarge);
}
