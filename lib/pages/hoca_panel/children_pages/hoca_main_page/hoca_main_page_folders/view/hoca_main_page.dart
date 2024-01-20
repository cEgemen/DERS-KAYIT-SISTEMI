import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../../core/components/space_widgets/horizontal_space_widget.dart';
import '../../../../../../core/constants/app_constant_dimensions/app_dimensions.dart';
import '../../../../../../core/enums/panel_names_enum.dart';
import '../../../../../../core/extensions/enums_extensions/panel_name_extension.dart';
import '../../../../../main_panel/view/main_panel_page.dart';
import '../../../../hoca_panel_folder/model/hoca_model.dart';
import '../view_modal/hoca_main_page_view_model.dart';
import '../widgets/hoca_main_dersi_alanlar_show_alert_widget.dart';
import '../widgets/hoca_main_dersi_alip_bosta_olan_ogrenciler_show_alert_widget.dart';
import '../widgets/hoca_main_mesaj_show_alert_widget.dart';
import '../widgets/hoca_main_talep_olusturanlar_show_widget.dart';

class HocaMainPage extends StatefulWidget {
 const HocaMainPage({required HocaModel model, super.key}) : _model = model;
  final HocaModel _model;

  @override
  State<HocaMainPage> createState() => _HocaMainPageState();
}

class _HocaMainPageState extends State<HocaMainPage> {
  final HocaMainViewModel _state = HocaMainViewModel();
  @override
  void initState() {
    super.initState();
    _state.getSistemAyarlari();
    _state.getAllMessage(widget._model.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      drawer: _drawerWidget(context),
      body: Column(
        children: [_expandedSizedBox(), _secondRowWidget(context), _expandedSizedBox(), _backButton(context), _horizontalNormalSpace()],
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Center(
        child: Text(
          "Hoca Sistem Ekranı",
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      leading: _showDrawer(),
      actions: [
        _messageWidget(context),
      ],
    );
  }

  Row _backButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return MainPanelPage();
                },
              ));
            },
            icon: const Icon(
              Icons.keyboard_double_arrow_left_outlined,
              size: AppConstantsDimensions.appIconLarge,
            )),
      ],
    );
  }

  Expanded _expandedSizedBox() => const Expanded(child: SizedBox());

  Row _secondRowWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _panelsNameCard(context, PanelNameEnum.dersiAlanOgrencilerPaneli),
        _panelsNameCard(context, PanelNameEnum.talepOlusturanOgrencilerPanel),
        _panelsNameCard(context, PanelNameEnum.hocaninDersiniAlanFakatBostaOlanOgrencilerPaneli),
      ],
    );
  }

  Drawer _drawerWidget(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green.shade200,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    const Center(
                      child: Text("         Kisisel Bilgiler"),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon:const Icon(Icons.close_outlined))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      child: Text("${widget._model.ad![0].toUpperCase()}. ${widget._model.soyad![0].toUpperCase()}."),
                    ),
                  ],
                ),
                Text("Ad = ${widget._model.ad}"),
                Text("Soyad = ${widget._model.soyad}"),
                Text("Sicil No. = ${widget._model.sicilno}"),
              ],
            ),
          ),
        const  Center(
            child: Text("Sistem Bilgileri"),
          ),
          Card(
            child: Text("İlgi Alan Sayısı = ${widget._model.hocaIlgiAlanlariId.length}"),
          ),
          Card(
            child: Text("Verdigi Ders Sayısı = ${widget._model.hocaDerslerId.length}"),
          ),
       const   Card(
            child: Text("Kalan Kontenjan Sayısı = 30"),
          ),
        ],
      ),
    );
  }

  Widget _messageWidget(BuildContext context) {
    return IconButton(onPressed: () {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return HocaMainMesajShowAlertWidget(
            model: widget._model,
            state: _state,
          );
        },
      );
    }, icon: Observer(builder: (_) {
      return _state.isHaveMessage ? const Icon(Icons.mark_email_unread_outlined) : const Icon(Icons.local_post_office_outlined);
    }));
  }

  Builder _showDrawer() {
    return Builder(
      builder: (BuildContext context) {
        return IconButton(
          icon: const Icon(
            Icons.more_horiz,
          ),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        );
      },
    );
  }

  SizedBox _panelsNameCard(BuildContext context, PanelNameEnum panelName) {
    return SizedBox(
        height: 200,
        width: 200,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppConstantsDimensions.appRadiusMedium),
          onTap: () {
            if (panelName == PanelNameEnum.dersiAlanOgrencilerPaneli) {
                 showDialog(barrierDismissible: false,context: context, builder:(context) {
                      return HocaMainDersiAlanlarShowAlertWidget(state:_state,model:widget._model);
                },); 

            } else if (panelName == PanelNameEnum.hocaninDersiniAlanFakatBostaOlanOgrencilerPaneli) {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return HocaMainDersiAlanBosOgrencilerShowAlertWidget(state: _state, model: widget._model);
                },
              );
            } else {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return HocaMainTalepOlusturanlarShowAlertWidget(state: _state, model: widget._model);
                },
              );
            }
          },
          child: Card(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(AppConstantsDimensions.appRadiusMedium))),
            child: Center(
                child: Text(
              panelName.panelName,
              style: Theme.of(context).textTheme.labelLarge,
            )),
          ),
        ));
  }

  HorizontalSpaceWidget _horizontalNormalSpace() => const HorizontalSpaceWidget(widget: AppConstantsDimensions.appSpaceNormal);

}
