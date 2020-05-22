import 'package:mobx/mobx.dart';
import 'package:moviecatalog/data/repositories/recent_searches_repository.dart';

part 'search_suggestions_store.g.dart';

class SearchSuggestionsStore = _SearchSuggestionsStore
    with _$SearchSuggestionsStore;

abstract class _SearchSuggestionsStore with Store {
  final _repository = RecentSearchesRepository();

  @observable
  List<String> suggestions = [];

  @action
  Future<void> fetch(String query) async {
    this.suggestions = await _repository.fetch(query);
  }
}
