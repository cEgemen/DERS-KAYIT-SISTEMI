import 'package:flutter/material.dart';

import '../../../../core/components/buttons/normal_button.dart';

class YoneticiPanelCustomButton extends StatelessWidget {
  const YoneticiPanelCustomButton({required String buttonTitle,required bool isReady,required void Function() onPressed,super.key}):_isReady = isReady , _buttonTitle = buttonTitle,_onPressed = onPressed;
  final String _buttonTitle;
  final bool _isReady;
  final void Function() _onPressed;
  @override
  Widget build(BuildContext context) {
    return NormalButton(
      width: MediaQuery.of(context).size.width * .1,
      onPressed: _onPressedCondition(),
      child: Text(_buttonTitle),

    );
  }

 void Function() ? _onPressedCondition() => _isReady ? _onPressed : null;
}