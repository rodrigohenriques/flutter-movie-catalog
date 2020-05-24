import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MoviePoster extends StatelessWidget {
  const MoviePoster({
    Key key,
    @required this.posterPath,
  }) : super(key: key);

  final String posterPath;

  String get imageUrl => "https://image.tmdb.org/t/p/w300$posterPath";

  @override
  Widget build(BuildContext context) {
    return Image(
      image: CachedNetworkImageProvider(imageUrl),
      alignment: AlignmentDirectional.topCenter,
      fit: BoxFit.cover,
    );
  }
}
