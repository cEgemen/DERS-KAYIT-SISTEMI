// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'yonetici_panel_view_modal.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$YoneticiPanelViewModal on _YoneticiPanelViewModalBase, Store {
  late final _$_isDoneAtom =
      Atom(name: '_YoneticiPanelViewModalBase._isDone', context: context);

  @override
  bool get _isDone {
    _$_isDoneAtom.reportRead();
    return super._isDone;
  }

  @override
  set _isDone(bool value) {
    _$_isDoneAtom.reportWrite(value, super._isDone, () {
      super._isDone = value;
    });
  }

  late final _$_isReadyResetAtom =
      Atom(name: '_YoneticiPanelViewModalBase._isReadyReset', context: context);

  @override
  bool get _isReadyReset {
    _$_isReadyResetAtom.reportRead();
    return super._isReadyReset;
  }

  @override
  set _isReadyReset(bool value) {
    _$_isReadyResetAtom.reportWrite(value, super._isReadyReset, () {
      super._isReadyReset = value;
    });
  }

  late final _$_isReadyComfirmAtom = Atom(
      name: '_YoneticiPanelViewModalBase._isReadyComfirm', context: context);

  @override
  bool get _isReadyComfirm {
    _$_isReadyComfirmAtom.reportRead();
    return super._isReadyComfirm;
  }

  @override
  set _isReadyComfirm(bool value) {
    _$_isReadyComfirmAtom.reportWrite(value, super._isReadyComfirm, () {
      super._isReadyComfirm = value;
    });
  }

  late final _$_YoneticiPanelViewModalBaseActionController =
      ActionController(name: '_YoneticiPanelViewModalBase', context: context);

  @override
  void comfirmButtonState() {
    final _$actionInfo = _$_YoneticiPanelViewModalBaseActionController
        .startAction(name: '_YoneticiPanelViewModalBase.comfirmButtonState');
    try {
      return super.comfirmButtonState();
    } finally {
      _$_YoneticiPanelViewModalBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetButtonState() {
    final _$actionInfo = _$_YoneticiPanelViewModalBaseActionController
        .startAction(name: '_YoneticiPanelViewModalBase.resetButtonState');
    try {
      return super.resetButtonState();
    } finally {
      _$_YoneticiPanelViewModalBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeButtonState() {
    final _$actionInfo = _$_YoneticiPanelViewModalBaseActionController
        .startAction(name: '_YoneticiPanelViewModalBase.changeButtonState');
    try {
      return super.changeButtonState();
    } finally {
      _$_YoneticiPanelViewModalBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
