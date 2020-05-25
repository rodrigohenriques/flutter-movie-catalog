import 'package:flutter/material.dart';
import 'package:moviecatalog/model/movie.dart';

import 'movie_card.dart';

class MovieGrid extends StatelessWidget {
  const MovieGrid({
    Key key,
    @required this.movies,
    this.isLoading = false,
    this.emptyMessage,
  }) : super(key: key);

  final bool isLoading;
  final List<Movie> movies;
  final String emptyMessage;

  @override
  Widget build(BuildContext context) {
    return isLoading ? buildLoading() : buildMovieCards();
  }

  Widget buildLoading() => Center(child: CircularProgressIndicator());

  Widget buildNoResults() => Center(child: Text(emptyMessage));

  Widget buildMovieCards() {
    return movies.length == 0 ? buildNoResults() : buildGridView();
  }

  GridView buildGridView() {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: (3 / 4),
      padding: EdgeInsets.all(8),
      children: List.generate(
        movies.length,
        (index) => MovieCard(movie: movies[index]),
      ),
    );
  }
}
