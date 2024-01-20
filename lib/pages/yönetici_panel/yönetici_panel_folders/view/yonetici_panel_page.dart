import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/enums/sql_table_names_enum.dart';
import '../../../../core/services/sql_select_service.dart';
import '../../../y%C3%B6netici_panel/y%C3%B6netici_panel_folders/widgets/yonetici_panel_custom_button.dart';
import '../../../y%C3%B6netici_panel/y%C3%B6netici_panel_folders/widgets/yonetici_panel_custom_text_field_widget.dart';
import '../../../../core/components/show_dialog_widgets/normal_show_dialog_alert_widget.dart';
import '../../../../core/components/space_widgets/horizontal_space_widget.dart';
import '../../../../core/constants/app_constant_dimensions/app_dimensions.dart';
import '../view_modal/yonetici_panel_view_modal.dart';
import '../widgets/yonetici_panel_custom_password_text_field.dart';
import '../widgets/yonetici_panel_custom_show_alert_widget.dart';

class YoneticiPanelPage extends StatefulWidget {
  const YoneticiPanelPage({super.key});

  @override
  State<YoneticiPanelPage> createState() => _YoneticiPanelPageState();
}

class _YoneticiPanelPageState extends State<YoneticiPanelPage> {
  final YoneticiPanelViewModal _state = YoneticiPanelViewModal();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _state.dispose();
  }

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
                    "assets/images/yonetici.png",
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
                  YoneticiPanelCustomTextFormField(
                    state: _state,
                    onChanged: (value) {
                      _state.changeButtonState();
                    },
                  ),
                  _horizontalLargeSpace(),
                  YoneticiPanelCustomPasswordTextFormField(
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
                          builder: (context) => YoneticiPanelCustomButton(
                            isReady: _state.isDone,
                            buttonTitle: _state.strings.buttonTitle,
                            onPressed: () {
                              SqlSelectService.userInitialPanelControlled(
                                      _state.kullaniciController.text, _state.passwordController.text, SqlTableName.yonetici)
                                  .then((value) {
                                if (value[0][0] != -1) {
                                  _state.toYoneticiMainPage(context);
                                }
                              });
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
                                      title: "Bilgilendirme !!",
                                      contentText:
                                          "Sisteme Ilk Kez Giris Yapıyorsanız Yeni Sifre Almak Icin Lütfen Kullanıcı Adı Kısmını Bos Bırakmayınız");
                                },
                              );
                            } else {
                              final result =
                                  await SqlSelectService.userInitialLoginControlled(_state.kullaniciController.text, SqlTableName.yonetici);
                              if (result.length == 1) {
                                // ignore: use_build_context_synchronously
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return YoneticiPanelShowAlertWidget(state: _state);
                                  },
                                );
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
