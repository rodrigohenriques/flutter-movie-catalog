import 'dart:async';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:moviecatalog/model/movie.dart';
import 'package:moviecatalog/repositories/favorite_movies_repository.dart';
import 'package:moviecatalog/store/favorite_button_store.dart';

import '../repositories/favorite_movies_repository_test.dart';

void main() {
  group("FavoriteButtonStoreTest", () {
    test('Attribute favorite state on create', () async {
      final movie = generateMovie();
      final repo = MockFavoriteMoviesRepository();

      var initialFavoriteState = Random().nextBool();

      when(repo.exists(movie.id)).thenReturn(initialFavoriteState);

      final store = FavoriteButtonStore(movie, repo);

      expect(store.isFavorite, initialFavoriteState);
    });

    test('Add favorite should update state when connected', () async {
      final movie = generateMovie();
      final repo = MockFavoriteMoviesRepository();

      // ignore: close_sinks
      final streamController = StreamController<Map<String, Movie>>.broadcast();

      when(repo.stream).thenAnswer((_) => streamController.stream);
      when(repo.exists(movie.id)).thenReturn(false);
      when(repo.save(movie)).thenAnswer((realInvocation) {
        streamController.add({ movie.id: movie });
      });

      final store = FavoriteButtonStore(movie, repo);

      store.connect();

      store.addFavorite();

      await Future.delayed(Duration(seconds: 1));

      expect(store.isFavorite, true);
    });

    test('Remove favorite should update state when connected', () async {
      final movie = generateMovie();
      final repo = MockFavoriteMoviesRepository();

      // ignore: close_sinks
      final streamController = StreamController<Map<String, Movie>>.broadcast();

      when(repo.stream).thenAnswer((_) => streamController.stream);
      when(repo.exists(movie.id)).thenReturn(true);
      when(repo.delete(movie.id)).thenAnswer((realInvocation) {
        streamController.add({});
      });

      final store = FavoriteButtonStore(movie, repo);

      store.connect();

      store.removeFavorite();

      await Future.delayed(Duration(seconds: 1));

      expect(store.isFavorite, false);
    });
  });
}

class MockFavoriteMoviesRepository extends Mock
    implements FavoriteMoviesRepository {}
