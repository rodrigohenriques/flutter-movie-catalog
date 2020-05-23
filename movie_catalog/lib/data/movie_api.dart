import 'package:global_configuration/global_configuration.dart';

class MovieApi {
  static final _key = GlobalConfiguration().getString("apiKey");
  static const _url = "api.themoviedb.org";
  static const _searchPath = "/3/search/movie";

  Uri searchUri(String query, int page) {
    return Uri.https(_url, _searchPath, {
      "query": query,
      "page": page.toString(),
      "api_key": _key,
      "language": "en-US",
      "include_adult": "false",
    });
  }
}

