import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../../core/services/sql_insert_service.dart';
import '../../../../../core/services/sql_update_service.dart';
import '../../hoca_main_page/hoca_main_page_folders/view/hoca_main_page.dart';
import '../view_model/hoca_setup_view_model.dart';

import '../../../../../core/components/space_widgets/horizontal_space_widget.dart';
import '../../../../../core/constants/app_constant_dimensions/app_dimensions.dart';
import '../../../../../core/enums/sql_table_names_enum.dart';

List<int> _ilgiAlanlariIdList = [];
List<int> _derslerIdList = [];

class HocaSetupPage extends StatefulWidget {
  const HocaSetupPage({required int id, super.key}) : _id = id;
  final int _id;
  @override
  State<HocaSetupPage> createState() => _HocaSetupPageState();
}

class _HocaSetupPageState extends State<HocaSetupPage> {
  final HocaSetupViewModel _state = HocaSetupViewModel();
  @override
  void initState() {
    super.initState();
    _state.getSistemAyarlari();
    _state.getCurrentUser(widget._id, SqlTableName.hoca);
    _state.getAllIlgiAlani();
    _state.getAllDersler();
  }

  @override
  Widget build(BuildContext context) {
    _ilgiAlanlariIdList = [];
    _derslerIdList = [];
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Text(
              "Hoca Setup Page",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          _horizontalSmallSpaceWidget(),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _userShortInformationWidget(context),
              _dersSecimiWidget(context),
              _ilgiAlanlariSecimiWidget(context),
            ],
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  hoverColor: Colors.transparent,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.keyboard_double_arrow_left_outlined)),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(shadowColor: Colors.transparent),
                  onPressed: () async {
                    int dersSize = _state.dersler.length;
                    int ilgialaniSize = _state.ilgiAlanlari.length;
                    if ((dersSize == 0 || (_state.minVerilecekDers! <= _derslerIdList.length && _derslerIdList.length <= _state.maxVerilecekDers!)) &&
                        (ilgialaniSize == 0 || (_state.minIlgiAlani! <= _ilgiAlanlariIdList.length))) {
                      await SqlInsertService.addHocaDers(_derslerIdList, widget._id, SqlTableName.hocaDersleri);
                      await SqlInsertService.addHocaIlgiAlani(_ilgiAlanlariIdList, widget._id, SqlTableName.hocaIlgiAlanlari);
                      _state.model!.hocaDerslerId = _derslerIdList;
                      _state.model!.hocaIlgiAlanlariId = _ilgiAlanlariIdList;
                      await SqlUpdateService.kullaniciLateSetupUpdate(widget._id,"",0,SqlTableName.hoca).then(
                        (value) {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return HocaMainPage(model: _state.model!);
                            },
                          ));
                        },
                      );
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
                                            Navigator.of(context).pop();
                                          },
                                          icon: const Icon(Icons.close))
                                    ],
                                  ),
                                  const Divider(),
                                  Text(
                                      "İlgi alanı seciminin minimum ${_state.minIlgiAlani} olacagına ,verilecek ders sayısının maximum ${_state.maxVerilecekDers} ve minimum ${_state.minVerilecekDers} olduguna dikkat edin"),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                  child: const Text("İslemi Tamamla")),
              const SizedBox(),
            ],
          ),
          _horizontalSmallSpaceWidget()
        ],
      ),
    );
  }

  Widget _ilgiAlanlariSecimiWidget(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .33,
      child: Column(
        children: [
          _expandedSizeBox(),
          Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height * (.47),
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
          _expandedSizeBox(),
        ],
      ),
    );
  }

  ListTile _kullaniciSingleInformationListTileWidget(String text) {
    return ListTile(
      title: Text(text),
    );
  }

  Widget _dersSecimiWidget(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .33,
      child: Column(
        children: [
          _expandedSizeBox(),
          Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height * (.47),
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
          _expandedSizeBox(),
        ],
      ),
    );
  }

  Widget _userShortInformationWidget(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .33,
      child: Column(
        children: [
          _expandedSizeBox(),
          Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height * (.47),
            child: Observer(
              builder: (context) => _state.isModelLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        Center(
                          child: Text(
                            "Hoca Bilgisi",
                            style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
                        _expandedSizeBox(),
                        _defaultDivider(),
                        _kullaniciSingleInformationListTileWidget("Ad = ${_state.model!.ad}"),
                        _defaultDivider(),
                        _kullaniciSingleInformationListTileWidget("SoyAd = ${_state.model!.soyad}"),
                        _defaultDivider(),
                        _kullaniciSingleInformationListTileWidget("Sicil No = ${_state.model!.sicilno}"),
                        _defaultDivider(),
                        _kullaniciSingleInformationListTileWidget("Sifre = ${_state.model!.sifre}"),
                        _defaultDivider(),
                        _expandedSizeBox(),
                      ],
                    ),
            ),
          ),
          _expandedSizeBox(),
        ],
      ),
    );
  }

  Expanded _expandedSizeBox() => const Expanded(child: SizedBox());

  Divider _defaultDivider() => const Divider();

  HorizontalSpaceWidget _horizontalSmallSpaceWidget() => const HorizontalSpaceWidget(
        widget: AppConstantsDimensions.appSpaceSmall,
      );
}

class _chooseIlgiAlaniWidget extends StatefulWidget {
  const _chooseIlgiAlaniWidget({
    required HocaSetupViewModel state,
    required int index,
  })  : _state = state,
        _index = index;

  final HocaSetupViewModel _state;
  final int _index;
  @override
  State<_chooseIlgiAlaniWidget> createState() => _chooseIlgiAlaniWidgetState();
}

class _chooseIlgiAlaniWidgetState extends State<_chooseIlgiAlaniWidget> {
  bool _isSelect = false;
  @override
  Widget build(BuildContext context) {
    debugPrint("selectIlgiListesiItems => $_ilgiAlanlariIdList");

    return Row(
      children: [
        Expanded(
          child: ListTile(
            shape: const RoundedRectangleBorder(side: BorderSide(color: Colors.transparent)),
            title: Text("${widget._index + 1}. ${widget._state.ilgiAlanlari[widget._index]["modalData"].ilgialani}"),
            trailing: InkWell(
              onTap: () {
                setState(() {
                  if (!_isSelect) {
                    if (!_ilgiAlanlariIdList.contains(widget._state.ilgiAlanlari[widget._index]["id"])) {
                      _ilgiAlanlariIdList.add(widget._state.ilgiAlanlari[widget._index]["id"]);
                    }
                  } else {
                    _ilgiAlanlariIdList.remove(widget._state.ilgiAlanlari[widget._index]["id"]);
                  }
                  _isSelect = !_isSelect;
                });
              },
              child: Container(
                decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                child: Icon(
                  Icons.done,
                  color: _isSelect ? Colors.grey : Colors.white,
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
    required HocaSetupViewModel state,
    required int index,
  })  : _state = state,
        _index = index;

  final HocaSetupViewModel _state;
  final int _index;
  @override
  State<_chooseDersWidget> createState() => _chooseDersWidgetState();
}

class _chooseDersWidgetState extends State<_chooseDersWidget> {
  bool _isSelect = false;
  @override
  Widget build(BuildContext context) {
    debugPrint("selectDersItems => $_derslerIdList");

    return Row(
      children: [
        Expanded(
          child: ListTile(
            shape: const RoundedRectangleBorder(side: BorderSide(color: Colors.transparent)),
            title: Text("${widget._index + 1}. ${widget._state.dersler[widget._index]["modalData"].dersadi}"),
            trailing: InkWell(
              onTap: () {
                setState(() {
                  if (!_isSelect) {
                    if (!_derslerIdList.contains(widget._state.dersler[widget._index]["id"])) {
                      _derslerIdList.add(widget._state.dersler[widget._index]["id"]);
                    }
                  } else {
                    _derslerIdList.remove(widget._state.dersler[widget._index]["id"]);
                  }
                  _isSelect = !_isSelect;
                });
              },
              child: Container(
                decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                child: Icon(
                  Icons.done,
                  color: _isSelect ? Colors.grey : Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
