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
  FavoriteMoviesRepositoryImpl(this._storage);

  final Storage _storage;

  @visibleForTesting
  static const KEY = 'favorites';

  @visibleForTesting
  Map<String, Movie> cache;

  final _streamController = StreamController<Map<String, Movie>>.broadcast();

  Stream<Map<String, Movie>> get stream => _streamController.stream;

  void save(Movie movie) async {
    if (cache == null) await _cacheStorageData();

    cache.update(
      movie.id.toString(),
      (old) => movie,
      ifAbsent: () => movie,
    );

    _store(cache);
  }

  bool exists(String movieId) {
    return cache != null &&
        cache.containsKey(movieId);
  }

  void delete(String movieId) async {
    if (cache == null) await _cacheStorageData();

    if (exists(movieId)) {
      cache.remove(movieId);
      _store(cache);
    }
  }

  void _store(Map<String, Movie> data) async {
    await _storage.save(KEY, data);
    _dispatchMovies(data);
  }

  Future _cacheStorageData() async {
    final optionData = await _storage.load(KEY);

    Map<String, dynamic> favorites =
        optionData.getOrElse(() => Map<String, dynamic>());

    cache = favorites.map(
      (key, value) => MapEntry(key, Movie.fromJson(value)),
    );

    _dispatchMovies(cache);
  }

  void _dispatchMovies(Map<String, Movie> data) {
    _streamController.add(data);
  }
}
