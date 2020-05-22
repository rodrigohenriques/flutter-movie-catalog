import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:moviecatalog/store/search_suggestions_store.dart';

class SearchSuggestions extends StatelessWidget {
  SearchSuggestions(this.query, this.store);

  final String query;
  final SearchSuggestionsStore store;

  @override
  Widget build(BuildContext context) {
    store.fetch(query);

    return Observer(
        builder: (context) => ListView.builder(
            itemBuilder: (context, index) => ListTile(
              leading: Icon(Icons.query_builder),
              title: Text(store.suggestions[index]),
            ),
            itemCount: store.suggestions.length,
        ),
    );
  }
}
