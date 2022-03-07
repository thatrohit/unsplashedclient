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

  final _$hasNextPageAtom = Atom(name: '_SearchController.hasNextPage');

  @override
  bool get hasNextPage {
    _$hasNextPageAtom.reportRead();
    return super.hasNextPage;
  }

  @override
  set hasNextPage(bool value) {
    _$hasNextPageAtom.reportWrite(value, super.hasNextPage, () {
      super.hasNextPage = value;
    });
  }

  final _$hasPrevPageAtom = Atom(name: '_SearchController.hasPrevPage');

  @override
  bool get hasPrevPage {
    _$hasPrevPageAtom.reportRead();
    return super.hasPrevPage;
  }

  @override
  set hasPrevPage(bool value) {
    _$hasPrevPageAtom.reportWrite(value, super.hasPrevPage, () {
      super.hasPrevPage = value;
    });
  }

  final _$searchWallpapersAsyncAction =
      AsyncAction('_SearchController.searchWallpapers');

  @override
  Future<SearchResult?> searchWallpapers(String query, int page) {
    return _$searchWallpapersAsyncAction
        .run(() => super.searchWallpapers(query, page));
  }

  final _$_SearchControllerActionController =
      ActionController(name: '_SearchController');

  @override
  SearchResult? clearSearch() {
    final _$actionInfo = _$_SearchControllerActionController.startAction(
        name: '_SearchController.clearSearch');
    try {
      return super.clearSearch();
    } finally {
      _$_SearchControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
wallpapers: ${wallpapers},
hasNextPage: ${hasNextPage},
hasPrevPage: ${hasPrevPage}
    ''';
  }
}
