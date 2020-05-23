// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SearchStore on _SearchStore, Store {
  Computed<bool> _$hasLoadMoreComputed;

  @override
  bool get hasLoadMore =>
      (_$hasLoadMoreComputed ??= Computed<bool>(() => super.hasLoadMore,
              name: '_SearchStore.hasLoadMore'))
          .value;

  final _$moviesAtom = Atom(name: '_SearchStore.movies');

  @override
  List<Movie> get movies {
    _$moviesAtom.reportRead();
    return super.movies;
  }

  @override
  set movies(List<Movie> value) {
    _$moviesAtom.reportWrite(value, super.movies, () {
      super.movies = value;
    });
  }

  final _$searchingAtom = Atom(name: '_SearchStore.searching');

  @override
  bool get searching {
    _$searchingAtom.reportRead();
    return super.searching;
  }

  @override
  set searching(bool value) {
    _$searchingAtom.reportWrite(value, super.searching, () {
      super.searching = value;
    });
  }

  final _$loadingMoreAtom = Atom(name: '_SearchStore.loadingMore');

  @override
  bool get loadingMore {
    _$loadingMoreAtom.reportRead();
    return super.loadingMore;
  }

  @override
  set loadingMore(bool value) {
    _$loadingMoreAtom.reportWrite(value, super.loadingMore, () {
      super.loadingMore = value;
    });
  }

  final _$searchAsyncAction = AsyncAction('_SearchStore.search');

  @override
  Future<void> search(String query) {
    return _$searchAsyncAction.run(() => super.search(query));
  }

  final _$loadMoreAsyncAction = AsyncAction('_SearchStore.loadMore');

  @override
  Future<void> loadMore() {
    return _$loadMoreAsyncAction.run(() => super.loadMore());
  }

  @override
  String toString() {
    return '''
movies: ${movies},
searching: ${searching},
loadingMore: ${loadingMore},
hasLoadMore: ${hasLoadMore}
    ''';
  }
}
