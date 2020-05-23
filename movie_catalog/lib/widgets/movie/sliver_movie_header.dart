import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:moviecatalog/model/movie.dart';
import 'package:moviecatalog/widgets/favorite/favorite_button.dart';

import 'movie_page.dart';
import 'movie_poster.dart';

class SliverMovieHeader extends StatelessWidget {
  const SliverMovieHeader({
    Key key,
    @required this.movie,
    this.height,
    this.width,
  }) : super(key: key);

  final double height, width;
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      floating: false,
      delegate: _SliverMovieHeaderDelegate(
        movie: movie,
        height: height,
        width: width,
      ),
    );
  }
}

class _SliverMovieHeaderDelegate extends SliverPersistentHeaderDelegate {
  const _SliverMovieHeaderDelegate({
    @required this.movie,
    this.height,
    this.width,
  });

  final double height, width;
  final Movie movie;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool content) {
    return _MovieHeader(movie: movie, height: height, width: width);
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => 48;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class _MovieHeader extends StatelessWidget {
  const _MovieHeader({
    @required this.movie,
    this.height,
    this.width,
  });

  final double height, width;
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: height,
          width: width,
          child: MoviePoster(posterPath: movie.posterPath),
        ),
        Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  movie.title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            actions: <Widget>[
              FavoriteButton(),
            ],
          ),
        ),
      ],
    );
  }

}