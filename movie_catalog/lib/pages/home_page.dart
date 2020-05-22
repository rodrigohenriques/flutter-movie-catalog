import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:moviecatalog/pages/favorites_page.dart';
import 'package:moviecatalog/pages/search_page.dart';
import 'package:moviecatalog/resources/strings.dart';
import 'package:moviecatalog/store/home_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key, this.store}) : super(key: key);

  final HomeStore store;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.homePageTitle),
        actions: [ Observer(builder: (_) => widget.store.appBarAction) ],
      ),
      body: Observer(builder: buildBody),
    );
  }

  Widget buildBody(BuildContext context) {
    return widget.store.isSearching ? SearchPage() : FavoritesPage();
  }
}
