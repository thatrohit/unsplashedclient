// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'details_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DetailsController on _DetailsController, Store {
  final _$isLikedAtom = Atom(name: '_DetailsController.isLiked');

  @override
  bool get isLiked {
    _$isLikedAtom.reportRead();
    return super.isLiked;
  }

  @override
  set isLiked(bool value) {
    _$isLikedAtom.reportWrite(value, super.isLiked, () {
      super.isLiked = value;
    });
  }

  final _$isLikedImageAsyncAction =
      AsyncAction('_DetailsController.isLikedImage');

  @override
  Future<bool> isLikedImage(String imageId) {
    return _$isLikedImageAsyncAction.run(() => super.isLikedImage(imageId));
  }

  final _$saveToFavoriteAsyncAction =
      AsyncAction('_DetailsController.saveToFavorite');

  @override
  Future<bool> saveToFavorite(String imageId, String thumb) {
    return _$saveToFavoriteAsyncAction
        .run(() => super.saveToFavorite(imageId, thumb));
  }

  @override
  String toString() {
    return '''
isLiked: ${isLiked}
    ''';
  }
}
