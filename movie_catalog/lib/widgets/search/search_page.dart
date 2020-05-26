import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:moviecatalog/resources/strings.dart';
import 'package:moviecatalog/store/search_store.dart';
import 'package:moviecatalog/widgets/movie/movie_grid.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key key, this.query, this.store}) : super(key: key) {
    store.search(query);
  }

  final String query;
  final SearchStore store;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => MovieGrid(
        movies: store.movies,
        isLoading: store.searching,
        emptyMessage: Strings.noResults,
        loadMore: store.loadMore,
        hasMoreItems: store.hasMoreItems
      ),
    );
  }
}
