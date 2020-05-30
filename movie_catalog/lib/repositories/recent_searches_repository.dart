import 'package:dartz/dartz.dart';
import 'package:moviecatalog/infra/key_value_storage.dart';

abstract class RecentSearchesRepository {
  Future<List<String>> fetch({String query, int limit = 10});

  Future save(String query);
}

class RecentSearchesRepositoryImpl implements RecentSearchesRepository {
  RecentSearchesRepositoryImpl(this._storage);

  final KeyValueStorage _storage;

  static const KEY = 'searches';

  Future<List<String>> fetch({String query, int limit = 10}) async {
    final searches = await _getSearches();

    return searches
        .map(_sortByMostRecent)
        .map(_filterBy(query))
        .fold(() => [], (items) => items.take(limit).toList());
  }

  Future save(String query) async {
    var option = await _getSearches();

    Map searches = option.getOrElse(() => Map());

    searches.update(
      query,
      (old) => DateTime.now().millisecondsSinceEpoch,
      ifAbsent: () => DateTime.now().millisecondsSinceEpoch,
    );

    _storage.save(KEY, searches);
  }

  Future<Option<dynamic>> _getSearches() async {
    return await _storage.load(KEY);
  }

  List<String> _sortByMostRecent(data) {
    var map = data as Map;
    var entries = map.entries.toList();
    entries.sort((a, b) => a.value > b.value ? -1 : 1);
    return entries.map((e) => e.key.toString()).toList();
  }

  Function(List<String> items) _filterBy(String query) {
    return query == null || query.isEmpty
        ? (items) => items
        : (items) => items.where((q) => q.contains(query));
  }
}
