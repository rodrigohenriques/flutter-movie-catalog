import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:moviecatalog/model/movie.dart';
import 'package:moviecatalog/store/favorite_button_store.dart';

class FavoriteButton extends StatefulWidget {
  FavoriteButton(Movie movie) {
    this.store = FavoriteButtonStore(movie);
  }

  FavoriteButtonStore store;

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  @override
  void initState() {
    super.initState();
    widget.store.connect();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return widget.store.isFavorite
            ? IconButton(
                icon: Icon(Icons.favorite, color: Colors.red),
                onPressed: () => widget.store.removeFavorite(),
              )
            : IconButton(
                icon: Icon(Icons.favorite_border, color: Colors.white),
                onPressed: () => widget.store.addFavorite(),
              );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.store.disconnect();
  }
}
