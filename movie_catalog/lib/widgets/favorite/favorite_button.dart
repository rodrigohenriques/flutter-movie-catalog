import 'package:flutter/material.dart';

class FavoriteButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isFavorite = false;

    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.red : Colors.white,
      ),
      onPressed: null,
    );
  }
}