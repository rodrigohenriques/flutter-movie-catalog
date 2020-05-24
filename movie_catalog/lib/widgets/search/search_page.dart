import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:moviecatalog/model/movie.dart';
import 'package:moviecatalog/store/search_store.dart';
import 'package:moviecatalog/widgets/favorite/favorite_button.dart';
import 'package:moviecatalog/widgets/movie/movie_page.dart';
import 'package:moviecatalog/widgets/movie/movie_poster.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key key, this.query, this.store}) : super(key: key);

  final String query;
  final SearchStore store;

  @override
  Widget build(BuildContext context) {
    store.search(query);

    return Observer(
      builder: (context) => store.searching
          ? Center(child: CircularProgressIndicator())
          : GridView.count(
              crossAxisCount: 2,
              childAspectRatio: (3 / 4),
              padding: EdgeInsets.all(8),
              children: List.generate(
                store.movies.length,
                (index) => MovieCard(movie: store.movies[index]),
              ),
            ),
    );
  }
}

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
                child: FavoriteButton(movie: movie),
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
