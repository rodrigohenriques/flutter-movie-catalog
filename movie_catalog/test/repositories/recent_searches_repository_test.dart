import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:moviecatalog/repositories/recent_searches_repository.dart';
import 'package:test/test.dart';

import '../mocks.dart';

void main() {
  group("RecentSearchesRepositoryTest", () {
    test('Save recent search', () async {
      final mockStorage = MockKeyValueStorage();

      RecentSearchesRepository repo = RecentSearchesRepositoryImpl(mockStorage);

      var propertyKey = RecentSearchesRepositoryImpl.KEY;

      when(mockStorage.load(propertyKey))
          .thenAnswer((realInvocation) async => Some(Map<String, dynamic>()));

      final String query = "fast and furious";

      repo.save(query);

      await untilCalled(mockStorage.save(propertyKey, any));

      verify(mockStorage.save(propertyKey, argThat(contains(query))));
    });

    test('Fetch sorted data', () async {
      final mockStorage = MockKeyValueStorage();

      RecentSearchesRepository repo = RecentSearchesRepositoryImpl(mockStorage);

      var propertyKey = RecentSearchesRepositoryImpl.KEY;

      final recentSearches = {
        "memento": 1,
        "fast and furious": 2,
        "lord of the rings": 3,
        "batman": 4,
      };

      when(mockStorage.load(propertyKey))
          .thenAnswer((realInvocation) async => Some(recentSearches));

      final result = await repo.fetch();

      verify(mockStorage.load(propertyKey));

      expect(result.first, recentSearches.keys.last);
      expect(result.last, recentSearches.keys.first);
      expect(result, containsAll(recentSearches.keys));
    });

    test('Fetch limited data', () async {
      final mockStorage = MockKeyValueStorage();

      RecentSearchesRepository repo = RecentSearchesRepositoryImpl(mockStorage);

      var propertyKey = RecentSearchesRepositoryImpl.KEY;

      final recentSearches = {
        "memento": 1,
        "fast and furious": 2,
        "lord of the rings": 3,
        "batman": 4,
      };

      when(mockStorage.load(propertyKey))
          .thenAnswer((realInvocation) async => Some(recentSearches));

      final result = await repo.fetch(limit: 2);

      verify(mockStorage.load(propertyKey));

      expect(result, containsAllInOrder([ "batman", "lord of the rings" ]));
    });

    test('Fetch filtered data', () async {
      final mockStorage = MockKeyValueStorage();

      RecentSearchesRepository repo = RecentSearchesRepositoryImpl(mockStorage);

      var propertyKey = RecentSearchesRepositoryImpl.KEY;

      final recentSearches = {
        "memento": 1,
        "fast and furious": 2,
        "lord of the rings": 3,
        "batman": 4,
        "batman begins": 5,
        "batman: the dark knight": 6,
      };

      when(mockStorage.load(propertyKey))
          .thenAnswer((realInvocation) async => Some(recentSearches));

      final result = await repo.fetch(query: "batman");

      verify(mockStorage.load(propertyKey));

      expect(result.length, 3);
      expect(result, everyElement(contains("batman")));
    });
  });
}
