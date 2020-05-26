import 'package:flutter/material.dart';
import 'package:moviecatalog/model/movie.dart';
import 'package:moviecatalog/store/favorite_button_store.dart';
import 'package:moviecatalog/widgets/favorite/favorite_button.dart';
import 'package:provider/provider.dart';

import 'movie_page.dart';
import 'movie_poster.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({Key key, @required this.movie}) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: EdgeInsets.all(4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: LayoutBuilder(builder: (_, boxConstraints) {
          return Stack(
            children: <Widget>[
              Container(
                width: boxConstraints.maxWidth,
                child: MoviePoster(posterPath: movie.posterPath),
              ),
              Container(
                height: boxConstraints.maxHeight,
                width: boxConstraints.maxWidth,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black45],
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: FavoriteButton(
                  FavoriteButtonStore(movie, Provider.of(context)),
                ),
              ),
            ],
          );
        }),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MoviePage(movie: movie)),
        );
      },
    );
  }
}
