// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SearchController on _SearchController, Store {
  final _$isLoadingAtom = Atom(name: '_SearchController.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$wallpapersAtom = Atom(name: '_SearchController.wallpapers');

  @override
  SearchResult? get wallpapers {
    _$wallpapersAtom.reportRead();
    return super.wallpapers;
  }

  @override
  set wallpapers(SearchResult? value) {
    _$wallpapersAtom.reportWrite(value, super.wallpapers, () {
      super.wallpapers = value;
    });
  }

  final _$searchWallpapersAsyncAction =
      AsyncAction('_SearchController.searchWallpapers');

  @override
  Future<SearchResult?> searchWallpapers(String query) {
    return _$searchWallpapersAsyncAction
        .run(() => super.searchWallpapers(query));
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
wallpapers: ${wallpapers}
    ''';
  }
}
