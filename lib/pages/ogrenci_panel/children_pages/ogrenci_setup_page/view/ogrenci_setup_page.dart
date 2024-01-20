import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../../core/constants/app_constant_dimensions/app_dimensions.dart';
import '../../../../../core/enums/sql_table_names_enum.dart';
import '../view_modal/ogrenci_setup_view_modal.dart';
import '../../../../../core/components/space_widgets/horizontal_space_widget.dart';
import '../../../../../core/services/sql_insert_service.dart';
import '../../../../../core/services/sql_update_service.dart';
import '../../ogrenci_main_page/ogrenci_main_page_folders/view/ogrenci_main_page.dart';

List<int> _ilgiAlanlariIdList = [];
List<int> _dersIdList = [];

class OgrenciSetupPage extends StatefulWidget {
  const OgrenciSetupPage({required int id, super.key}) : _id = id;
  final int _id;
  @override
  State<OgrenciSetupPage> createState() => _OgrenciSetupPageState();
}

class _OgrenciSetupPageState extends State<OgrenciSetupPage> {
  final OgrenciSetupViewModal _state = OgrenciSetupViewModal();
  @override
  void initState() {
    super.initState();
    _state.getCurrentUser(widget._id, SqlTableName.ogrenci);

    _state.getSistemAyarlari();
  }

  @override
  Widget build(BuildContext context) {
    _ilgiAlanlariIdList = [];
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Text(
              "Ogrenci Setup Page",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          _horizontalSmallSpaceWidget(),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _userShortInformationWidget(context),
              _dersSecimContainerWidget(context),
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
                    debugPrint("dersSize ===>>> $dersSize");
                    debugPrint("MaxDersSize ==> ${_state.maxAlinacakDers} AND MinDersSize ===> ${_state.minAlinacakDers} ");
                    int ilgialaniSize = _state.ilgiAlanlari.length;
                    debugPrint("ilgialaniSize ===>>> $ilgialaniSize");
                    debugPrint("MinilgialaniSize ===>>> ${_state.minIlgiAlani}");
                    if (_state.transkriptFile != null &&
                        (dersSize == 0 || (_state.minAlinacakDers! <= _dersIdList.length && _dersIdList.length <= _state.maxAlinacakDers!)) &&
                        (ilgialaniSize == 0 || (_state.minIlgiAlani! <= _ilgiAlanlariIdList.length))) {
                      await SqlInsertService.addOgrenciDers(_dersIdList, widget._id, SqlTableName.ogrenciDersleri);
                      await SqlInsertService.addOgrenciIlgiAlani(_ilgiAlanlariIdList, widget._id, SqlTableName.ogrenciIlgiAlanlari);
                      _state.model!.ogrenciDerslerId = _dersIdList;
                      _state.model!.ogrenciIlgiAlanlariId = _ilgiAlanlariIdList;
                      await SqlUpdateService.kullaniciLateSetupUpdate(widget._id, _state.pdfOgrenciNo, _state.pdfGenelNotOrt, SqlTableName.ogrenci)
                          .then((value) {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return OgrenciMainPage(model: _state.model!);
                          },
                        ));
                      });
                    } else {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: SizedBox(
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
                                      "Dosya yüklediginizden, ilgi alanı seciminin minimum ${_state.minIlgiAlani} olacagına , alınacak ders sayısının maximum ${_state.maxAlinacakDers} ve minimum ${_state.minAlinacakDers} olduguna dikkat edin"),
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

  Widget _dersSecimContainerWidget(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .33,
      child: Column(
        children: [
          Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height * (.8),
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
                            return _dersSecimWidget(
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

  Widget _ilgiAlanlariSecimiWidget(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .33,
      child: Column(
        children: [
          Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height * (.8),
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

  ListTile _kullaniciSingleInformationListTileWidget(String text) {
    return ListTile(
      title: Text(text),
    );
  }

  Widget _pickFileWidget(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .33,
      child: Column(
        children: [
          Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height * (.335),
            child: Column(
              children: [
                Center(
                  child: Text(
                    "Ogrenci Transkript Belgesi",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Observer(
                        builder: (context) => Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 70.0, left: 8),
                            child: Text(_state.transkriptFile == null
                                ? "Dosya Ismi = Dont Have File"
                                : "Dosya Ismi = ${_state.transkriptFile!.files[0].name}"),
                          ),
                        ),
                      ),
                      _defaultDivider(),
                      IconButton(
                          onPressed: () async {
                            await _state.pickFile();
                            await _state.gecmisVerileriEkle(widget._id);
                            _state.getAllIlgiAlani();
                            _state.getDersler();
                          },
                          icon: const Icon(Icons.file_download_outlined)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _userShortInformationWidget(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .33,
      child: Column(
        children: [
          Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height * (.45),
            child: Observer(
              builder: (context) => _state.isModelLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        Center(
                          child: Text(
                            "Ogrenci Bilgisi",
                            style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
                        _defaultDivider(),
                        _kullaniciSingleInformationListTileWidget("Ad = ${_state.model!.ad}"),
                        _defaultDivider(),
                        _kullaniciSingleInformationListTileWidget("SoyAd = ${_state.model!.soyad}"),
                        _defaultDivider(),
                        _kullaniciSingleInformationListTileWidget("Ogrenci No = ${_state.model!.ogrencino}"),
                        _defaultDivider(),
                        _kullaniciSingleInformationListTileWidget("Sifre = ${_state.model!.sifre}"),
                        _defaultDivider(),
                      ],
                    ),
            ),
          ),
          _horizontalSmallSpaceWidget(),
          _pickFileWidget(context)
        ],
      ),
    );
  }

  Divider _defaultDivider() => const Divider();

  HorizontalSpaceWidget _horizontalSmallSpaceWidget() => const HorizontalSpaceWidget(
        widget: AppConstantsDimensions.appSpaceSmall,
      );
}

class _dersSecimWidget extends StatefulWidget {
  const _dersSecimWidget({
    super.key,
    required OgrenciSetupViewModal state,
    required int index,
  })  : _state = state,
        _index = index;

  final OgrenciSetupViewModal _state;
  final int _index;
  @override
  State<StatefulWidget> createState() {
    return _dersSecimWidgetState();
  }
}

class _dersSecimWidgetState extends State<_dersSecimWidget> {
  bool _isSelect = false;
  @override
  Widget build(BuildContext context) {
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
                    if (!_dersIdList.contains(widget._state.dersler[widget._index]["id"])) {
                      _dersIdList.add(widget._state.dersler[widget._index]["id"]);
                    }
                  } else {
                    _dersIdList.remove(widget._state.dersler[widget._index]["id"]);
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

class _chooseIlgiAlaniWidget extends StatefulWidget {
  const _chooseIlgiAlaniWidget({
    super.key,
    required OgrenciSetupViewModal state,
    required int index,
  })  : _state = state,
        _index = index;

  final OgrenciSetupViewModal _state;
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
