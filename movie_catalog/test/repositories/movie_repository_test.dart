import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:moviecatalog/model/search_result.dart';
import 'package:moviecatalog/repositories/movie_repository.dart';

import '../mocks.dart';

void main() {
  group("MovieRepositoryTest", () {
    test('Search returns error if status code is not 200', () async {
      final client = MockClient();

      when(client.get(any)).thenAnswer((_) async => Response("{}", 500));

      MovieRepository repo = MovieRepositoryImpl(client);

      final result = await repo.search("test", 1);

      expect(result.isLeft(), true);
    });

    test('Search query for page', () async {
      final client = MockClient();

      final searchResult = SearchResult(
        page: 1,
        totalPages: 5,
        totalResults: 100,
        results: List.generate(20, (index) => generateMovie()),
      );

      var json = jsonEncode(searchResult.toJson());

      when(client.get(any)).thenAnswer(
        (_) async => Response(json, 200),
      );

      MovieRepository repo = MovieRepositoryImpl(client);

      final result = await repo.search("test", 1);

      expect(result.isRight(), true);
    });
  });
}
