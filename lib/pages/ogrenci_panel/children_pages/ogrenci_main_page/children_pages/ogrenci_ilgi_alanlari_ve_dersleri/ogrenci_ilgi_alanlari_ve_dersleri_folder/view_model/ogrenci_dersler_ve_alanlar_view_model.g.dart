// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ogrenci_dersler_ve_alanlar_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OgrenciIlgiAlanlariVeDersleriViewModel
    on _OgrenciIlgiAlanlariVeDersleriViewModelBase, Store {
  late final _$_isDersLoadingAtom = Atom(
      name: '_OgrenciIlgiAlanlariVeDersleriViewModelBase._isDersLoading',
      context: context);

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

  late final _$_isIlgiAlanlariLoadingAtom = Atom(
      name:
          '_OgrenciIlgiAlanlariVeDersleriViewModelBase._isIlgiAlanlariLoading',
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

  late final _$getDersDataAsyncAction = AsyncAction(
      '_OgrenciIlgiAlanlariVeDersleriViewModelBase.getDersData',
      context: context);

  @override
  Future<void> getDersData(int ogrenciId, List<int> dersId) {
    return _$getDersDataAsyncAction
        .run(() => super.getDersData(ogrenciId, dersId));
  }

  late final _$getIlgiAlanlariDataAsyncAction = AsyncAction(
      '_OgrenciIlgiAlanlariVeDersleriViewModelBase.getIlgiAlanlariData',
      context: context);

  @override
  Future<void> getIlgiAlanlariData(List<int> ilgiAlanlariId) {
    return _$getIlgiAlanlariDataAsyncAction
        .run(() => super.getIlgiAlanlariData(ilgiAlanlariId));
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
