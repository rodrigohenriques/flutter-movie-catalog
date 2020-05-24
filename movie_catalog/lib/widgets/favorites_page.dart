import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:moviecatalog/resources/strings.dart';
import 'package:moviecatalog/store/favorite_movies_store.dart';
import 'package:moviecatalog/widgets/search/search_page.dart';

class FavoriteMovies extends StatelessWidget {
  const FavoriteMovies({Key key, @required this.store}) : super(key: key);

  final FavoriteMoviesStore store;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) =>
      store.favorites.length > 0
          ? buildGridView()
          : Center(child: Text(Strings.noFavoriteYet)),
    );
  }

  GridView buildGridView() {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: (3 / 4),
      padding: EdgeInsets.all(8),
      children: List.generate(
        store.favorites.length,
            (index) => MovieCard(movie: store.favorites[index]),
      ),
    );
  }
}
