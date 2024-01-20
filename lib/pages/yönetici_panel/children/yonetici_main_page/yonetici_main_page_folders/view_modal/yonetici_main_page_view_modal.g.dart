// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'yonetici_main_page_view_modal.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$YoneticiMainPageViewModal on _YoneticiMainPageViewModalBase, Store {
  late final _$isNextAtom =
      Atom(name: '_YoneticiMainPageViewModalBase.isNext', context: context);

  @override
  bool get isNext {
    _$isNextAtom.reportRead();
    return super.isNext;
  }

  @override
  set isNext(bool value) {
    _$isNextAtom.reportWrite(value, super.isNext, () {
      super.isNext = value;
    });
  }

  late final _$_isHaveMessageAtom = Atom(
      name: '_YoneticiMainPageViewModalBase._isHaveMessage', context: context);

  @override
  bool get _isHaveMessage {
    _$_isHaveMessageAtom.reportRead();
    return super._isHaveMessage;
  }

  @override
  set _isHaveMessage(bool value) {
    _$_isHaveMessageAtom.reportWrite(value, super._isHaveMessage, () {
      super._isHaveMessage = value;
    });
  }

  late final _$bitisDateSetLoadingAtom = Atom(
      name: '_YoneticiMainPageViewModalBase.bitisDateSetLoading',
      context: context);

  @override
  bool get bitisDateSetLoading {
    _$bitisDateSetLoadingAtom.reportRead();
    return super.bitisDateSetLoading;
  }

  @override
  set bitisDateSetLoading(bool value) {
    _$bitisDateSetLoadingAtom.reportWrite(value, super.bitisDateSetLoading, () {
      super.bitisDateSetLoading = value;
    });
  }

  late final _$dersBitisLoadingAtom = Atom(
      name: '_YoneticiMainPageViewModalBase.dersBitisLoading',
      context: context);

  @override
  bool get dersBitisLoading {
    _$dersBitisLoadingAtom.reportRead();
    return super.dersBitisLoading;
  }

  @override
  set dersBitisLoading(bool value) {
    _$dersBitisLoadingAtom.reportWrite(value, super.dersBitisLoading, () {
      super.dersBitisLoading = value;
    });
  }

  late final _$_isReadyResetAtom = Atom(
      name: '_YoneticiMainPageViewModalBase._isReadyReset', context: context);

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

  late final _$_isReadyKayitAtom = Atom(
      name: '_YoneticiMainPageViewModalBase._isReadyKayit', context: context);

  @override
  bool get _isReadyKayit {
    _$_isReadyKayitAtom.reportRead();
    return super._isReadyKayit;
  }

  @override
  set _isReadyKayit(bool value) {
    _$_isReadyKayitAtom.reportWrite(value, super._isReadyKayit, () {
      super._isReadyKayit = value;
    });
  }

  late final _$_isGecmisTaleplerLoadingAtom = Atom(
      name: '_YoneticiMainPageViewModalBase._isGecmisTaleplerLoading',
      context: context);

  @override
  bool get _isGecmisTaleplerLoading {
    _$_isGecmisTaleplerLoadingAtom.reportRead();
    return super._isGecmisTaleplerLoading;
  }

  @override
  set _isGecmisTaleplerLoading(bool value) {
    _$_isGecmisTaleplerLoadingAtom
        .reportWrite(value, super._isGecmisTaleplerLoading, () {
      super._isGecmisTaleplerLoading = value;
    });
  }

  late final _$_isSistemAyarlariLoadingAtom = Atom(
      name: '_YoneticiMainPageViewModalBase._isSistemAyarlariLoading',
      context: context);

  @override
  bool get _isSistemAyarlariLoading {
    _$_isSistemAyarlariLoadingAtom.reportRead();
    return super._isSistemAyarlariLoading;
  }

  @override
  set _isSistemAyarlariLoading(bool value) {
    _$_isSistemAyarlariLoadingAtom
        .reportWrite(value, super._isSistemAyarlariLoading, () {
      super._isSistemAyarlariLoading = value;
    });
  }

  late final _$getAllGecmisTalepDataListAsyncAction = AsyncAction(
      '_YoneticiMainPageViewModalBase.getAllGecmisTalepDataList',
      context: context);

  @override
  Future<void> getAllGecmisTalepDataList() {
    return _$getAllGecmisTalepDataListAsyncAction
        .run(() => super.getAllGecmisTalepDataList());
  }

  late final _$getSistemAyarlariAsyncAction = AsyncAction(
      '_YoneticiMainPageViewModalBase.getSistemAyarlari',
      context: context);

  @override
  Future<void> getSistemAyarlari() {
    return _$getSistemAyarlariAsyncAction.run(() => super.getSistemAyarlari());
  }

  late final _$getAllMessageYoneticiAsyncAction = AsyncAction(
      '_YoneticiMainPageViewModalBase.getAllMessageYonetici',
      context: context);

  @override
  Future<void> getAllMessageYonetici() {
    return _$getAllMessageYoneticiAsyncAction
        .run(() => super.getAllMessageYonetici());
  }

  late final _$_YoneticiMainPageViewModalBaseActionController =
      ActionController(
          name: '_YoneticiMainPageViewModalBase', context: context);

  @override
  void nextPage() {
    final _$actionInfo = _$_YoneticiMainPageViewModalBaseActionController
        .startAction(name: '_YoneticiMainPageViewModalBase.nextPage');
    try {
      return super.nextPage();
    } finally {
      _$_YoneticiMainPageViewModalBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getBitisDate(int day) {
    final _$actionInfo = _$_YoneticiMainPageViewModalBaseActionController
        .startAction(name: '_YoneticiMainPageViewModalBase.getBitisDate');
    try {
      return super.getBitisDate(day);
    } finally {
      _$_YoneticiMainPageViewModalBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getSetBitisDate(int day) {
    final _$actionInfo = _$_YoneticiMainPageViewModalBaseActionController
        .startAction(name: '_YoneticiMainPageViewModalBase.getSetBitisDate');
    try {
      return super.getSetBitisDate(day);
    } finally {
      _$_YoneticiMainPageViewModalBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void kayitButtonState() {
    final _$actionInfo = _$_YoneticiMainPageViewModalBaseActionController
        .startAction(name: '_YoneticiMainPageViewModalBase.kayitButtonState');
    try {
      return super.kayitButtonState();
    } finally {
      _$_YoneticiMainPageViewModalBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetButtonState() {
    final _$actionInfo = _$_YoneticiMainPageViewModalBaseActionController
        .startAction(name: '_YoneticiMainPageViewModalBase.resetButtonState');
    try {
      return super.resetButtonState();
    } finally {
      _$_YoneticiMainPageViewModalBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isNext: ${isNext},
bitisDateSetLoading: ${bitisDateSetLoading},
dersBitisLoading: ${dersBitisLoading}
    ''';
  }
}
