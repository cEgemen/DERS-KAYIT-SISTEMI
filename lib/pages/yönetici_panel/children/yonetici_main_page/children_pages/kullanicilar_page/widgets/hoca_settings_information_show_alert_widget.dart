import 'package:flutter/material.dart';
import '../../../../../../hoca_panel/hoca_panel_folder/model/hoca_model.dart';
import '../../../../../../../core/components/space_widgets/horizontal_space_widget.dart';
import '../../../../../../../core/constants/app_constant_dimensions/app_dimensions.dart';
import '../../../../../../../core/enums/sql_table_names_enum.dart';
import '../../../../../../../core/services/sql_delete_service.dart';
import '../../../../../../../core/services/sql_update_service.dart';

List<dynamic> _kullaniciPropartyValues = [];

class HocaSettingsInformationShowAlertWidget extends StatefulWidget {
  const HocaSettingsInformationShowAlertWidget({required HocaModel kullanici, super.key}) : _kullanici = kullanici;
  final HocaModel _kullanici;

  @override
  State<HocaSettingsInformationShowAlertWidget> createState() => _HocaSettingsInformationShowAlertWidgetState();
}

class _HocaSettingsInformationShowAlertWidgetState extends State<HocaSettingsInformationShowAlertWidget> {
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
                    "Hoca Bilgi Güncelleme Ekranı",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close))
              ],
            ),
            const Divider(),
            Expanded(child: _listViewBuilderWidget()),
            _horizontalNormalSpace(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      debugPrint("kullaniciKontenjan ---------------->>> ${widget._kullanici.baslangickontenjan!}");
                      debugPrint("propartyKontenjan---------------->>> ${ _kullaniciPropartyValues[_kullaniciPropartyValues.length-2]}}");

                      int value =int.parse(_kullaniciPropartyValues[_kullaniciPropartyValues.length-2]) - int.parse(widget._kullanici.baslangickontenjan!);
                      debugPrint("value ---------------->>> $value");
                      if(value > 0)
                      {
                        _kullaniciPropartyValues[_kullaniciPropartyValues.length-1] = "${int.parse( _kullaniciPropartyValues[_kullaniciPropartyValues.length-1])+value}";
                        debugPrint("yeni kalan kontenjan  ---------------->>> ${ _kullaniciPropartyValues[_kullaniciPropartyValues.length-1]}");
                      }
                     else if(value < 0)
                      {
                         _kullaniciPropartyValues[_kullaniciPropartyValues.length-1] = "${int.parse( _kullaniciPropartyValues[_kullaniciPropartyValues.length-1]) - value}";
                         debugPrint("yeni kalan kontenjan  ---------------->>> ${ _kullaniciPropartyValues[_kullaniciPropartyValues.length-1]}");
                      }
                      await SqlUpdateService.updateTablesValues(widget._kullanici.fromListToMap(_kullaniciPropartyValues), SqlTableName.hoca);
                    },
                    child: const Text("Degişiklikleri Kaydet")),
                ElevatedButton(
                    onPressed: () async {
                      await SqlDeleteService.deletData(_kullaniciPropartyValues[0], SqlTableName.hoca);
                    },
                    child: const Text("Kullanıcıyı Sil")),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _kullaniciPropartyValues = widget._kullanici.toList();
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

  ListView _listViewBuilderWidget() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SetInformationWidget(
              kullanici: widget._kullanici,
              index: index + 1,
            ),
            const Divider()
          ],
        );
      },
      itemCount: widget._kullanici.kullaniciPropartyNames.length - 2,
    );
  }

  HorizontalSpaceWidget _horizontalNormalSpace() => const HorizontalSpaceWidget(widget: AppConstantsDimensions.appSpaceNormal);
}

class _SetInformationWidget extends StatefulWidget {
  const _SetInformationWidget({
    required HocaModel kullanici,
    required int index,
  })  : _kullanici = kullanici,
        _index = index;

  final HocaModel _kullanici;
  final int _index;
  @override
  State<_SetInformationWidget> createState() => _SetInformationWidgetState();
}

class _SetInformationWidgetState extends State<_SetInformationWidget> {
  bool _isWantSetInformation = false;
  String _propartyValue = "";
  TextEditingController _textCtrl = TextEditingController();
  @override
  void initState() {
    super.initState();
    _kullaniciPropartyListIniti(widget._kullanici.toList());
    _textCtrl = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    _propartyValue = "${_kullaniciPropartyValues[widget._index]}";
    _textCtrl.text = _propartyValue;
  debugPrint("hocaModel ==>> ${_kullaniciPropartyValues.toString()}");
    return _isWantSetInformation
        ? Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * .3,
                child: TextField(
                  controller: _textCtrl,
                  decoration:
                      const InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.zero, borderSide: BorderSide(color: Colors.black))),
                ),
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      if (_textCtrl.text.isNotEmpty) {
                        _propartyValue = _textCtrl.text;
                        _kullaniciPropartyValues[widget._index] = _propartyValue;
                      }
                      _isWantSetInformation = !_isWantSetInformation;
                    });
                  },
                  icon: const Icon(Icons.done)),
              IconButton(
                  onPressed: () {
                    setState(() {
                      _isWantSetInformation = !_isWantSetInformation;
                    });
                  },
                  icon: const Icon(Icons.close)),
            ],
          )
        : Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * .3,
                child: ListTile(
                  title: Text("${widget._kullanici.kullaniciPropartyNames[widget._index].toUpperCase()} = $_propartyValue "),
                ),
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      _isWantSetInformation = !_isWantSetInformation;
                    });
                  },
                  icon: const Icon(Icons.settings))
            ],
          );
  }

  void _kullaniciPropartyListIniti(List<dynamic> kullaniciOriginalPropartyValues) {
    _kullaniciPropartyValues = [];
    _kullaniciPropartyValues = kullaniciOriginalPropartyValues;
  }
}
