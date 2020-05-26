import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:moviecatalog/data/repositories/movie_repository.dart';
import 'package:moviecatalog/data/repositories/recent_searches_repository.dart';
import 'package:moviecatalog/model/movie.dart';

part 'search_store.g.dart';

class SearchStore = _SearchStore with _$SearchStore;

abstract class _SearchStore with Store {
  final _movieRepository = MovieRepository();
  final _recentSearchesRepository = RecentSearchesRepository();
  var _query = "";
  var _page = 1;
  int _totalPages = 0;

  @observable
  List<Movie> movies = [];

  @observable
  bool searching = false;

  @observable
  bool hasMoreItems = false;

  @action
  Future<void> search(String query) async {
    searching = true;
    await _recentSearchesRepository.save(query);
    this.movies = await _search(query);
    searching = false;
  }

  @action
  Future<void> loadMore() async {
    if (hasMoreItems) {
      final moreMovies = await _search(_query, _page + 1);
      this.movies += moreMovies;
    }
  }

  Future<List<Movie>> _search(String query, [int page = 1]) async {
    this._query = query;
    this._page = page;

    final result = await _movieRepository.search(query, page);

    this._totalPages =
        result.map((result) => result.totalPages).getOrElse(() => 0);

    this.hasMoreItems = _page < _totalPages;

    debugPrint("$query got $_page out of $_totalPages");

    return result.fold(
      (error) => [],
      (searchResult) =>
          searchResult.results.where((e) => e.posterPath != null).toList(),
    );
  }
}
