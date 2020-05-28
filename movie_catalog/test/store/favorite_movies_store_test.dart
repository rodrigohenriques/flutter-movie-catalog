import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:moviecatalog/model/movie.dart';
import 'package:moviecatalog/store/favorite_movies_store.dart';

import '../repositories/favorite_movies_repository_test.dart';
import 'favorite_button_store_test.dart';

void main() {
  group("FavoriteButtonStoreTest", () {
    test('Add favorite movie should update favorites list', () async {
      final repo = MockFavoriteMoviesRepository();

      var movie = generateMovie();

      // ignore: close_sinks
      final streamController = StreamController<Map<String, Movie>>.broadcast();

      when(repo.stream).thenAnswer((_) => streamController.stream);
      when(repo.save(movie))
          .thenAnswer((_) => streamController.add({movie.id: movie}));

      final store = FavoriteMoviesStore(repo);

      store.addFavorite(movie);

      await Future.delayed(Duration(seconds: 1));

      expect(store.favorites, {movie.id: movie});
    });

    test('Remove favorite movie should update favorites list', () async {
      final repo = MockFavoriteMoviesRepository();

      var movie = generateMovie();

      // ignore: close_sinks
      final streamController = StreamController<Map<String, Movie>>.broadcast();

      streamController.add({movie.id: movie});

      when(repo.stream).thenAnswer((_) => streamController.stream);
      when(repo.save(movie)).thenAnswer((_) => streamController.add({}));

      final store = FavoriteMoviesStore(repo);

      store.removeFavorite(movie);

      await Future.delayed(Duration(seconds: 1));

      expect(store.favorites, {});
    });
  });
}
