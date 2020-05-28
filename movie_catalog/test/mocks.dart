import 'package:http/http.dart';
import 'package:mock_data/mock_data.dart';
import 'package:mockito/mockito.dart';
import 'package:moviecatalog/infra/key_value_storage.dart';
import 'package:moviecatalog/model/movie.dart';
import 'package:moviecatalog/repositories/favorite_movies_repository.dart';

class MockKeyValueStorage extends Mock implements KeyValueStorage {}

class MockClient extends Mock implements Client {}

class MockFavoriteMoviesRepository extends Mock
    implements FavoriteMoviesRepository {}

Movie generateMovie() =>
    Movie(mockUUID(), mockName(), mockString(1000), mockString());