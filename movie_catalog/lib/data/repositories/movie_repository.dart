import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart';
import 'package:moviecatalog/model/http_error.dart';
import 'package:moviecatalog/model/search_result.dart';

abstract class MovieRepository {
  Future<Either<HttpError, SearchResult>> search(String query, int page);
}

class MovieRepositoryImpl implements MovieRepository {
  static final _key = GlobalConfiguration().getString("apiKey");
  static const _url = "api.themoviedb.org";
  static const _searchPath = "/3/search/movie";

  Future<Either<HttpError, SearchResult>> search(String query, int page) async {
    var searchUri = Uri.https(_url, _searchPath, {
      "query": query,
      "page": page.toString(),
      "api_key": _key,
      "language": "en-US",
      "include_adult": "false",
    });

    final response = await get(searchUri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Right(SearchResult.fromJson(json));
    } else {
      return Left(HttpError(response.statusCode, jsonDecode(response.body)));
    }
  }
}