import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../../../core/components/space_widgets/horizontal_space_widget.dart';
import '../../../../../../../core/constants/app_constant_dimensions/app_dimensions.dart';
import '../../../../../../../core/enums/sql_table_names_enum.dart';
import '../../../../../../../core/services/sql_insert_service.dart';
import '../view_modal/kullanicilar_listesi_page.dart';

List<int> _selectIlgiAlanlariIdList = [];
List<int> _selectDerslerIdList = [];

class HocaDersVeIlgiAlaniSetShowAlertWidget extends StatefulWidget {
  const HocaDersVeIlgiAlaniSetShowAlertWidget({required Map<String, dynamic> model, super.key}) : _model = model;
  final Map<String, dynamic> _model;
  @override
  State<HocaDersVeIlgiAlaniSetShowAlertWidget> createState() => _HocaDersVeIlgiAlaniSetShowAlertWidgetState();
}

class _HocaDersVeIlgiAlaniSetShowAlertWidgetState extends State<HocaDersVeIlgiAlaniSetShowAlertWidget> {
  final KullanicilarListesiPageViewModal _state = KullanicilarListesiPageViewModal();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _state.getSistemAyarlari();
    _state.getAllIlgiAlani();
    _state.getAllDersler();
  }

  @override
  Widget build(BuildContext context) {
    _pageListInit();
    return AlertDialog(
      content: SizedBox(
        height: MediaQuery.of(context).size.height * .8,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                Center(
                  child: Text(
                    "Hoca Setup Page",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.close))
              ],
            ),
            const Divider(),
            _horizontalSmallSpaceWidget(),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _dersSecimiWidget(context),
                _ilgiAlanlariSecimiWidget(context),
              ],
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(shadowColor: Colors.transparent),
                    onPressed: () async {
                      int allDersSize = widget._model["dersData"].length;
                      for (int dersId in _selectDerslerIdList) {
                        int count = 0;
                        debugPrint("derId ==>>> $dersId");
                        for (List orginalDersList in widget._model["dersData"]) {
                          if (dersId == orginalDersList[0]) {
                            count++;
                          }
                        }
                        if (count == 0) {
                          debugPrint("count is 0");
                          debugPrint("allDersSize => $allDersSize || _state.maxHocaVerilecekDers => ${_state.maxHocaVerilecekDers!} ||  allDersSize => $allDersSize || _state.minHocaVerilecekDers! => ${_state.minHocaVerilecekDers!} ");
                          if (allDersSize <= _state.maxHocaVerilecekDers!) {
                            debugPrint("ders hocaya ekleniyor");
                            await SqlInsertService.addHocaDers([dersId], widget._model["modalData"].id, SqlTableName.hocaDersleri);
                          }
                        }
                      }

                      for (int ilgiAlanId in _selectIlgiAlanlariIdList) {
                        int count = 0;
                        for (List orginalIlgiAlaniList in widget._model["ilgiAlaniData"]) {
                          if (ilgiAlanId == orginalIlgiAlaniList[0]) {
                            count++;
                          }
                        }
                        if (count == 0) {
                            await SqlInsertService.addHocaIlgiAlani([ilgiAlanId], widget._model["modalData"].id, SqlTableName.hocaIlgiAlanlari);
                          
                        }
                      }
                    },
                    child: const Text("Degişiklikleri Kaydet ")),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _pageListInit();
                      });
                    },
                    child: const Text("Degişiklikleri Geri Al"))
              ],
            ),
            _horizontalSmallSpaceWidget()
          ],
        ),
      ),
    );
  }

  Widget _ilgiAlanlariSecimiWidget(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .3,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey)),
            height: MediaQuery.of(context).size.height * (.6),
            child: Column(
              children: [
                Center(
                  child: Text(
                    "Ilgi Alanlari",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(child: Observer(builder: (_) {
                  return _state.isIlgiAlanleriLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          itemBuilder: (context, index) {
                            return _chooseIlgiAlaniWidget(
                              state: _state,
                              index: index,
                            );
                          },
                          itemCount: _state.ilgiAlanlari.length,
                        );
                }))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _dersSecimiWidget(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .3,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey)),
            height: MediaQuery.of(context).size.height * (.6),
            child: Column(
              children: [
                Center(
                  child: Text(
                    "Dersler",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(child: Observer(builder: (_) {
                  return _state.isDerslerLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          itemBuilder: (context, index) {
                            return _chooseDersWidget(
                              state: _state,
                              index: index,
                            );
                          },
                          itemCount: _state.dersler.length,
                        );
                }))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Expanded _expandedSizeBox() => const Expanded(child: SizedBox());

  HorizontalSpaceWidget _horizontalSmallSpaceWidget() => const HorizontalSpaceWidget(
        widget: AppConstantsDimensions.appSpaceSmall,
      );

  void _pageListInit() {
    _selectDerslerIdList.clear();
    _selectIlgiAlanlariIdList.clear();
    debugPrint("model dersler => ${widget._model["dersData"]}");
    if (widget._model["dersData"].isNotEmpty) {
      for (List ders in widget._model["dersData"]) {
        _selectDerslerIdList.add(ders[0]);
      }
    }
    debugPrint("model ilgiAlanlari => ${widget._model["ilgiAlaniData"]}");
    if (widget._model["ilgiAlaniData"].isNotEmpty) {
      for (List ilgiAlanlari in widget._model["ilgiAlaniData"]) {
        _selectIlgiAlanlariIdList.add(ilgiAlanlari[0]);
      }
    }
  }
}

class _chooseIlgiAlaniWidget extends StatefulWidget {
  const _chooseIlgiAlaniWidget({
    super.key,
    required KullanicilarListesiPageViewModal state,
    required int index,
  })  : _state = state,
        _index = index;

  final KullanicilarListesiPageViewModal _state;
  final int _index;
  @override
  State<_chooseIlgiAlaniWidget> createState() => _chooseIlgiAlaniWidgetState();
}

class _chooseIlgiAlaniWidgetState extends State<_chooseIlgiAlaniWidget> {
  @override
  Widget build(BuildContext context) {
    debugPrint("selectIlgiListesiItems => $_selectIlgiAlanlariIdList");

    return Row(
      children: [
        Expanded(
          child: ListTile(
            shape: const RoundedRectangleBorder(side: BorderSide(color: Colors.transparent)),
            title: Text("${widget._index + 1}. ${widget._state.ilgiAlanlari[widget._index]["modalData"].ilgialani}"),
            trailing: InkWell(
              onTap: _selectIlgiAlanlariIdList.contains(widget._state.ilgiAlanlari[widget._index]["id"])
                  ? null
                  : () {
                      setState(() {
                        if (!_selectIlgiAlanlariIdList.contains(widget._state.ilgiAlanlari[widget._index]["id"])) {
                          _selectIlgiAlanlariIdList.add(widget._state.ilgiAlanlari[widget._index]["id"]);
                        } else {
                          _selectIlgiAlanlariIdList.remove(widget._state.ilgiAlanlari[widget._index]["id"]);
                        }
                      });
                    },
              child: Container(
                decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                child: Icon(
                  Icons.done,
                  color: _selectIlgiAlanlariIdList.contains(widget._state.ilgiAlanlari[widget._index]["id"]) ? Colors.grey : Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _chooseDersWidget extends StatefulWidget {
  const _chooseDersWidget({
    super.key,
    required KullanicilarListesiPageViewModal state,
    required int index,
  })  : _state = state,
        _index = index;

  final KullanicilarListesiPageViewModal _state;
  final int _index;
  @override
  State<_chooseDersWidget> createState() => _chooseDersWidgetState();
}

class _chooseDersWidgetState extends State<_chooseDersWidget> {
  @override
  Widget build(BuildContext context) {
    debugPrint("selectDersItems => $_selectDerslerIdList");

    return Row(
      children: [
        Expanded(
          child: ListTile(
            shape: const RoundedRectangleBorder(side: BorderSide(color: Colors.transparent)),
            title: Text("${widget._index + 1}. ${widget._state.dersler[widget._index]["modalData"].dersadi}"),
            trailing: InkWell(
              onTap: _selectDerslerIdList.contains(widget._state.dersler[widget._index]["id"])
                  ? null
                  : () {
                      setState(() {
                        if (!_selectDerslerIdList.contains(widget._state.dersler[widget._index]["id"])) {
                          _selectDerslerIdList.add(widget._state.dersler[widget._index]["id"]);
                        } else {
                          _selectDerslerIdList.remove(widget._state.dersler[widget._index]["id"]);
                        }
                      });
                    },
              child: Container(
                decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                child: Icon(
                  Icons.done,
                  color: _selectDerslerIdList.contains(widget._state.dersler[widget._index]["id"]) ? Colors.grey : Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
