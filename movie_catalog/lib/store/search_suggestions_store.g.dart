// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_suggestions_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SearchSuggestionsStore on _SearchSuggestionsStore, Store {
  final _$suggestionsAtom = Atom(name: '_SearchSuggestionsStore.suggestions');

  @override
  List<String> get suggestions {
    _$suggestionsAtom.reportRead();
    return super.suggestions;
  }

  @override
  set suggestions(List<String> value) {
    _$suggestionsAtom.reportWrite(value, super.suggestions, () {
      super.suggestions = value;
    });
  }

  final _$fetchAsyncAction = AsyncAction('_SearchSuggestionsStore.fetch');

  @override
  Future<void> fetch(String query) {
    return _$fetchAsyncAction.run(() => super.fetch(query));
  }

  @override
  String toString() {
    return '''
suggestions: ${suggestions}
    ''';
  }
}
