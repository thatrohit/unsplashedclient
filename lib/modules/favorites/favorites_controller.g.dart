// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FavoritesController on _FavoritesController, Store {
  final _$userFavoritesAtom = Atom(name: '_FavoritesController.userFavorites');

  @override
  Map<String, dynamic> get userFavorites {
    _$userFavoritesAtom.reportRead();
    return super.userFavorites;
  }

  @override
  set userFavorites(Map<String, dynamic> value) {
    _$userFavoritesAtom.reportWrite(value, super.userFavorites, () {
      super.userFavorites = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_FavoritesController.isLoading');

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

  final _$getFavoritesAsyncAction =
      AsyncAction('_FavoritesController.getFavorites');

  @override
  Future<Map<dynamic, dynamic>?> getFavorites() {
    return _$getFavoritesAsyncAction.run(() => super.getFavorites());
  }

  @override
  String toString() {
    return '''
userFavorites: ${userFavorites},
isLoading: ${isLoading}
    ''';
  }
}
