// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ogrenci_setup_view_modal.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OgrenciSetupViewModal on _OgrenciSetupViewModalBase, Store {
  late final _$_ilgiAlanlariAtom =
      Atom(name: '_OgrenciSetupViewModalBase._ilgiAlanlari', context: context);

  @override
  List<Map<String, dynamic>> get _ilgiAlanlari {
    _$_ilgiAlanlariAtom.reportRead();
    return super._ilgiAlanlari;
  }

  @override
  set _ilgiAlanlari(List<Map<String, dynamic>> value) {
    _$_ilgiAlanlariAtom.reportWrite(value, super._ilgiAlanlari, () {
      super._ilgiAlanlari = value;
    });
  }

  late final _$_derslerAtom =
      Atom(name: '_OgrenciSetupViewModalBase._dersler', context: context);

  @override
  List<Map<String, dynamic>> get _dersler {
    _$_derslerAtom.reportRead();
    return super._dersler;
  }

  @override
  set _dersler(List<Map<String, dynamic>> value) {
    _$_derslerAtom.reportWrite(value, super._dersler, () {
      super._dersler = value;
    });
  }

  late final _$_isModelLoadingAtom = Atom(
      name: '_OgrenciSetupViewModalBase._isModelLoading', context: context);

  @override
  bool get _isModelLoading {
    _$_isModelLoadingAtom.reportRead();
    return super._isModelLoading;
  }

  @override
  set _isModelLoading(bool value) {
    _$_isModelLoadingAtom.reportWrite(value, super._isModelLoading, () {
      super._isModelLoading = value;
    });
  }

  late final _$_isIlgiAlanlariLoadingAtom = Atom(
      name: '_OgrenciSetupViewModalBase._isIlgiAlanlariLoading',
      context: context);

  @override
  bool get _isIlgiAlanlariLoading {
    _$_isIlgiAlanlariLoadingAtom.reportRead();
    return super._isIlgiAlanlariLoading;
  }

  @override
  set _isIlgiAlanlariLoading(bool value) {
    _$_isIlgiAlanlariLoadingAtom
        .reportWrite(value, super._isIlgiAlanlariLoading, () {
      super._isIlgiAlanlariLoading = value;
    });
  }

  late final _$_isDerslerLoadingAtom = Atom(
      name: '_OgrenciSetupViewModalBase._isDerslerLoading', context: context);

  @override
  bool get _isDerslerLoading {
    _$_isDerslerLoadingAtom.reportRead();
    return super._isDerslerLoading;
  }

  @override
  set _isDerslerLoading(bool value) {
    _$_isDerslerLoadingAtom.reportWrite(value, super._isDerslerLoading, () {
      super._isDerslerLoading = value;
    });
  }

  late final _$_transkriptFileAtom = Atom(
      name: '_OgrenciSetupViewModalBase._transkriptFile', context: context);

  @override
  FilePickerResult? get _transkriptFile {
    _$_transkriptFileAtom.reportRead();
    return super._transkriptFile;
  }

  @override
  set _transkriptFile(FilePickerResult? value) {
    _$_transkriptFileAtom.reportWrite(value, super._transkriptFile, () {
      super._transkriptFile = value;
    });
  }

  late final _$getCurrentUserAsyncAction = AsyncAction(
      '_OgrenciSetupViewModalBase.getCurrentUser',
      context: context);

  @override
  Future<void> getCurrentUser(int id, SqlTableName tableName) {
    return _$getCurrentUserAsyncAction
        .run(() => super.getCurrentUser(id, tableName));
  }

  late final _$getAllIlgiAlaniAsyncAction = AsyncAction(
      '_OgrenciSetupViewModalBase.getAllIlgiAlani',
      context: context);

  @override
  Future<void> getAllIlgiAlani() {
    return _$getAllIlgiAlaniAsyncAction.run(() => super.getAllIlgiAlani());
  }

  late final _$getDerslerAsyncAction =
      AsyncAction('_OgrenciSetupViewModalBase.getDersler', context: context);

  @override
  Future<void> getDersler() {
    return _$getDerslerAsyncAction.run(() => super.getDersler());
  }

  late final _$pickFileAsyncAction =
      AsyncAction('_OgrenciSetupViewModalBase.pickFile', context: context);

  @override
  Future<void> pickFile() {
    return _$pickFileAsyncAction.run(() => super.pickFile());
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
