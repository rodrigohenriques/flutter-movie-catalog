import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:moviecatalog/infra/local_storage.dart';
import 'package:moviecatalog/model/movie.dart';

abstract class FavoriteMoviesRepository {
  Stream<Map<String, Movie>> get stream;

  void save(Movie movie);

  bool exists(String movieId);

  void delete(String movieId);
}

class FavoriteMoviesRepositoryImpl implements FavoriteMoviesRepository {
  FavoriteMoviesRepositoryImpl(this._storage) {
    debugPrint("New favorite movies repository created: ${this.hashCode}");
    _cacheStorageData();
  }

  final Storage _storage;

  static const _KEY = 'favorites';

  Map<String, Movie> _cachedFavoriteMovies;

  final _streamController = StreamController<Map<String, Movie>>.broadcast();

  Stream<Map<String, Movie>> get stream => _streamController.stream;

  void save(Movie movie) async {
    _cachedFavoriteMovies.update(
      movie.id.toString(),
      (old) => movie,
      ifAbsent: () => movie,
    );

    _store(_cachedFavoriteMovies);
  }

  bool exists(String movieId) {
    return _cachedFavoriteMovies != null &&
        _cachedFavoriteMovies.containsKey(movieId);
  }

  void delete(String movieId) async {
    if (exists(movieId)) {
      _cachedFavoriteMovies.remove(movieId);
      _store(_cachedFavoriteMovies);
    }
  }

  void _store(Map<String, Movie> data) {
    _storage.save(_KEY, data);
    _dispatchMovies(data);
  }

  Future _cacheStorageData() async {
    final optionData = await _storage.load(_KEY);

    Map<String, dynamic> favorites =
        optionData.getOrElse(() => Map<String, dynamic>());

    _cachedFavoriteMovies = favorites.map(
      (key, value) => MapEntry(key, Movie.fromJson(value)),
    );

    _dispatchMovies(_cachedFavoriteMovies);
  }

  void _dispatchMovies(Map<String, Movie> data) {
    _streamController.add(data);
  }
}
