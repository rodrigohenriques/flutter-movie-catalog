import 'package:flutter/material.dart';
import 'package:moviecatalog/resources/strings.dart';
import 'package:moviecatalog/store/favorite_movies_store.dart';
import 'package:moviecatalog/store/search_store.dart';
import 'package:moviecatalog/store/search_suggestions_store.dart';
import 'package:moviecatalog/widgets/search/search_delegate.dart';
import 'package:provider/provider.dart';

import 'favorites_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.homePageTitle),
        actions: [
          Consumer2<SearchStore, SearchSuggestionsStore>(
            builder: (_, searchStore, suggestionsStore, __) => IconButton(
              icon: Icon(Icons.search),
              onPressed: () => showSearch(
                context: context,
                delegate: MovieSearchDelegate(searchStore, suggestionsStore),
              ),
            ),
          ),
        ],
      ),
      body: Consumer<FavoriteMoviesStore>(
        builder: (_, store, __) => FavoriteMovies(store: store),
      ),
    );
  }
}
