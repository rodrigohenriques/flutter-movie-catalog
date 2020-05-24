import 'dart:async';

import 'package:localstorage/localstorage.dart';
import 'package:moviecatalog/model/movie.dart';

class FavoriteMoviesRepository {
  static final instance = FavoriteMoviesRepository();

  FavoriteMoviesRepository() {
    print("New favorite movies repository created: ${this.hashCode}");
    _cacheStorageData();
  }

  final LocalStorage _storage = new LocalStorage('favorite_movies.json');

  static const FAVORITES = 'favorites';

  Map<String, Movie> _cachedFavoriteMovies;

  final _streamController = StreamController<List<Movie>>();

  Stream<List<Movie>> get stream => _streamController.stream;

  void save(Movie movie) async {
    await _cacheStorageData();

    _cachedFavoriteMovies.update(
      movie.id.toString(),
      (old) => movie,
      ifAbsent: () => movie,
    );

    _updateLocalStorage(_cachedFavoriteMovies);
  }

  bool exists(int movieId) {
    return _cachedFavoriteMovies.containsKey(movieId.toString());
  }

  void delete(int movieId) async {
    if (_cachedFavoriteMovies.containsKey(movieId.toString())) {
      _cachedFavoriteMovies.remove(movieId.toString());
      _updateLocalStorage(_cachedFavoriteMovies);
    }
  }

  void _updateLocalStorage(Map<String, Movie> data) {
    _storage.setItem(FAVORITES, data);
    _dispatchMovies(data);
  }

  Future _cacheStorageData() async {
    final storageReady = await _storage.ready;

    if (storageReady == false) return null;

    Map<String, dynamic> favorites = _storage.getItem(FAVORITES) ?? Map();

    _cachedFavoriteMovies = favorites.map(
      (key, value) => MapEntry(key, Movie.fromJson(value)),
    );

    _dispatchMovies(_cachedFavoriteMovies);
  }

  void _dispatchMovies(Map<String, Movie> data) {
    _streamController.add(data.values.toList());
  }
}