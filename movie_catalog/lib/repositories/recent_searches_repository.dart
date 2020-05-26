import 'package:dartz/dartz.dart';
import 'package:localstorage/localstorage.dart';

abstract class RecentSearchesRepository {
  Future<List<String>> fetch([String query, int limit = 10]);

  Future save(String query);
}

class RecentSearchesRepositoryImpl implements RecentSearchesRepository {
  static const SEARCHES = 'searches';

  Future<List<String>> fetch([String query, int limit = 10]) async {
    final optionalStorage = await _prepareStorage();

    return optionalStorage
        .flatMap(_getSearches)
        .map(_sortByMostRecent)
        .map(_filterBy(query))
        .fold(() => [], (items) => items.take(limit).toList());
  }

  Future save(String query) async {
    if (query == null || query.isEmpty) return;

    final optionalStorage = await _prepareStorage();

    optionalStorage.fold(
      () {},
      (storage) {
        Map<String, dynamic> searches =
            _getSearches(storage).getOrElse(() => Map());

        searches.update(
          query,
          (old) => DateTime.now().millisecondsSinceEpoch,
          ifAbsent: () => DateTime.now().millisecondsSinceEpoch,
        );

        storage.setItem(SEARCHES, searches);
      },
    );
  }

  Option<Map<String, dynamic>> _getSearches(LocalStorage storage) {
    var item = storage.getItem(SEARCHES);
    return item != null ? Some(item) : None();
  }

  List<String> _sortByMostRecent(Map<String, dynamic> data) {
    var entries = data.entries.toList();
    entries.sort((a, b) => a.value > b.value ? -1 : 1);
    return entries.map((e) => e.key).toList();
  }

  Future<Option<LocalStorage>> _prepareStorage() async {
    final LocalStorage storage = new LocalStorage('recent_searches.json');
    final storageReady = await storage.ready;
    return storageReady ? Some(storage) : None();
  }

  Function(List<String> items) _filterBy(String query) {
    return query == null || query.isEmpty
        ? (items) => items
        : (items) => items.where((q) => q.contains(query));
  }
}
