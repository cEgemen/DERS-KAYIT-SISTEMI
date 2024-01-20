// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ogrenci_main_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OgrenciMainViewModel on _OgrenciMainViewModelBase, Store {
  late final _$gecmisVerilerLoadingAtom = Atom(
      name: '_OgrenciMainViewModelBase.gecmisVerilerLoading', context: context);

  @override
  bool get gecmisVerilerLoading {
    _$gecmisVerilerLoadingAtom.reportRead();
    return super.gecmisVerilerLoading;
  }

  @override
  set gecmisVerilerLoading(bool value) {
    _$gecmisVerilerLoadingAtom.reportWrite(value, super.gecmisVerilerLoading,
        () {
      super.gecmisVerilerLoading = value;
    });
  }

  late final _$_isOgrenciTalepDataLoadingAtom = Atom(
      name: '_OgrenciMainViewModelBase._isOgrenciTalepDataLoading',
      context: context);

  @override
  bool get _isOgrenciTalepDataLoading {
    _$_isOgrenciTalepDataLoadingAtom.reportRead();
    return super._isOgrenciTalepDataLoading;
  }

  @override
  set _isOgrenciTalepDataLoading(bool value) {
    _$_isOgrenciTalepDataLoadingAtom
        .reportWrite(value, super._isOgrenciTalepDataLoading, () {
      super._isOgrenciTalepDataLoading = value;
    });
  }

  late final _$_currentSelectButtonAtom = Atom(
      name: '_OgrenciMainViewModelBase._currentSelectButton', context: context);

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

  late final _$_isDersLoadingAtom =
      Atom(name: '_OgrenciMainViewModelBase._isDersLoading', context: context);

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

  late final _$_isHaveMessageAtom =
      Atom(name: '_OgrenciMainViewModelBase._isHaveMessage', context: context);

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

  late final _$_isLoadingMessageAtom = Atom(
      name: '_OgrenciMainViewModelBase._isLoadingMessage', context: context);

  @override
  bool get _isLoadingMessage {
    _$_isLoadingMessageAtom.reportRead();
    return super._isLoadingMessage;
  }

  @override
  set _isLoadingMessage(bool value) {
    _$_isLoadingMessageAtom.reportWrite(value, super._isLoadingMessage, () {
      super._isLoadingMessage = value;
    });
  }

  late final _$_isFilterHocaLoadingAtom = Atom(
      name: '_OgrenciMainViewModelBase._isFilterHocaLoading', context: context);

  @override
  bool get _isFilterHocaLoading {
    _$_isFilterHocaLoadingAtom.reportRead();
    return super._isFilterHocaLoading;
  }

  @override
  set _isFilterHocaLoading(bool value) {
    _$_isFilterHocaLoadingAtom.reportWrite(value, super._isFilterHocaLoading,
        () {
      super._isFilterHocaLoading = value;
    });
  }

  late final _$_isCurrentHocaDerslerLoadingAtom = Atom(
      name: '_OgrenciMainViewModelBase._isCurrentHocaDerslerLoading',
      context: context);

  @override
  bool get _isCurrentHocaDerslerLoading {
    _$_isCurrentHocaDerslerLoadingAtom.reportRead();
    return super._isCurrentHocaDerslerLoading;
  }

  @override
  set _isCurrentHocaDerslerLoading(bool value) {
    _$_isCurrentHocaDerslerLoadingAtom
        .reportWrite(value, super._isCurrentHocaDerslerLoading, () {
      super._isCurrentHocaDerslerLoading = value;
    });
  }

  late final _$_isCurrentHocaIlgiAlanlariLoadingAtom = Atom(
      name: '_OgrenciMainViewModelBase._isCurrentHocaIlgiAlanlariLoading',
      context: context);

  @override
  bool get _isCurrentHocaIlgiAlanlariLoading {
    _$_isCurrentHocaIlgiAlanlariLoadingAtom.reportRead();
    return super._isCurrentHocaIlgiAlanlariLoading;
  }

  @override
  set _isCurrentHocaIlgiAlanlariLoading(bool value) {
    _$_isCurrentHocaIlgiAlanlariLoadingAtom
        .reportWrite(value, super._isCurrentHocaIlgiAlanlariLoading, () {
      super._isCurrentHocaIlgiAlanlariLoading = value;
    });
  }

  late final _$_isGelenTalepListLoadingAtom = Atom(
      name: '_OgrenciMainViewModelBase._isGelenTalepListLoading',
      context: context);

  @override
  bool get _isGelenTalepListLoading {
    _$_isGelenTalepListLoadingAtom.reportRead();
    return super._isGelenTalepListLoading;
  }

  @override
  set _isGelenTalepListLoading(bool value) {
    _$_isGelenTalepListLoadingAtom
        .reportWrite(value, super._isGelenTalepListLoading, () {
      super._isGelenTalepListLoading = value;
    });
  }

  late final _$getAllMessageAsyncAction =
      AsyncAction('_OgrenciMainViewModelBase.getAllMessage', context: context);

  @override
  Future<void> getAllMessage(int userId) {
    return _$getAllMessageAsyncAction.run(() => super.getAllMessage(userId));
  }

  late final _$getDersDataAsyncAction =
      AsyncAction('_OgrenciMainViewModelBase.getDersData', context: context);

  @override
  Future<void> getDersData(List<int> dersId, {String? specialKey}) {
    return _$getDersDataAsyncAction
        .run(() => super.getDersData(dersId, specialKey: specialKey));
  }

  late final _$getAllGecmisVeriAsyncAction = AsyncAction(
      '_OgrenciMainViewModelBase.getAllGecmisVeri',
      context: context);

  @override
  Future<void> getAllGecmisVeri(int ogrenciId) {
    return _$getAllGecmisVeriAsyncAction
        .run(() => super.getAllGecmisVeri(ogrenciId));
  }

  late final _$getOgrenciTalepDataListAsyncAction = AsyncAction(
      '_OgrenciMainViewModelBase.getOgrenciTalepDataList',
      context: context);

  @override
  Future<void> getOgrenciTalepDataList(int id) {
    return _$getOgrenciTalepDataListAsyncAction
        .run(() => super.getOgrenciTalepDataList(id));
  }

  late final _$getFilteHocaDataAsyncAction = AsyncAction(
      '_OgrenciMainViewModelBase.getFilteHocaData',
      context: context);

  @override
  Future<void> getFilteHocaData(int index, String text) {
    return _$getFilteHocaDataAsyncAction
        .run(() => super.getFilteHocaData(index, text));
  }

  late final _$getCurrentHocaDerslerAsyncAction = AsyncAction(
      '_OgrenciMainViewModelBase.getCurrentHocaDersler',
      context: context);

  @override
  Future<void> getCurrentHocaDersler(int id) {
    return _$getCurrentHocaDerslerAsyncAction
        .run(() => super.getCurrentHocaDersler(id));
  }

  late final _$getCurrentHocaIlgiAlanlariAsyncAction = AsyncAction(
      '_OgrenciMainViewModelBase.getCurrentHocaIlgiAlanlari',
      context: context);

  @override
  Future<void> getCurrentHocaIlgiAlanlari(int id) {
    return _$getCurrentHocaIlgiAlanlariAsyncAction
        .run(() => super.getCurrentHocaIlgiAlanlari(id));
  }

  late final _$getHocaGelenTalepDataListAsyncAction = AsyncAction(
      '_OgrenciMainViewModelBase.getHocaGelenTalepDataList',
      context: context);

  @override
  Future<void> getHocaGelenTalepDataList(int id) {
    return _$getHocaGelenTalepDataListAsyncAction
        .run(() => super.getHocaGelenTalepDataList(id));
  }

  late final _$_OgrenciMainViewModelBaseActionController =
      ActionController(name: '_OgrenciMainViewModelBase', context: context);

  @override
  void changeStateMessage() {
    final _$actionInfo = _$_OgrenciMainViewModelBaseActionController
        .startAction(name: '_OgrenciMainViewModelBase.changeStateMessage');
    try {
      return super.changeStateMessage();
    } finally {
      _$_OgrenciMainViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeStateTopButtons(String buttonName) {
    final _$actionInfo = _$_OgrenciMainViewModelBaseActionController
        .startAction(name: '_OgrenciMainViewModelBase.changeStateTopButtons');
    try {
      return super.changeStateTopButtons(buttonName);
    } finally {
      _$_OgrenciMainViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
gecmisVerilerLoading: ${gecmisVerilerLoading}
    ''';
  }
}
