import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:moviecatalog/model/movie.dart';
import 'package:moviecatalog/widgets/movie/sliver_movie_header.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({Key key, @required this.movie}) : super(key: key);

  String get imageUrl =>
      "https://image.tmdb.org/t/p/original${movie.posterPath}";

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, boxConstraints) {
        return CustomScrollView(
          slivers: <Widget>[
            SliverMovieHeader(
              movie: movie,
              height: boxConstraints.maxHeight * 0.8,
              width: boxConstraints.maxWidth,
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                buildMovieOverview(context),
              ]),
            ),
          ],
        );
      },
    );
  }

  Container buildMovieOverview(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
      child: Text(
        movie.overview,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyText2.copyWith(
              color: Colors.white,
            ),
      ),
    );
  }
}
