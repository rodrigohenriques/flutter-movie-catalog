import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/io_client.dart';
import 'package:moviecatalog/repositories/favorite_movies_repository.dart';
import 'package:moviecatalog/repositories/movie_repository.dart';
import 'package:moviecatalog/repositories/recent_searches_repository.dart';
import 'package:moviecatalog/resources/strings.dart';
import 'package:moviecatalog/store/favorite_movies_store.dart';
import 'package:moviecatalog/store/search_store.dart';
import 'package:moviecatalog/store/search_suggestions_store.dart';
import 'package:moviecatalog/widgets/favorite/favorite_movies_page.dart';
import 'package:provider/provider.dart';

import 'infra/key_value_storage.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        Provider<KeyValueStorage>(create: (_) => LocalStorageImpl()),
        Provider<MovieRepository>(
          create: (_) => MovieRepositoryImpl(IOClient()),
        ),
        ProxyProvider<KeyValueStorage, FavoriteMoviesRepository>(
          update: (_, storage, __) => FavoriteMoviesRepositoryImpl(storage),
        ),
        ProxyProvider<KeyValueStorage, RecentSearchesRepository>(
          update: (_, storage, __) => RecentSearchesRepositoryImpl(storage),
        ),
        ProxyProvider2<MovieRepository, RecentSearchesRepository, SearchStore>(
          update: (_, movieRepo, recentSearchRepo, __) =>
              SearchStore(movieRepo, recentSearchRepo),
        ),
        ProxyProvider<RecentSearchesRepository, SearchSuggestionsStore>(
          update: (_, repo, __) => SearchSuggestionsStore(repo),
        ),
        ProxyProvider<FavoriteMoviesRepository, FavoriteMoviesStore>(
          update: (_, repo, __) => FavoriteMoviesStore(repo),
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
      home: FavoriteMoviesPage(),
    );
  }
}
