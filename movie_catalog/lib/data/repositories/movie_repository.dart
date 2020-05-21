import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:moviecatalog/model/http_error.dart';
import 'package:moviecatalog/data/movie_api.dart';
import 'package:moviecatalog/model/search_result.dart';

class MovieRepository {
  final _api = MovieApi();

  Future<Either<HttpError, SearchResult>> search(String query, int page) async {
    final response = await get(_api.searchUri(query, page));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Right(SearchResult.fromJson(json));
    } else {
      return Left(HttpError(response.statusCode, jsonDecode(response.body)));
    }
  }
}