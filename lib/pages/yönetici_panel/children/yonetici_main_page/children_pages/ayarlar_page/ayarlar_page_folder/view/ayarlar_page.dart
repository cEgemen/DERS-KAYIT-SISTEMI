import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../../../../y%C3%B6netici_panel/children/yonetici_main_page/children_pages/ayarlar_page/ayarlar_page_folder/view_modal/ayarlar_page_view_modal.dart';
import '../../../../../../../y%C3%B6netici_panel/children/yonetici_main_page/children_pages/ayarlar_page/ayarlar_page_folder/widgets/ayarlar_page_ilgi_alani_ekle_show_alert_widget.dart';
import '../../../../../../../y%C3%B6netici_panel/children/yonetici_main_page/children_pages/ayarlar_page/ayarlar_page_folder/widgets/ayarlar_page_ilgi_alanlari_settings_show_alert_widget.dart';

import '../../../../../../../../core/components/space_widgets/horizontal_space_widget.dart';
import '../../../../../../../../core/constants/app_constant_dimensions/app_dimensions.dart';
import '../widgets/ayarlar_page_verilecek_dersler_ekle_show_alert_widget.dart';
import '../widgets/ayarlar_page_verilecek_dersler_show_alert_widget.dart';

List<dynamic> _sistemAyarlariPropartyValues = [];

class AyarlarPage extends StatefulWidget {
  const AyarlarPage({super.key});

  @override
  State<AyarlarPage> createState() => _AyarlarPageState();
}

class _AyarlarPageState extends State<AyarlarPage> {
  final AyarlarPageViewModal _state = AyarlarPageViewModal();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _state.getAllIlgiAlanlari();
    _state.getAllDersler();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _ayarlarSayfasiTitle(context),
          _horizontalNormalSpace(),
          Expanded(child: _ilgiAlaniAndDerslerAyarlariWidget(context)),
          _backButton(context),
          _horizontalSmallSpace(),
        ],
      ),
    );
  }

  Center _ayarlarSayfasiTitle(BuildContext context) {
    return Center(
      child: Text(
        "Sistem Ayarlar Sayfası",
        style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Row _backButton(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.keyboard_double_arrow_left_outlined))
      ],
    );
  }

  Row _ilgiAlaniAndDerslerAyarlariWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          color: Colors.green.shade200,
          width: MediaQuery.of(context).size.width * .48,
          height: MediaQuery.of(context).size.height * .8,
          child: _ilgiAlanlariAyariWidget(context),
        ),
        Container(
            color: Colors.green.shade200,
            width: MediaQuery.of(context).size.width * .48,
            height: MediaQuery.of(context).size.height * .8,
            child: _derslerAyariWidget(context)),
      ],
    );
  }

  Container _derslerAyariWidget(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width * .48,
      height: MediaQuery.of(context).size.height * .42,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [const SizedBox(), _dersAyarlariTitle(context), _dersEklemeWidget(context)],
          ),
          _defaultDivider(),
          Expanded(child: _listOfDerslerWidget())
        ],
      ),
    );
  }

  Observer _listOfDerslerWidget() {
    return Observer(
        builder: (context) => _state.isLoadingDerslerListesi
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : _derslerListesiWidget());
  }

  ListView _derslerListesiWidget() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Column(
          children: [
            ListTile(
              title: Text("${index + 1}. Ders Adı = ${_state.derslerListesi[index]["modalData"].dersadi}"),
              shape: const RoundedRectangleBorder(side: BorderSide(color: Colors.transparent)),
              onTap: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return AyarlarPageDerslerShowAlertWidget(model: _state.derslerListesi[index]["modalData"]);
                  },
                );
              },
            ),
            _defaultDivider(),
          ],
        );
      },
      itemCount: _state.derslerListesi.length,
    );
  }

  IconButton _dersEklemeWidget(BuildContext context) {
    return IconButton(
        hoverColor: Colors.transparent,
        onPressed: () {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AyarlarPageDersEkleShowAlertWidget();
            },
          );
        },
        icon: const Icon(Icons.add));
  }

  Text _dersAyarlariTitle(BuildContext context) {
    return Text(
      "Dersler",
      style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Container _ilgiAlanlariAyariWidget(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width * .48,
      height: MediaQuery.of(context).size.height * .42,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [const SizedBox(), _ilgiAlanlariTitle(context), _addIlgiAlanlariWidget(context)],
          ),
          _defaultDivider(),
          Expanded(child: _listOfIlgiAlanlariWidget())
        ],
      ),
    );
  }

  Observer _listOfIlgiAlanlariWidget() {
    return Observer(
        builder: (context) => _state.isLoadingIlgiAlanlariListesi
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : _ilgiAlanlariListesiWidget());
  }

  Divider _defaultDivider() => const Divider();

  IconButton _addIlgiAlanlariWidget(BuildContext context) {
    return IconButton(
        hoverColor: Colors.transparent,
        onPressed: () {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AyarlarPageIlgiAlaniEkleShowAlertWidget();
            },
          );
        },
        icon: const Icon(Icons.add));
  }

  Text _ilgiAlanlariTitle(BuildContext context) {
    return Text(
      "Kullanicilar İlgi Alanlari",
      style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold),
    );
  }

  ListView _ilgiAlanlariListesiWidget() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Column(
          children: [
            ListTile(
              title: Text("${index + 1}. İlgi Alanı Adı = ${_state.ilgiAlanlariListesi[index]["modalData"].ilgialani}"),
              shape: const RoundedRectangleBorder(side: BorderSide(color: Colors.transparent)),
              onTap: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return AyarlarPageIlgiAlanlariShowAlertWidget(model: _state.ilgiAlanlariListesi[index]["modalData"]);
                  },
                );
              },
            ),
            Divider(),
          ],
        );
      },
      itemCount: _state.ilgiAlanlariListesi.length,
    );
  }

  HorizontalSpaceWidget _horizontalNormalSpace() => const HorizontalSpaceWidget(widget: AppConstantsDimensions.appSpaceNormal);

  HorizontalSpaceWidget _horizontalLargeSpace() => const HorizontalSpaceWidget(widget: AppConstantsDimensions.appSpaceLarge);

  HorizontalSpaceWidget _horizontalSmallSpace() => const HorizontalSpaceWidget(widget: AppConstantsDimensions.appSpaceSmall);
}
