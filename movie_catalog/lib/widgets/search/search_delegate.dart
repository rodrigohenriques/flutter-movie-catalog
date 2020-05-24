import 'package:flutter/material.dart';
import 'package:moviecatalog/store/search_store.dart';
import 'package:moviecatalog/store/search_suggestions_store.dart';

import 'search_page.dart';
import 'search_suggestions.dart';

class MovieSearchDelegate extends SearchDelegate<String> {
  MovieSearchDelegate(this.searchStore, this.suggestionsStore);

  final SearchStore searchStore;
  final SearchSuggestionsStore suggestionsStore;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => _clear(context),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchPage(query: query, store: searchStore);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SearchSuggestions(
      query: query,
      store: suggestionsStore,
      onItemPressed: (item) {
        query = item;
        showResults(context);
      },
    );
  }

  void _clear(BuildContext context) {
    query = "";
    showSuggestions(context);
  }
}