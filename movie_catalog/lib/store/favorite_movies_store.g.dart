// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_movies_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FavoriteMoviesStore on _FavoriteMoviesStore, Store {
  final _$favoritesAtom = Atom(name: '_FavoriteMoviesStore.favorites');

  @override
  Map<String, Movie> get favorites {
    _$favoritesAtom.reportRead();
    return super.favorites;
  }

  @override
  set favorites(Map<String, Movie> value) {
    _$favoritesAtom.reportWrite(value, super.favorites, () {
      super.favorites = value;
    });
  }

  final _$_FavoriteMoviesStoreActionController =
      ActionController(name: '_FavoriteMoviesStore');

  @override
  void addFavorite(Movie movie) {
    final _$actionInfo = _$_FavoriteMoviesStoreActionController.startAction(
        name: '_FavoriteMoviesStore.addFavorite');
    try {
      return super.addFavorite(movie);
    } finally {
      _$_FavoriteMoviesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeFavorite(Movie movie) {
    final _$actionInfo = _$_FavoriteMoviesStoreActionController.startAction(
        name: '_FavoriteMoviesStore.removeFavorite');
    try {
      return super.removeFavorite(movie);
    } finally {
      _$_FavoriteMoviesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _update(Map<String, Movie> movies) {
    final _$actionInfo = _$_FavoriteMoviesStoreActionController.startAction(
        name: '_FavoriteMoviesStore._update');
    try {
      return super._update(movies);
    } finally {
      _$_FavoriteMoviesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
favorites: ${favorites}
    ''';
  }
}
