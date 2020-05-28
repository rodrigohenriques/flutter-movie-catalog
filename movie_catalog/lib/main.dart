import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/io_client.dart';
import 'package:moviecatalog/infra/local_storage.dart';
import 'package:moviecatalog/repositories/favorite_movies_repository.dart';
import 'package:moviecatalog/repositories/movie_repository.dart';
import 'package:moviecatalog/repositories/recent_searches_repository.dart';
import 'package:moviecatalog/resources/strings.dart';
import 'package:moviecatalog/store/favorite_movies_store.dart';
import 'package:moviecatalog/store/search_store.dart';
import 'package:moviecatalog/store/search_suggestions_store.dart';
import 'package:moviecatalog/widgets/favorite/favorite_movies_page.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        Provider<Storage>(create: (_) => LocalStorageImpl()),
        Provider<MovieRepository>(
            create: (_) => MovieRepositoryImpl(IOClient())),
        ProxyProvider<Storage, FavoriteMoviesRepository>(
          update: (context, storage, _) =>
              FavoriteMoviesRepositoryImpl(storage),
        ),
        Provider<RecentSearchesRepository>(
          create: (_) => RecentSearchesRepositoryImpl(),
        ),
        ProxyProvider2<MovieRepository, RecentSearchesRepository, SearchStore>(
          update: (context, movieRepo, recentSearchRepo, _) =>
              SearchStore(movieRepo, recentSearchRepo),
        ),
        ProxyProvider<RecentSearchesRepository, SearchSuggestionsStore>(
          update: (context, recentSearchRepo, _) =>
              SearchSuggestionsStore(recentSearchRepo),
        ),
        ProxyProvider<FavoriteMoviesRepository, FavoriteMoviesStore>(
          update: (context, favoriteMoviesRepo, _) =>
              FavoriteMoviesStore(favoriteMoviesRepo),
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
