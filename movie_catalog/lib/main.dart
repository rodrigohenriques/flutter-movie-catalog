import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:moviecatalog/pages/home_page.dart';
import 'package:moviecatalog/store/home_store.dart';
import 'package:moviecatalog/store/search_store.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
          Provider<HomeStore>(create: (context) => HomeStore()),
          Provider<SearchStore>(create: (context) => SearchStore()),
      ],
      child: MyApp(),
    ),
  );
  await GlobalConfiguration().loadFromAsset("local_properties");
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Consumer<HomeStore>(
        builder: (context, store, _) => HomePage(store: store),
      ),
    );
  }
}
