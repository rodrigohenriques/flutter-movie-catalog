import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:moviecatalog/infra/key_value_storage.dart';
import 'package:moviecatalog/repositories/favorite_movies_repository.dart';

import '../mocks.dart';

void main() {
  group("FavoriteMoviesRepositoryTest", () {
    test('Save movie', () async {
      KeyValueStorage mockStorage = MockKeyValueStorage();

      FavoriteMoviesRepositoryImpl repository =
          FavoriteMoviesRepositoryImpl(mockStorage);

      when(mockStorage.load(FavoriteMoviesRepositoryImpl.KEY))
          .thenAnswer((_) => Future.value(None()));

      when(mockStorage.save(FavoriteMoviesRepositoryImpl.KEY, any))
          .thenAnswer((realInvocation) => Future(() {}));

      var movie = generateMovie();

      repository.save(movie);

      await untilCalled(
          mockStorage.save(FavoriteMoviesRepositoryImpl.KEY, any));

      verify(mockStorage.load(FavoriteMoviesRepositoryImpl.KEY));
      verify(mockStorage.save(
        FavoriteMoviesRepositoryImpl.KEY,
        repository.cache,
      ));

      expect(repository.cache.containsKey(movie.id), true);

      repository.stream.listen(expectAsync1((favorites) {
        expect(favorites, {movie.id: movie});
      }, count: 1));
    });

    test('Delete movie', () async {
      KeyValueStorage mockStorage = MockKeyValueStorage();

      FavoriteMoviesRepositoryImpl repository =
          FavoriteMoviesRepositoryImpl(mockStorage);

      var movie1 = generateMovie();
      var movie2 = generateMovie();
      var movie3 = generateMovie();

      final Map<String, dynamic> storedMovies = {
        movie1.id: movie1.toJson(),
        movie2.id: movie2.toJson(),
        movie3.id: movie3.toJson(),
      };

      when(mockStorage.load(FavoriteMoviesRepositoryImpl.KEY)).thenAnswer(
        (_) => Future.value(Some(storedMovies)),
      );

      when(mockStorage.save(FavoriteMoviesRepositoryImpl.KEY, any))
          .thenAnswer((realInvocation) => Future(() {}));

      repository.delete(movie2.id);

      await untilCalled(
          mockStorage.save(FavoriteMoviesRepositoryImpl.KEY, any));

      verify(mockStorage.load(FavoriteMoviesRepositoryImpl.KEY));
      verify(mockStorage.save(
        FavoriteMoviesRepositoryImpl.KEY,
        repository.cache,
      ));

      expect(repository.cache.containsKey(movie2.id), false);

      repository.stream.listen(expectAsync1((favorites) {
        expect(favorites.containsKey(movie1.id), true);
        expect(favorites.containsKey(movie2.id), false);
        expect(favorites.containsKey(movie3.id), true);
      }, count: 1));
    });
  });
}
