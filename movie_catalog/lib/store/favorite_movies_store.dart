import 'package:mobx/mobx.dart';
import 'package:moviecatalog/data/repositories/favorite_movies_repository.dart';
import 'package:moviecatalog/model/movie.dart';

part 'favorite_movies_store.g.dart';

class FavoriteMoviesStore = _FavoriteMoviesStore
    with _$FavoriteMoviesStore;

abstract class _FavoriteMoviesStore with Store {
  _FavoriteMoviesStore(this.repository) {
    repository.stream.listen(_update);
  }

  final FavoriteMoviesRepository repository;

  @observable
  Map<String, Movie> favorites = {};

  @action
  void addFavorite(Movie movie) {
    repository.save(movie);
  }

  @action
  void removeFavorite(Movie movie) {
    repository.delete(movie.id);
  }

  @action
  void _update(Map<String, Movie> movies) {
    this.favorites = movies;
  }
}
