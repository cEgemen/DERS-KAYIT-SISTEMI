

import 'package:flutter/material.dart';

import '../../../../../../core/enums/sql_table_names_enum.dart';
import '../../../../../../core/services/sql_delete_service.dart';
import '../../../../../../core/services/sql_insert_service.dart';
import '../../../../../../core/services/sql_select_service.dart';
import '../view_modal/yonetici_main_page_view_modal.dart';

class YoneticiMainMesajShowAlertWidget extends StatefulWidget {
  const YoneticiMainMesajShowAlertWidget({required YoneticiMainPageViewModal state, super.key})
      : 
        _state = state;
  final YoneticiMainPageViewModal _state;
  @override
  State<YoneticiMainMesajShowAlertWidget> createState() => _YoneticiMainMesajShowAlertWidgetState();
}

class _YoneticiMainMesajShowAlertWidgetState extends State<YoneticiMainMesajShowAlertWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget._state.getAllMessageYonetici();
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
                _pageTitle(context),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close))
              ],
            ),
            _defaultDivider(),
            Expanded(
               child :  ListView.builder(
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                            child: ListTile(
                              shape: const RoundedRectangleBorder(side: BorderSide(color: Colors.transparent)),
                              leading: const Icon(Icons.local_post_office_outlined),
                              title:
                                  Text("Gonderen Kullanici Ad Soyad : ${widget._state.mesajlar[index]["gonderenList"][1]} ${widget._state.mesajlar[index]["gonderenList"][2]}"),
                              subtitle: Text(
                                "Mesaj : ${widget._state.mesajlar[index]["mesaj"][2]}",
                                overflow: TextOverflow.clip,
                              ),
                              onTap: () {
                                showDialog(
                                  barrierDismissible: true,
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: SizedBox(
                                        width: MediaQuery.of(context).size.width * .5,
                                        height: MediaQuery.of(context).size.height * .5,
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                const SizedBox(),
                                                Center(
                                                  child: Text(
                                                      "Gonderen : ${widget._state.mesajlar[index]["gonderenList"][1]} ${widget._state.mesajlar[index]["gonderenList"][2]}"),
                                                ),
                                                IconButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    icon:const Icon(Icons.close))
                                              ],
                                            ),
                                            _defaultDivider(),
                                            Expanded(
                                              child: Container(
                                                width: MediaQuery.of(context).size.width*.4,
                                                height: MediaQuery.of(context).size.height*.4,
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.grey),
                                                ),
                                                child: Text("Mesaj : ${widget._state.mesajlar[index]["mesaj"][2]}"),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                ElevatedButton(
                                                    onPressed: () async {
                                                      await SqlDeleteService.deletData(
                                                          widget._state.mesajlar[index]["mesaj"][0], SqlTableName.mesajlar).then((value){
                                                           Navigator.pop(context);
                                                          });
                                                     
                                                    },
                                                    child:const Text("Mesajı Sil")),
                                                   _backMessageWidget(context, index)

                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          );
                        },
                        itemCount: widget._state.mesajlar.length,
                      ))
          ],
        ),
      ),
    );
  }

  ElevatedButton _backMessageWidget(BuildContext context, int index) {
    return ElevatedButton(onPressed: () {
                               String mesaj = "";
                                                            showDialog(
                                                              barrierDismissible: false,
                                                              context: context,
                                                              builder: (context) {
                                                                return AlertDialog(
                                                                  content: SizedBox(
                                                                    width: MediaQuery.of(context).size.width * .3,
                                                                    height: MediaQuery.of(context).size.height * .5,
                                                                    child: Column(
                                                                      children: [
                                                                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            const SizedBox(),
                                                                            const Text("Cevap Mesaj Gonder"),
                                                                            IconButton(
                                                                                onPressed: () {
                                                                                  Navigator.pop(context);
                                                                                },
                                                                                icon: const Icon(Icons.close))
                                                                          ],
                                                                        ),
                                                                        TextField(
                                                                          maxLines: 7,
                                                                          maxLength: widget._state.maxMesajLength,
                                                                          onChanged: (value) {
                                                                            mesaj = value;
                                                                          },
                                                                          decoration: const InputDecoration(
                                                                              border: OutlineInputBorder(borderRadius: BorderRadius.zero)),
                                                                        ),
                                                                        _defaultDivider(),
                                                                        ElevatedButton(
                                                                            onPressed:  () async {
                                                                             final yoneticiId = await SqlSelectService.getYoneticiData(); 
                                                                                        if (mesaj.isNotEmpty) {
                                                                                          await SqlInsertService.addMesaj(
                                                                                              yoneticiId[0],
                                                                                              widget._state.mesajlar[index]["gonderenList"][0] ,
                                                                                              mesaj,
                                                                                              "Yonetici").then((value) {
                                                                        Navigator.pop(context); 
                                                                                              });
                                                                                        }
                                                                                  },
                                                                            child: const Text("Mesajı Gonder"))
                                                                      ],
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            );
  }, child: const Text("Cevap Ver"));
  } 
  Center _pageTitle(BuildContext context) => Center(
        child: Text(
          "Mesajlar",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
      );

  Divider _defaultDivider() => const Divider();
}