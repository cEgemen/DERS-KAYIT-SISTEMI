

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../../../core/services/sql_select_service.dart';

import '../../../../../../core/enums/sql_table_names_enum.dart';
import '../../../../../../core/services/sql_delete_service.dart';
import '../../../../../../core/services/sql_insert_service.dart';
import '../../../../ogrenci_panel_folders/model/ogrenci_model.dart';
import '../view_model/ogrenci_main_view_model.dart';

class OgrenciMainMesajShowAlertWidget extends StatefulWidget {
  const OgrenciMainMesajShowAlertWidget({required OgrenciModel model, required OgrenciMainViewModel state, super.key})
      : _model = model,
        _state = state;
  final OgrenciModel _model;
  final OgrenciMainViewModel _state;
  @override
  State<OgrenciMainMesajShowAlertWidget> createState() => _OgrenciMainMesajShowAlertWidgetState();
}

class _OgrenciMainMesajShowAlertWidgetState extends State<OgrenciMainMesajShowAlertWidget> {
  @override
  void initState() {
    super.initState();
  }

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
              _yoneticeyeMesajButtonWidget(context),
                _pageTitle(context),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close))
              ],
            ),
            _defaultDivider(),
            Observer(builder: (_) {
              return Expanded(
                  child: widget._state.isLoadingMessage
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                              child: ListTile(
                                shape: const RoundedRectangleBorder(side: BorderSide(color: Colors.transparent)),
                                leading: const Icon(Icons.local_post_office_outlined),
                                title:
                                    Text("Gonderen Kullanici Ad Soyad : ${widget._state.mesajList[index]["gonderenList"][1]} ${widget._state.mesajList[index]["gonderenList"][2]}"),
                                subtitle: Text(
                                  "Mesaj : ${widget._state.mesajList[index]["mesaj"][2]}",
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
                                                        "Gonderen : ${widget._state.mesajList[index]["gonderenList"][1]} ${widget._state.mesajList[index]["gonderenList"][2]}"),
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
                                                  child: Text("Mesaj : ${widget._state.mesajList[index]["mesaj"][2]}"),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [                                              
                                                  ElevatedButton(
                                                      onPressed: () async {
                                                        await SqlDeleteService.deletData(
                                                            widget._state.mesajList[index]["mesaj"][0], SqlTableName.mesajlar).then((value) {
                                                        Navigator.pop(context);

                                                            });
                                                      },
                                                      child:const  Text("Mesajı Sil")),
                                                      _backMessageWidget(context,index),
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
                          itemCount: widget._state.mesajList.length,
                        ));
            })
          ],
        ),
      ),
    );
  } 
  Widget _pageTitle(BuildContext context) => Text(
         "Mesajlar",
         style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
       );

  ElevatedButton _yoneticeyeMesajButtonWidget(BuildContext context) {
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
                                                                              const Text("Yoneticiye Mesaj Gonder"),
                                                                              IconButton(
                                                                                  onPressed: () {
                                                                                    Navigator.pop(context);
                                                                                  },
                                                                                  icon: const Icon(Icons.close))
                                                                            ],
                                                                          ),
                                                                          TextField(
                                                                            maxLines: 7,
                                                                            maxLength: widget._state.maxMesajUzunlugu,
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
                                                                                                widget._model.id!,
                                                                                                yoneticiId[0],
                                                                                                mesaj,
                                                                                                "Ogrenci").then((value) {
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
    }, child: const Text("Yoneticiye Mesaj At"));
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
                                                                          maxLength: widget._state.maxMesajUzunlugu,
                                                                          onChanged: (value) {
                                                                            mesaj = value;
                                                                          },
                                                                          decoration: const InputDecoration(
                                                                              border: OutlineInputBorder(borderRadius: BorderRadius.zero)),
                                                                        ),
                                                                        _defaultDivider(),
                                                                        ElevatedButton(
                                                                            onPressed:  () async {
                                                                                        if (mesaj.isNotEmpty) {
                                                                                          await SqlInsertService.addMesaj(
                                                                                              widget._model.id!,
                                                                                              widget._state.mesajList[index]["gonderenList"][0],
                                                                                              mesaj,
                                                                                            "Ogrenci").then((value) {
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

  Divider _defaultDivider() => const Divider();
}
