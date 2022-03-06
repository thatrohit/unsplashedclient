// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeController, Store {
  final _$isLoadingDesktopWallpapersAtom =
      Atom(name: '_HomeController.isLoadingDesktopWallpapers');

  @override
  bool get isLoadingDesktopWallpapers {
    _$isLoadingDesktopWallpapersAtom.reportRead();
    return super.isLoadingDesktopWallpapers;
  }

  @override
  set isLoadingDesktopWallpapers(bool value) {
    _$isLoadingDesktopWallpapersAtom
        .reportWrite(value, super.isLoadingDesktopWallpapers, () {
      super.isLoadingDesktopWallpapers = value;
    });
  }

  final _$isLoadingMobileWallpapersAtom =
      Atom(name: '_HomeController.isLoadingMobileWallpapers');

  @override
  bool get isLoadingMobileWallpapers {
    _$isLoadingMobileWallpapersAtom.reportRead();
    return super.isLoadingMobileWallpapers;
  }

  @override
  set isLoadingMobileWallpapers(bool value) {
    _$isLoadingMobileWallpapersAtom
        .reportWrite(value, super.isLoadingMobileWallpapers, () {
      super.isLoadingMobileWallpapers = value;
    });
  }

  final _$desktopWallpapersAtom =
      Atom(name: '_HomeController.desktopWallpapers');

  @override
  SearchResult? get desktopWallpapers {
    _$desktopWallpapersAtom.reportRead();
    return super.desktopWallpapers;
  }

  @override
  set desktopWallpapers(SearchResult? value) {
    _$desktopWallpapersAtom.reportWrite(value, super.desktopWallpapers, () {
      super.desktopWallpapers = value;
    });
  }

  final _$mobileWallpapersAtom = Atom(name: '_HomeController.mobileWallpapers');

  @override
  SearchResult? get mobileWallpapers {
    _$mobileWallpapersAtom.reportRead();
    return super.mobileWallpapers;
  }

  @override
  set mobileWallpapers(SearchResult? value) {
    _$mobileWallpapersAtom.reportWrite(value, super.mobileWallpapers, () {
      super.mobileWallpapers = value;
    });
  }

  final _$prefsAtom = Atom(name: '_HomeController.prefs');

  @override
  SharedPreferences? get prefs {
    _$prefsAtom.reportRead();
    return super.prefs;
  }

  @override
  set prefs(SharedPreferences? value) {
    _$prefsAtom.reportWrite(value, super.prefs, () {
      super.prefs = value;
    });
  }

  final _$initSharedPreferencesAsyncAction =
      AsyncAction('_HomeController.initSharedPreferences');

  @override
  Future<SharedPreferences?> initSharedPreferences() {
    return _$initSharedPreferencesAsyncAction
        .run(() => super.initSharedPreferences());
  }

  final _$getDesktopWallpapersAsyncAction =
      AsyncAction('_HomeController.getDesktopWallpapers');

  @override
  Future<SearchResult?> getDesktopWallpapers(
      {ResponseRepository repository = ResponseRepository.web}) {
    return _$getDesktopWallpapersAsyncAction
        .run(() => super.getDesktopWallpapers(repository: repository));
  }

  final _$getMobileWallpapersAsyncAction =
      AsyncAction('_HomeController.getMobileWallpapers');

  @override
  Future<SearchResult?> getMobileWallpapers(
      {ResponseRepository repository = ResponseRepository.web}) {
    return _$getMobileWallpapersAsyncAction
        .run(() => super.getMobileWallpapers(repository: repository));
  }

  @override
  String toString() {
    return '''
isLoadingDesktopWallpapers: ${isLoadingDesktopWallpapers},
isLoadingMobileWallpapers: ${isLoadingMobileWallpapers},
desktopWallpapers: ${desktopWallpapers},
mobileWallpapers: ${mobileWallpapers},
prefs: ${prefs}
    ''';
  }
}
