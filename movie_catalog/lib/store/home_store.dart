import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:moviecatalog/data/repositories/movie_repository.dart';
import 'package:moviecatalog/model/http_error.dart';
import 'package:moviecatalog/model/movie.dart';
import 'package:moviecatalog/model/search_result.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  @observable
  bool isSearching = false;

  @computed
  IconData get actionIcon => isSearching ? Icons.cancel : Icons.search;

  @computed
  Function get actionPressed => isSearching ? cancelSearch : searchClick;

  @computed
  Widget get appBarAction =>
      IconButton(
        icon: Icon(actionIcon),
        onPressed: actionPressed,
      );

  @action
  void searchClick() {
    isSearching = true;
  }

  @action
  void cancelSearch() {
    isSearching = false;
  }
}