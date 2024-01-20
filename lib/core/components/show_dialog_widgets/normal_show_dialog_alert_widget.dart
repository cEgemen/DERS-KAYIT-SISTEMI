
import 'package:flutter/material.dart';

class ShowDialogAlertWidget extends StatelessWidget {
  const ShowDialogAlertWidget({required String title,required String contentText,super.key}):
   _title = title , _contentText = contentText ;
  final String _title;
  final String _contentText;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
                                    actions: [
                                      Center(
                                        child: Text(
                                          _title,
                                          style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const Divider(),
                                       Center(
                                          child: Text(
                                              _contentText)),
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("Kapat"))
                                    ],
                                  );
  }
}