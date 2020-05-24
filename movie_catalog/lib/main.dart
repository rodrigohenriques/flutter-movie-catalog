import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:moviecatalog/data/repositories/favorite_movies_repository.dart';
import 'package:moviecatalog/resources/strings.dart';
import 'package:moviecatalog/store/favorite_movies_store.dart';
import 'package:moviecatalog/store/search_store.dart';
import 'package:moviecatalog/store/search_suggestions_store.dart';
import 'package:moviecatalog/widgets/home_page.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        Provider<SearchStore>(create: (context) => SearchStore()),
        Provider<SearchSuggestionsStore>(
            create: (_) => SearchSuggestionsStore()),
        Provider<FavoriteMoviesStore>(
          create: (context) =>
              FavoriteMoviesStore(FavoriteMoviesRepository.instance),
        ),
      ],
      child: MovieCatalogApp(),
    ),
  );
  await GlobalConfiguration().loadFromAsset("local_properties");
}

class MovieCatalogApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}
