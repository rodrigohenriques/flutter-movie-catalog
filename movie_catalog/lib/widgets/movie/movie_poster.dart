import 'package:flutter/material.dart';

class MoviePoster extends StatelessWidget {
  const MoviePoster({
    Key key,
    @required this.posterPath,
  }) : super(key: key);

  final String posterPath;

  String get imageUrl => "https://image.tmdb.org/t/p/original$posterPath";

  @override
  Widget build(BuildContext context) {
    return FadeInImage.assetNetwork(
      placeholder: 'assets/images/placeholder.png',
      image: imageUrl,
      alignment: AlignmentDirectional.topCenter,
      fit: BoxFit.cover,
    );
  }
}
