import 'movie.dart';

class SearchResult {
  SearchResult({this.page, this.totalResults, this.totalPages, this.results});

  final int page;
  final int totalResults;
  final int totalPages;
  final List<Movie> results;

  SearchResult.fromJson(Map<String, dynamic> json)
      : page = json['page'],
        totalResults = json['total_results'],
        totalPages = json['total_pages'],
        results = (json['results'] as List)
            .cast<Map<String, dynamic>>()
            .map((json) => Movie.fromJson(json))
            .toList();

  Map<String, dynamic> toJson() => {
    'page': page,
    'total_results': totalResults,
    'total_pages': totalPages,
    'results': results.map((item) => item.toJson()).toList(),
  };
}