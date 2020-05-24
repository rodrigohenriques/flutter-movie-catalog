import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:moviecatalog/resources/strings.dart';
import 'package:moviecatalog/store/favorite_movies_store.dart';
import 'package:moviecatalog/store/search_store.dart';
import 'package:moviecatalog/store/search_suggestions_store.dart';
import 'package:moviecatalog/widgets/search/search_delegate.dart';
import 'package:moviecatalog/widgets/search/search_page.dart';
import 'package:provider/provider.dart';

class FavoriteMoviesPage extends StatelessWidget {
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
        builder: (_, store, __) => Observer(
          builder: (context) => MovieGrid(
            movies: store.favorites.values.toList(),
            emptyMessage: Strings.noFavoriteYet,
          ),
        ),
      ),
    );
  }
}
