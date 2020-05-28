import 'dart:math';

import 'package:http/http.dart';
import 'package:mock_data/mock_data.dart';
import 'package:mockito/mockito.dart';
import 'package:moviecatalog/infra/key_value_storage.dart';
import 'package:moviecatalog/model/movie.dart';
import 'package:moviecatalog/model/search_result.dart';
import 'package:moviecatalog/repositories/favorite_movies_repository.dart';
import 'package:moviecatalog/repositories/movie_repository.dart';
import 'package:moviecatalog/repositories/recent_searches_repository.dart';

class MockKeyValueStorage extends Mock implements KeyValueStorage {}

class MockClient extends Mock implements Client {}

class MockFavoriteMoviesRepository extends Mock
    implements FavoriteMoviesRepository {}

class MockRecentSearchesRepository extends Mock
    implements RecentSearchesRepository {}

class MockMovieRepository extends Mock implements MovieRepository {}

Movie generateMovie() =>
    Movie(mockUUID(), mockName(), mockString(1000), mockString());

SearchResult generateSearchResult({
  int page = 1,
  int lastPage,
}) {
  var random = Random();

  var totalPages = lastPage ?? page + random.nextInt(10);

  return SearchResult(
    page: page,
    totalPages: totalPages,
    totalResults: random.nextInt(totalPages * 20),
    results: List.generate(20, (index) => generateMovie()),
  );
}