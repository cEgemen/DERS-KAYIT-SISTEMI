import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../../../core/extensions/enums_extensions/panel_name_extension.dart';
import '../view_model/ogrenci_main_view_model.dart';
import '../widgets/ogrenci_main_gecmis_veriler_show_alert_widget.dart';
import '../widgets/ogrenci_talep_olusturma_show_alert_widget.dart';
import '../../../../../../core/components/space_widgets/horizontal_space_widget.dart';
import '../../../../../../core/constants/app_constant_dimensions/app_dimensions.dart';
import '../../../../../../core/enums/panel_names_enum.dart';
import '../../../../../main_panel/view/main_panel_page.dart';
import '../../../../ogrenci_panel_folders/model/ogrenci_model.dart';
import '../../children_pages/ogrenci_ilgi_alanlari_ve_dersleri/ogrenci_ilgi_alanlari_ve_dersleri_folder/view/ogrenci_ilgi_alanlari_ve_dersleri.dart';
import '../widgets/ogrenci_main_gelen_talep_show_alert_widget.dart';
import '../widgets/ogrenci_main_mesaj_show_alert_widget.dart';
import '../widgets/ogrenci_main_mevcut_talep_durumu_show_alert_widget.dart';

class OgrenciMainPage extends StatefulWidget {
  const OgrenciMainPage({required OgrenciModel model, super.key}) : _model = model;
  final OgrenciModel _model;
  @override
  State<OgrenciMainPage> createState() => _OgrenciMainPageState();
}

class _OgrenciMainPageState extends State<OgrenciMainPage> {
  final OgrenciMainViewModel _state = OgrenciMainViewModel();
  @override
  void initState() {
    super.initState();
    _state.getSistemAyarlari();
    _state.getAllMessage(widget._model.id!);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("SecimDurum ===> ${_state.dersSecimDurum}");
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
          "Ogrenci Sistem Ekranı",
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
                        icon: const Icon(Icons.close_outlined))
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
                Text("Ogrenci No. = ${widget._model.ogrencino}"),
              ],
            ),
          ),
          const Center(
            child: Text("Sistem Bilgileri"),
          ),
          Card(
            child: Text("İlgi Alan Sayısı = ${widget._model.ogrenciIlgiAlanlariId.length}"),
          ),
          Card(
            child: Text("Aldıgı Ders Sayısı = ${widget._model.ogrenciDerslerId.length}"),
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
          return OgrenciMainMesajShowAlertWidget(
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

  Row _secondRowWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _panelsNameCard(context, PanelNameEnum.gecmisBilgilarPanel),
        _panelsNameCard(context, PanelNameEnum.derslerVeIlgiAlanlariPanel),
        _panelsNameCard(context, PanelNameEnum.talepGecmisiPanel),
        _panelsNameCard(context, PanelNameEnum.talepOlusturPanel),
        _panelsNameCard(context, PanelNameEnum.gelenTalepPanel),
      ],
    );
  }

  SizedBox _panelsNameCard(BuildContext context, PanelNameEnum panelName) {
    return SizedBox(
        height: 200,
        width: 200,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppConstantsDimensions.appRadiusMedium),
          onTap: () {
            if (panelName == PanelNameEnum.derslerVeIlgiAlanlariPanel) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return OgrenciIlgiAlanlariVeDersleri(
                    model: widget._model,
                  );
                },
              ));
            } else if (panelName == PanelNameEnum.talepGecmisiPanel) {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return OgrenciMainMevcutTalepDurumuShowAlertWidget(
                    model: widget._model,
                    state: _state,
                  );
                },
              );
            } else if (panelName == PanelNameEnum.gelenTalepPanel) {
              showDialog(
                context: context,
                builder: (context) {
                  return OgrenciMainGelenTalepShowAlertWidget(
                    model: widget._model,
                    state: _state,
                  );
                },
              );
   
            } else if (panelName == PanelNameEnum.talepOlusturPanel) {
              debugPrint("SecimDurum ===> ${_state.dersSecimDurum}");
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return OgrenciTalepOlusturmaShowAlertWidget(state: _state, model: widget._model);
                  },
                );             
            }
             else{
                showDialog(barrierDismissible:false,context: context, builder:(context) {
                        return OgrenciMainGecmisVerilerShowAlertWidget(state : _state , model : widget._model);
                },);
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
