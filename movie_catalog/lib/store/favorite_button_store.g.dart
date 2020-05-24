// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_button_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FavoriteButtonStore on _FavoriteButtonStore, Store {
  final _$isFavoriteAtom = Atom(name: '_FavoriteButtonStore.isFavorite');

  @override
  bool get isFavorite {
    _$isFavoriteAtom.reportRead();
    return super.isFavorite;
  }

  @override
  set isFavorite(bool value) {
    _$isFavoriteAtom.reportWrite(value, super.isFavorite, () {
      super.isFavorite = value;
    });
  }

  final _$_FavoriteButtonStoreActionController =
      ActionController(name: '_FavoriteButtonStore');

  @override
  void _update(Map<String, Movie> movies) {
    final _$actionInfo = _$_FavoriteButtonStoreActionController.startAction(
        name: '_FavoriteButtonStore._update');
    try {
      return super._update(movies);
    } finally {
      _$_FavoriteButtonStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isFavorite: ${isFavorite}
    ''';
  }
}
