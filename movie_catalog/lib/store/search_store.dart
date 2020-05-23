import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:moviecatalog/data/repositories/movie_repository.dart';
import 'package:moviecatalog/data/repositories/recent_searches_repository.dart';
import 'package:moviecatalog/model/http_error.dart';
import 'package:moviecatalog/model/movie.dart';
import 'package:moviecatalog/model/search_result.dart';

part 'search_store.g.dart';

class SearchStore = _SearchStore with _$SearchStore;

abstract class _SearchStore with Store {
  final _movieRepository = MovieRepository();
  final _recentSearchesRepository = RecentSearchesRepository();
  var _query = "";
  var _page = 1;
  int _totalPages;

  @observable
  List<Movie> movies = [];

  @observable
  bool searching = false;

  @observable
  bool loadingMore = false;

  @computed
  bool get hasLoadMore => _page < _totalPages;

  @action
  Future<void> search(String query) async {
    searching = true;
    await _recentSearchesRepository.save(query);
    this.movies = await _search(query);
    searching = false;
  }

  @action
  Future<void> loadMore() async {
    loadingMore = true;
    final moreMovies = await _search(_query, _page + 1);
    this.movies += moreMovies;
    loadingMore = false;
  }

  Future<List<Movie>> _search(String query, [int page = 1]) async {
    this._query = query;
    this._page = page;

    final result = await _movieRepository.search(query, page);

    this._totalPages =
        result.map((result) => result.totalPages).getOrElse(() => 0);

    return result.fold(
      (error) => [],
      (searchResult) =>
          searchResult.results.where((e) => e.posterPath != null).toList(),
    );
  }
}
