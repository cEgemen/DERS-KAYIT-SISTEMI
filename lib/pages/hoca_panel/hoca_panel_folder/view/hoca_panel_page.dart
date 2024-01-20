import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/components/show_dialog_widgets/normal_show_dialog_alert_widget.dart';
import '../../../../core/components/space_widgets/horizontal_space_widget.dart';
import '../../../../core/constants/app_constant_dimensions/app_dimensions.dart';
import '../../../../core/enums/sql_table_names_enum.dart';
import '../../../../core/services/sql_select_service.dart';
import '../view_model/hocal_panel_view_modal.dart';
import '../widgets/hoca_panel_custom_button.dart';
import '../widgets/hoca_panel_custom_password_text_field.dart';
import '../widgets/hoca_panel_custom_text_field_widget.dart';
import '../widgets/hoca_panel_show_alert_widget.dart';

class HocaPanelPage extends StatefulWidget {
  const HocaPanelPage({super.key});

  @override
  State<HocaPanelPage> createState() => _HocaPanelPageState();
}

class _HocaPanelPageState extends State<HocaPanelPage> {
  final HocaPanelViewModal _state = HocaPanelViewModal();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 2,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(AppConstantsDimensions.appCirculeAvatarMinRadiusMedium))),
                  child: Image.asset(
                    "assets/images/hoca.png",
                  ))),
          Expanded(
              flex: 4,
              child: Form(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _horizontalNormalSpace(),
                  Text(
                    _state.strings.pageTitle,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
                  ),
                  _horizontalLargeSpace(),
                  HocaPanelCustomTextFormField(
                    state: _state,
                    onChanged: (value) {
                      _state.changeButtonState();
                    },
                  ),
                  _horizontalLargeSpace(),
                  HocaPanelCustomPasswordTextFormField(
                    state: _state,
                    onChanged: (value) {
                      _state.changeButtonState();
                    },
                  ),
                ],
              ))),
          Expanded(
              flex: 4,
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        Observer(
                          builder: (context) => HocaPanelCustomButton(
                            isReady: _state.isDone,
                            buttonTitle: _state.strings.buttonTitle,
                            onPressed: () async {
                             final value =await SqlSelectService.userInitialPanelControlled(_state.kullaniciController.text, _state.passwordController.text,SqlTableName.hoca);
                                if (value.length == 1) {
                                     if(value[0][0] != -1) 
                                // ignore: use_build_context_synchronously
                                {_state.toPage(context,value[0][0]);}
                              } 
                               else if (value.length > 1){
                                        // ignore: use_build_context_synchronously
                                        showDialog(barrierDismissible:false,context: context, builder:(context) {
                                             return AlertDialog(
                                                 content: SizedBox(
                                                    width: MediaQuery.of(context).size.width*.6,
                                                    height: MediaQuery.of(context).size.height*.4,
                                                    child: Column(children: [
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                const SizedBox(),
                                                               const Text("Bulunan Kullanıcılar"),
                                                                IconButton(onPressed: () {
                                                                    Navigator.pop(context);
                                                                },icon:const Icon(Icons.close))
                                                              ],
                                                            ),
                                                             Expanded(child: Container(
                                                                decoration: BoxDecoration(
                                                                  border: Border.all(color: Colors.grey)
                                                                ),
                                                                child: ListView.builder(itemBuilder: (context, index) {
                                                                        return Padding(padding: EdgeInsets.all(20),child: InkWell(
                                                                          onTap: () {
                                                                            Navigator.pop(context);
                                                                           debugPrint("Ad : ${value[index][1]} Soyad : ${value[index][2]}") ;
                                                                                if(value[index][0] != -1) 
                                                                     // ignore: use_build_context_synchronously
                                                                        {
                                                                          _state.toPage(context,value[index][0]);
                                                                        }
                                                                          },
                                                                          child: Container(
                                                                            height: 60,
                                                                            decoration: BoxDecoration(
                                                                              border: Border.all(color: Colors.grey)
                                                                            ),
                                                                            child: Text("Ad : ${value[index][1]} Soyad : ${value[index][2]}"),
                                                                          ),
                                                                        ),
                                                                        );
                                                                },itemCount: value.length,),
                                                             ))
                                                    ],),
                                                 ),
                                             );
                                        },);
                               }
                            },
                          ),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(AppConstantsDimensions.appRadiusCircule),
                          onTap: () async {
                            if (_state.kullaniciController.text.isEmpty) {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return const ShowDialogAlertWidget(
                                  title:"Bilgilendirme !!",
                                  contentText:  "Sisteme Ilk Kez Giris Yapıyorsanız Yeni Sifre Almak Icin Lütfen Kullanıcı Adı Kısmını Bos Bırakmayınız");
                                },
                              );
                            } else {
                      
                             
                            final result =
                                  await SqlSelectService.userInitialLoginControlled(_state.kullaniciController.text,SqlTableName.hoca);
                              if (result.length == 1) {
                                // ignore: use_build_context_synchronously
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return HocaPanelShowAlertWidget(state: _state,hoca:result[0],);
                                  },
                                ); 
                              }
                              else{
                                  // ignore: use_build_context_synchronously
                                        showDialog(barrierDismissible:false,context: context, builder:(context) {
                                             return AlertDialog(
                                                 content: SizedBox(
                                                    width: MediaQuery.of(context).size.width*.6,
                                                    height: MediaQuery.of(context).size.height*.4,
                                                    child: Column(children: [
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                const SizedBox(),
                                                               const Text("Bulunan Kullanıcılar"),
                                                                IconButton(onPressed: () {
                                                                    Navigator.pop(context);
                                                                },icon:const Icon(Icons.close))
                                                              ],
                                                            ),
                                                             Expanded(child: Container(
                                                                decoration: BoxDecoration(
                                                                  border: Border.all(color: Colors.grey)
                                                                ),
                                                                child: ListView.builder(itemBuilder: (context, index) {
                                                                        return Padding(padding: const EdgeInsets.all(20),child: InkWell(
                                                                          onTap: () {
                                                                            Navigator.pop(context);
                                                                           debugPrint("Ad : ${result[index][1]} Soyad : ${result[index][2]}") ;
                                                                            showDialog(
                                  context: context,
                                  builder: (context) {
                                    return HocaPanelShowAlertWidget(state: _state,hoca:result[index],);
                                  },
                                ); 
              
                                                                          },
                                                                          child: Container(
                                                                            height: 60,
                                                                            decoration: BoxDecoration(
                                                                              border: Border.all(color: Colors.grey)
                                                                            ),
                                                                            child: Text("Ad : ${result[index][1]} Soyad : ${result[index][2]}"),
                                                                          ),
                                                                        ),
                                                                        );
                                                                },itemCount: result.length,),
                                                             ))
                                                    ],),
                                                 ),
                                             );
                                        },);
                              }
                            }
                          },
                          child: Lottie.asset('assets/lotties/info.json',
                              height: AppConstantsDimensions.appWidgetHeight * .7,
                              width: AppConstantsDimensions.appWidgetHeight * .7,
                              fit: BoxFit.cover),
                        )
                      ],
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.keyboard_double_arrow_left_outlined,
                            size: AppConstantsDimensions.appIconLarge,
                          ))
                    ],
                  ),
                  _horizontalNormalSpace()
                ],
              ))
        ],
      ),
    );
  }

  HorizontalSpaceWidget _horizontalNormalSpace() => const HorizontalSpaceWidget(widget: AppConstantsDimensions.appSpaceNormal);

  HorizontalSpaceWidget _horizontalLargeSpace() => const HorizontalSpaceWidget(widget: AppConstantsDimensions.appSpaceLarge);
}
