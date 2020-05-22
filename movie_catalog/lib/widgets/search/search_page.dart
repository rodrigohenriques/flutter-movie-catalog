import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moviecatalog/store/search_store.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key key, this.query, this.store}) : super(key: key);

  final String query;
  final SearchStore store;

  @override
  Widget build(BuildContext context) {
    store.search(query);

    return Container(
      color: Colors.blueGrey,
    );
  }
}
