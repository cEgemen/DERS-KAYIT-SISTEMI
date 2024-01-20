import 'package:flutter/material.dart';

import '../../../../../../../../core/components/space_widgets/horizontal_space_widget.dart';
import '../../../../../../../../core/constants/app_constant_dimensions/app_dimensions.dart';
import '../../../../../../../../core/enums/sql_table_names_enum.dart';
import '../../../../../../../../core/services/sql_delete_service.dart';
import '../../../../../../../../core/services/sql_update_service.dart';
import '../models/ilgi_alanlari_model.dart';

List<dynamic> _ilgiAlanlariPropartys = [];

class AyarlarPageIlgiAlanlariShowAlertWidget extends StatefulWidget {
  const AyarlarPageIlgiAlanlariShowAlertWidget({required IlgiAlaniModel model, super.key}) : _model = model;
  final IlgiAlaniModel _model;
  @override
  State<AyarlarPageIlgiAlanlariShowAlertWidget> createState() => _AyarlarPageIlgiAlanlariShowAlertWidgetState();
}

class _AyarlarPageIlgiAlanlariShowAlertWidgetState extends State<AyarlarPageIlgiAlanlariShowAlertWidget> {
  late final TextEditingController _textCtrl;
  String _ilgialaniPropartyValue = "";
  @override
  void initState() {
    super.initState();
    _initIlgiAlanlariPropartysList();
    _textCtrl = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    _ilgialaniPropartyValue = "${_ilgiAlanlariPropartys[1]}";
    _textCtrl.text = _ilgialaniPropartyValue;
    return AlertDialog(
      content: SizedBox(
        width: MediaQuery.of(context).size.width * .3,
        height: MediaQuery.of(context).size.height * .3,
        child: Column(
          children: [
            const Center(
              child: Text("Ilgi Alanı Guncelleme Ekranı"),
            ),
            Divider(),
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
                        _ilgiAlanlariPropartys[1] = _textCtrl.text;
                        SqlUpdateService.updateTablesValues(widget._model.fromListToMap(_ilgiAlanlariPropartys), SqlTableName.ilgiAlanlari)
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
                      SqlDeleteService.deletData(widget._model.id!, SqlTableName.ilgiAlanlari).then((value) {
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

  _initIlgiAlanlariPropartysList() {
    _ilgiAlanlariPropartys = [];
    _ilgiAlanlariPropartys = widget._model.toList();
  }

  HorizontalSpaceWidget _horizontalLargeSpace() => const HorizontalSpaceWidget(widget: AppConstantsDimensions.appSpaceLarge);
}
