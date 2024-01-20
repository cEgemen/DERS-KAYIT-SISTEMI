import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_constant_dimensions/app_dimensions.dart';
import '../../../core/enums/panel_names_enum.dart';
import '../../../core/extensions/enums_extensions/panel_name_extension.dart';
import '../../../core/services/sql_select_service.dart';
import '../../../core/services/sql_update_service.dart';
import '../../hoca_panel/hoca_panel_folder/view/hoca_panel_page.dart';
import '../../ogrenci_panel/ogrenci_panel_folders/view/ogrenci_panel_page.dart';
import '../../yönetici_panel/yönetici_panel_folders/view/yonetici_panel_page.dart';
import '../constants/main_panel_constants_strings/main_panel_constants_strings.dart';

class MainPanelPage extends StatefulWidget {
  MainPanelPage({super.key});

  @override
  State<MainPanelPage> createState() => _MainPanelPageState();
}

class _MainPanelPageState extends State<MainPanelPage> {
  List<dynamic> sistemAyarlariDataList = [];
  final MainPanelConstantsStrings strings = MainPanelConstantsStrings.init;
  String dersSecimDurum = "Yükleniyor";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _appInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Padding(
                padding: const EdgeInsets.only(left: 250.0),
                child: Text(
                  strings.pageTitle,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                width: 250,
                height: 50,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
                child: Center(child: Text("Ders Secim Durumu : $dersSecimDurum")),
              ),
            ],
          ),
          const Spacer(
            flex: 1,
          ),
          Expanded(
              flex: 6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _panelsNameCard(context, PanelNameEnum.hocaPanel),
                  _panelsNameCard(context, PanelNameEnum.yoneticiPanel),
                  _panelsNameCard(context, PanelNameEnum.ogrenciPanel),
                ],
              )),
          const Spacer(
            flex: 1,
          )
        ],
      ),
    );
  }

  Future<void> _appInit() async {
    await Future.delayed(const Duration(seconds: 1));
    sistemAyarlariDataList = await SqlSelectService.getSistemAyarlari();
     debugPrint("sistemAyarlari ==>>>> $sistemAyarlariDataList VE secimDurumValue ==>>> ${sistemAyarlariDataList[sistemAyarlariDataList.length - 1]} ");
    if (sistemAyarlariDataList[sistemAyarlariDataList.length - 1] != "-1") {
      DateTime bitis = DateTime.parse(sistemAyarlariDataList[sistemAyarlariDataList.length - 2]);
      Duration fark = bitis.difference(DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now())));
      debugPrint("fark.inDays ==> ${fark.inDays}");
      if (fark.inDays < 0) {
        await SqlUpdateService.updateSistemSecimDurumu("1");
      } else {
        await SqlUpdateService.updateSistemSecimDurumu("0");
      }
    }
    switch (sistemAyarlariDataList[sistemAyarlariDataList.length - 1]) {
      case "-1":
        dersSecimDurum = "Baslamadi";
        break;
      case "0":
        dersSecimDurum = "Devam Ediyor";
        break;
      case "1":
        dersSecimDurum = "Bitti";
        break;
    }
    setState(() {});
  }

  SizedBox _panelsNameCard(BuildContext context, PanelNameEnum panelName) {
    return SizedBox(
        height: 250,
        width: 250,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppConstantsDimensions.appRadiusMedium),
          onTap: () {
            if (panelName == PanelNameEnum.hocaPanel) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return const HocaPanelPage();
                },
              ));
            } else if (panelName == PanelNameEnum.ogrenciPanel) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return const OgrenciPanelPage();
                },
              ));
            } else {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return const YoneticiPanelPage();
                },
              ));
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
}
