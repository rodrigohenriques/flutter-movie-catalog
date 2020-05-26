import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:moviecatalog/model/movie.dart';
import 'package:moviecatalog/repositories/favorite_movies_repository.dart';

part 'favorite_button_store.g.dart';

class FavoriteButtonStore = _FavoriteButtonStore
    with _$FavoriteButtonStore;

abstract class _FavoriteButtonStore with Store {
  _FavoriteButtonStore(this.movie, this.repository) {
    this.isFavorite = repository.exists(movie.id);
  }

  final Movie movie;
  final FavoriteMoviesRepository repository;

  @observable
  bool isFavorite;

  StreamSubscription<bool> _subscription;

  void connect() {
    _subscription = repository.stream
        .map((event) => event.containsKey(movie.id))
        .where((event) => event != isFavorite)
        .listen(_update);
  }

  void disconnect() {
    _subscription?.cancel();
  }

  void addFavorite() {
    repository.save(movie);
  }

  void removeFavorite() {
    repository.delete(movie.id);
  }

  @action
  void _update(bool isFavorite) {
    this.isFavorite = isFavorite;
  }
}