import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:moviecatalog/resources/strings.dart';
import 'package:moviecatalog/store/home_store.dart';
import 'package:moviecatalog/store/search_store.dart';
import 'package:moviecatalog/store/search_suggestions_store.dart';
import 'package:moviecatalog/widgets/search/search_page.dart';
import 'package:moviecatalog/widgets/search/search_suggestions.dart';
import 'package:provider/provider.dart';

import 'favorites_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key, this.store})
      : super(key: key);

  final HomeStore store;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.homePageTitle),
        actions: [
          Consumer2<SearchStore, SearchSuggestionsStore>(
            builder: (_, search, suggestions, __) => IconButton(
              icon: Icon(Icons.search),
              onPressed: () => showSearch(
                context: context,
                delegate: _DataSearch(search, suggestions),
              ),
            ),
          ),
        ],
      ),
      body: FavoritesPage(),
    );
  }
}

class _DataSearch extends SearchDelegate<String> {
  _DataSearch(this.searchStore, this.suggestionsStore);

  final SearchStore searchStore;
  final SearchSuggestionsStore suggestionsStore;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = "",
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
    return SearchSuggestions(query, suggestionsStore);
  }
}
