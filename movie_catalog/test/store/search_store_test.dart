import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_data/mock_data.dart';
import 'package:mockito/mockito.dart';
import 'package:moviecatalog/repositories/movie_repository.dart';
import 'package:moviecatalog/repositories/recent_searches_repository.dart';
import 'package:moviecatalog/store/search_store.dart';

import '../mocks.dart';

void main() {
  group("FavoriteButtonStoreTest", () {
    test('Search should update result, page and total page', () async {
      MovieRepository movieRepository = MockMovieRepository();
      RecentSearchesRepository recentSearchRepository =
          MockRecentSearchesRepository();

      final store = SearchStore(movieRepository, recentSearchRepository);

      final query = mockName();

      final searchResult = generateSearchResult();

      when(movieRepository.search(query, 1))
          .thenAnswer((realInvocation) async => Right(searchResult));

      store.search(query);

      expect(store.searching, true);

      await untilCalled(movieRepository.search(query, 1));

      verify(recentSearchRepository.save(query));

      await Future.delayed(Duration(seconds: 1));

      expect(store.searching, false);
      expect(store.movies, searchResult.results);
      expect(store.hasMoreItems, searchResult.page < searchResult.totalPages);
    });

    test('Load more should increment result, page and total page', () async {
      MovieRepository movieRepository = MockMovieRepository();
      RecentSearchesRepository recentSearchRepository =
          MockRecentSearchesRepository();

      final store = SearchStore(movieRepository, recentSearchRepository);

      final query = mockName();

      final searchResult = generateSearchResult(page: 1, lastPage: 2);
      final loadMoreResult = generateSearchResult(page: 2, lastPage: 2);

      when(movieRepository.search(query, 1))
          .thenAnswer((_) async => Right(searchResult));

      when(movieRepository.search(query, 2))
          .thenAnswer((_) async => Right(loadMoreResult));

      await store.search(query);

      await store.loadMore();

      await Future.delayed(Duration(seconds: 1));

      verify(movieRepository.search(query, 1));
      verify(movieRepository.search(query, 2));

      expect(store.movies, searchResult.results + loadMoreResult.results);
      expect(store.hasMoreItems, false);
    });
  });
}
