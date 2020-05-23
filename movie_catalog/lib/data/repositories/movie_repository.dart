import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:moviecatalog/model/http_error.dart';
import 'package:moviecatalog/data/movie_api.dart';
import 'package:moviecatalog/model/search_result.dart';

class MovieRepository {
  final _api = MovieApi();

  Future<Either<HttpError, SearchResult>> search(String query, int page) async {
    var searchUri = _api.searchUri(query, page);

    debugPrint("GET: $searchUri");

    final response = await get(searchUri);

    debugPrint("Response\nCode: ${response.statusCode}\nBody: ${response.body}");

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Right(SearchResult.fromJson(json));
    } else {
      return Left(HttpError(response.statusCode, jsonDecode(response.body)));
    }
  }
}