import 'package:dartz/dartz.dart';
import 'package:mobx/mobx.dart';
import 'package:moviecatalog/data/repositories/movie_repository.dart';
import 'package:moviecatalog/model/http_error.dart';
import 'package:moviecatalog/model/movie.dart';
import 'package:moviecatalog/model/search_result.dart';

part 'search_movie_store.g.dart';

class SearchMovieStore = _SearchMovieStore with _$SearchMovieStore;

abstract class _SearchMovieStore with Store {
  final _repository = MovieRepository();
  var _query = "";
  var _page = 1;
  int _totalPages;

  @observable
  List<Movie> movies = [];

  @observable
  bool isSearching = false;

  @computed
  bool get hasLoadMore => _page < _totalPages;

  @action
  Future<void> search(String query) async {
    Either<HttpError, SearchResult> result = await _search(query);

    this._totalPages =
        result.map((result) => result.totalPages).getOrElse(() => 0);

    this.movies = result.fold(
      (error) => [],
      (searchResult) => searchResult.results,
    );
  }

  @action
  Future<void> loadMore() async {
    final result = await _search(_query, _page + 1);

    this.movies += result.fold(
      (error) => [],
      (searchResult) => searchResult.results,
    );
  }

  Future<Either<HttpError, SearchResult>> _search(String query,
      [int page = 1]) async {
    this._query = query;
    this._page = page;

    this.isSearching = true;

    final result = await _repository.search(query, page);

    this.isSearching = false;

    return result;
  }
}
