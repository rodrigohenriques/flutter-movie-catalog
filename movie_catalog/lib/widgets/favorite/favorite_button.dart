import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:moviecatalog/model/movie.dart';
import 'package:moviecatalog/store/favorite_movies_store.dart';
import 'package:provider/provider.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({Key key, this.movie}) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<FavoriteMoviesStore>(context);

    return Observer(
      builder: (_) {
        var ids = store.favorites.map((e) => e.id);

        return ids.contains(movie.id)
            ? IconButton(
                icon: Icon(Icons.favorite, color: Colors.red),
                onPressed: () => store.removeFavorite(movie),
              )
            : IconButton(
                icon: Icon(Icons.favorite_border, color: Colors.white),
                onPressed: () => store.addFavorite(movie),
              );
      },
    );
  }
}
