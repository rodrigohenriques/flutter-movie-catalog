import 'package:flutter/material.dart';
import 'package:moviecatalog/model/movie.dart';

import 'movie_card.dart';

class MovieGrid extends StatefulWidget {
  MovieGrid({
    Key key,
    @required this.movies,
    this.isLoading = false,
    this.emptyMessage,
    this.loadMore,
    this.hasMoreItems = false,
  }) : super(key: key);

  final bool isLoading;
  final List<Movie> movies;
  final String emptyMessage;
  final Function loadMore;
  final bool hasMoreItems;

  bool get hasLoadMore => hasMoreItems && loadMore != null;

  @override
  _MovieGridState createState() => _MovieGridState();
}

class _MovieGridState extends State<MovieGrid> {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    if (_scrollController != null) {
      _scrollController.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.isLoading ? buildLoading() : buildMovieCards();
  }

  Widget buildLoading() => Center(child: CircularProgressIndicator());

  Widget buildNoResults() => Center(child: Text(widget.emptyMessage));

  Widget buildMovieCards() {
    return widget.movies.length == 0 ? buildNoResults() : buildGridView();
  }

  Widget buildGridView() {
    return CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        SliverGrid.count(
          crossAxisCount: 2,
          childAspectRatio: (3 / 4),
          children: List.generate(
            widget.movies.length,
            (index) => MovieCard(movie: widget.movies[index]),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            buildLoadMore(context),
          ]),
        ),
      ],
    );
  }

  Widget buildLoadMore(BuildContext context) {
    return widget.hasLoadMore
        ? Container(
            padding: EdgeInsets.all(16.0),
            child: Center(child: CircularProgressIndicator()),
          )
        : Container();
  }

  void _scrollListener() {
    var position = _scrollController.position;

    if (position.pixels == position.maxScrollExtent && widget.hasLoadMore) {
      widget.loadMore();
    }
  }
}
