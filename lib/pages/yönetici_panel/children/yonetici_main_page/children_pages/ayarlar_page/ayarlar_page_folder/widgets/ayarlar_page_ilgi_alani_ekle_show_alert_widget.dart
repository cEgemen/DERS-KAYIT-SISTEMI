import 'package:flutter/material.dart';

import '../../../../../../../../core/components/space_widgets/horizontal_space_widget.dart';
import '../../../../../../../../core/constants/app_constant_dimensions/app_dimensions.dart';
import '../../../../../../../../core/enums/sql_table_names_enum.dart';
import '../../../../../../../../core/services/sql_insert_service.dart';

class AyarlarPageIlgiAlaniEkleShowAlertWidget extends StatelessWidget {
  AyarlarPageIlgiAlaniEkleShowAlertWidget({super.key});
  final TextEditingController _textCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: MediaQuery.of(context).size.width * .3,
        height: MediaQuery.of(context).size.height * .3,
        child: Column(
          children: [
          const  Center(
              child: Text("Ilgi Alanı Ekleme Ekranı"),
            ),
            Divider(),
            TextField(
              controller: _textCtrl, 
              decoration:const InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.zero),
              hintText: "Ilgi Alanı Adı",
              ),
            ),
            _horizontalLargeSpace(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: () async {
                   if(_textCtrl.text .isNotEmpty)
                    {
                       await SqlInsertService.addIlgiAlani(_textCtrl.text,SqlTableName.ilgiAlanlari).then((value) {
                            Navigator.of(context).pop();  
                       });
                    }
                }, child:const Text("Ekle")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child:const Text("Iptal"))
              ],
            )
          ],
        ),
      ),
    );
  }

  HorizontalSpaceWidget _horizontalLargeSpace() => const HorizontalSpaceWidget(widget: AppConstantsDimensions.appSpaceLarge);
}
