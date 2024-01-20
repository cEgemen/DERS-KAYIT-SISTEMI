// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hoca_main_page_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HocaMainViewModel on _HocaMainViewModelBase, Store {
  late final _$_isCurrentOgrenciDerslerLoadingAtom = Atom(
      name: '_HocaMainViewModelBase._isCurrentOgrenciDerslerLoading',
      context: context);

  @override
  bool get _isCurrentOgrenciDerslerLoading {
    _$_isCurrentOgrenciDerslerLoadingAtom.reportRead();
    return super._isCurrentOgrenciDerslerLoading;
  }

  @override
  set _isCurrentOgrenciDerslerLoading(bool value) {
    _$_isCurrentOgrenciDerslerLoadingAtom
        .reportWrite(value, super._isCurrentOgrenciDerslerLoading, () {
      super._isCurrentOgrenciDerslerLoading = value;
    });
  }

  late final _$_isDersiAlanlarLoadingAtom = Atom(
      name: '_HocaMainViewModelBase._isDersiAlanlarLoading', context: context);

  @override
  bool get _isDersiAlanlarLoading {
    _$_isDersiAlanlarLoadingAtom.reportRead();
    return super._isDersiAlanlarLoading;
  }

  @override
  set _isDersiAlanlarLoading(bool value) {
    _$_isDersiAlanlarLoadingAtom
        .reportWrite(value, super._isDersiAlanlarLoading, () {
      super._isDersiAlanlarLoading = value;
    });
  }

  late final _$_isCurrentOgrenciIlgiAlanlariLoadingAtom = Atom(
      name: '_HocaMainViewModelBase._isCurrentOgrenciIlgiAlanlariLoading',
      context: context);

  @override
  bool get _isCurrentOgrenciIlgiAlanlariLoading {
    _$_isCurrentOgrenciIlgiAlanlariLoadingAtom.reportRead();
    return super._isCurrentOgrenciIlgiAlanlariLoading;
  }

  @override
  set _isCurrentOgrenciIlgiAlanlariLoading(bool value) {
    _$_isCurrentOgrenciIlgiAlanlariLoadingAtom
        .reportWrite(value, super._isCurrentOgrenciIlgiAlanlariLoading, () {
      super._isCurrentOgrenciIlgiAlanlariLoading = value;
    });
  }

  late final _$_isFilterOgrenciLoadingAtom = Atom(
      name: '_HocaMainViewModelBase._isFilterOgrenciLoading', context: context);

  @override
  bool get _isFilterOgrenciLoading {
    _$_isFilterOgrenciLoadingAtom.reportRead();
    return super._isFilterOgrenciLoading;
  }

  @override
  set _isFilterOgrenciLoading(bool value) {
    _$_isFilterOgrenciLoadingAtom
        .reportWrite(value, super._isFilterOgrenciLoading, () {
      super._isFilterOgrenciLoading = value;
    });
  }

  late final _$_isHaveMessageAtom =
      Atom(name: '_HocaMainViewModelBase._isHaveMessage', context: context);

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

  late final _$_isHocaTalepOlusturanlarListLoadingAtom = Atom(
      name: '_HocaMainViewModelBase._isHocaTalepOlusturanlarListLoading',
      context: context);

  @override
  bool get _isHocaTalepOlusturanlarListLoading {
    _$_isHocaTalepOlusturanlarListLoadingAtom.reportRead();
    return super._isHocaTalepOlusturanlarListLoading;
  }

  @override
  set _isHocaTalepOlusturanlarListLoading(bool value) {
    _$_isHocaTalepOlusturanlarListLoadingAtom
        .reportWrite(value, super._isHocaTalepOlusturanlarListLoading, () {
      super._isHocaTalepOlusturanlarListLoading = value;
    });
  }

  late final _$_isDersLoadingAtom =
      Atom(name: '_HocaMainViewModelBase._isDersLoading', context: context);

  @override
  bool get _isDersLoading {
    _$_isDersLoadingAtom.reportRead();
    return super._isDersLoading;
  }

  @override
  set _isDersLoading(bool value) {
    _$_isDersLoadingAtom.reportWrite(value, super._isDersLoading, () {
      super._isDersLoading = value;
    });
  }

  late final _$_currentSelectButtonAtom = Atom(
      name: '_HocaMainViewModelBase._currentSelectButton', context: context);

  @override
  String get _currentSelectButton {
    _$_currentSelectButtonAtom.reportRead();
    return super._currentSelectButton;
  }

  @override
  set _currentSelectButton(String value) {
    _$_currentSelectButtonAtom.reportWrite(value, super._currentSelectButton,
        () {
      super._currentSelectButton = value;
    });
  }

  late final _$getOgrenciTalepDataListAsyncAction = AsyncAction(
      '_HocaMainViewModelBase.getOgrenciTalepDataList',
      context: context);

  @override
  Future<void> getOgrenciTalepDataList(int id) {
    return _$getOgrenciTalepDataListAsyncAction
        .run(() => super.getOgrenciTalepDataList(id));
  }

  late final _$getDersDataAsyncAction =
      AsyncAction('_HocaMainViewModelBase.getDersData', context: context);

  @override
  Future<void> getDersData(List<int> dersId, {String? specialKey}) {
    return _$getDersDataAsyncAction
        .run(() => super.getDersData(dersId, specialKey: specialKey));
  }

  late final _$getFilteOgrenciDataAsyncAction = AsyncAction(
      '_HocaMainViewModelBase.getFilteOgrenciData',
      context: context);

  @override
  Future<void> getFilteOgrenciData(int index, String text) {
    return _$getFilteOgrenciDataAsyncAction
        .run(() => super.getFilteOgrenciData(index, text));
  }

  late final _$getDersiOnaylananlarDataListAsyncAction = AsyncAction(
      '_HocaMainViewModelBase.getDersiOnaylananlarDataList',
      context: context);

  @override
  Future<void> getDersiOnaylananlarDataList(int id) {
    return _$getDersiOnaylananlarDataListAsyncAction
        .run(() => super.getDersiOnaylananlarDataList(id));
  }

  late final _$getAllMessageAsyncAction =
      AsyncAction('_HocaMainViewModelBase.getAllMessage', context: context);

  @override
  Future<void> getAllMessage(int userId) {
    return _$getAllMessageAsyncAction.run(() => super.getAllMessage(userId));
  }

  late final _$getCurrentOgrenciDerslerAsyncAction = AsyncAction(
      '_HocaMainViewModelBase.getCurrentOgrenciDersler',
      context: context);

  @override
  Future<void> getCurrentOgrenciDersler(int id) {
    return _$getCurrentOgrenciDerslerAsyncAction
        .run(() => super.getCurrentOgrenciDersler(id));
  }

  late final _$getCurrentOgrenciIlgiAlanlariAsyncAction = AsyncAction(
      '_HocaMainViewModelBase.getCurrentOgrenciIlgiAlanlari',
      context: context);

  @override
  Future<void> getCurrentOgrenciIlgiAlanlari(int id) {
    return _$getCurrentOgrenciIlgiAlanlariAsyncAction
        .run(() => super.getCurrentOgrenciIlgiAlanlari(id));
  }

  late final _$_HocaMainViewModelBaseActionController =
      ActionController(name: '_HocaMainViewModelBase', context: context);

  @override
  void changeStateMessage() {
    final _$actionInfo = _$_HocaMainViewModelBaseActionController.startAction(
        name: '_HocaMainViewModelBase.changeStateMessage');
    try {
      return super.changeStateMessage();
    } finally {
      _$_HocaMainViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeStateTopButtons(String buttonName) {
    final _$actionInfo = _$_HocaMainViewModelBaseActionController.startAction(
        name: '_HocaMainViewModelBase.changeStateTopButtons');
    try {
      return super.changeStateTopButtons(buttonName);
    } finally {
      _$_HocaMainViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
