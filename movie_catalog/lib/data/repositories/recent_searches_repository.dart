import 'package:localstorage/localstorage.dart';

class RecentSearchesRepository {
  final LocalStorage _storage = new LocalStorage('recent_searches.json');

  static const SEARCHES = 'searches';
  
  Future<List<String>> fetch([String query, int limit = 10]) async {
    final storageReady = await _storage.ready;

    if (storageReady == false) return [];

    Map<String, dynamic> searches = _storage.getItem(SEARCHES);

    if (searches == null) return [];

    var entries = searches.entries.toList();

    entries.sort((a, b) => a.value > b.value ? -1 : 1);

    final recentQueries = entries.map((e) => e.key);

    if (query == null || query.isEmpty) {
      return recentQueries.take(limit).toList();
    }

    return recentQueries.where((q) => q.contains(query)).take(limit).toList();
  }

  Future save(String query) async {
    if (query == null || query.isEmpty) return;

    final storageReady = await _storage.ready;

    if (storageReady == false) return;

    Map<String, dynamic> searches = _storage.getItem(SEARCHES) ?? Map();

    searches.update(
      query,
      (old) => DateTime.now().millisecondsSinceEpoch,
      ifAbsent: () => DateTime.now().millisecondsSinceEpoch,
    );

    _storage.setItem(SEARCHES, searches);
  }
}
