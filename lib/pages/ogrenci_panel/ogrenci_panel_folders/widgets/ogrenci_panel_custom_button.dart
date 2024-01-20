import 'package:flutter/material.dart';
import '../../../../core/components/buttons/normal_button.dart';

class OgrenciPanelCustomButton extends StatelessWidget {
  const OgrenciPanelCustomButton({required String buttonTitle,required bool isReady,super.key, required void Function() onPressed}):_isReady = isReady , _buttonTitle = buttonTitle,_onPressed = onPressed;
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
