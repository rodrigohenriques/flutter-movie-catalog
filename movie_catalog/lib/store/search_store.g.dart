// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SearchStore on _SearchStore, Store {
  Computed<bool> _$hasMoreItemsComputed;

  @override
  bool get hasMoreItems =>
      (_$hasMoreItemsComputed ??= Computed<bool>(() => super.hasMoreItems,
              name: '_SearchStore.hasMoreItems'))
          .value;

  final _$_pageAtom = Atom(name: '_SearchStore._page');

  @override
  int get _page {
    _$_pageAtom.reportRead();
    return super._page;
  }

  @override
  set _page(int value) {
    _$_pageAtom.reportWrite(value, super._page, () {
      super._page = value;
    });
  }

  final _$_totalPagesAtom = Atom(name: '_SearchStore._totalPages');

  @override
  int get _totalPages {
    _$_totalPagesAtom.reportRead();
    return super._totalPages;
  }

  @override
  set _totalPages(int value) {
    _$_totalPagesAtom.reportWrite(value, super._totalPages, () {
      super._totalPages = value;
    });
  }

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
hasMoreItems: ${hasMoreItems}
    ''';
  }
}
