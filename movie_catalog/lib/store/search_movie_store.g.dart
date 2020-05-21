// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_movie_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SearchMovieStore on _SearchMovieStore, Store {
  Computed<bool> _$hasLoadMoreComputed;

  @override
  bool get hasLoadMore =>
      (_$hasLoadMoreComputed ??= Computed<bool>(() => super.hasLoadMore,
              name: '_SearchMovieStore.hasLoadMore'))
          .value;

  final _$moviesAtom = Atom(name: '_SearchMovieStore.movies');

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

  final _$isSearchingAtom = Atom(name: '_SearchMovieStore.isSearching');

  @override
  bool get isSearching {
    _$isSearchingAtom.reportRead();
    return super.isSearching;
  }

  @override
  set isSearching(bool value) {
    _$isSearchingAtom.reportWrite(value, super.isSearching, () {
      super.isSearching = value;
    });
  }

  final _$searchAsyncAction = AsyncAction('_SearchMovieStore.search');

  @override
  Future<void> search(String query) {
    return _$searchAsyncAction.run(() => super.search(query));
  }

  final _$loadMoreAsyncAction = AsyncAction('_SearchMovieStore.loadMore');

  @override
  Future<void> loadMore() {
    return _$loadMoreAsyncAction.run(() => super.loadMore());
  }

  @override
  String toString() {
    return '''
movies: ${movies},
isSearching: ${isSearching},
hasLoadMore: ${hasLoadMore}
    ''';
  }
}