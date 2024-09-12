// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginController on _LoginController, Store {
  final _$prefsAtom = Atom(name: '_LoginController.prefs');

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

  final _$isLoadingAtom = Atom(name: '_LoginController.isLoading');

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

  final _$showEmailErrorAtom = Atom(name: '_LoginController.showEmailError');

  @override
  bool get showEmailError {
    _$showEmailErrorAtom.reportRead();
    return super.showEmailError;
  }

  @override
  set showEmailError(bool value) {
    _$showEmailErrorAtom.reportWrite(value, super.showEmailError, () {
      super.showEmailError = value;
    });
  }

  final _$showPasswordErrorAtom =
      Atom(name: '_LoginController.showPasswordError');

  @override
  bool get showPasswordError {
    _$showPasswordErrorAtom.reportRead();
    return super.showPasswordError;
  }

  @override
  set showPasswordError(bool value) {
    _$showPasswordErrorAtom.reportWrite(value, super.showPasswordError, () {
      super.showPasswordError = value;
    });
  }

  final _$getSharedPreferencesAsyncAction =
      AsyncAction('_LoginController.getSharedPreferences');

  @override
  Future<SharedPreferences?> getSharedPreferences() {
    return _$getSharedPreferencesAsyncAction
        .run(() => super.getSharedPreferences());
  }

  final _$loginUserAsyncAction = AsyncAction('_LoginController.loginUser');

  @override
  Future<FirebaseAuthResult> loginUser(dynamic emailId, dynamic password) {
    return _$loginUserAsyncAction.run(() => super.loginUser(emailId, password));
  }

  final _$registerUserAsyncAction =
      AsyncAction('_LoginController.registerUser');

  @override
  Future<FirebaseAuthResult?> registerUser(dynamic emailId, dynamic password) {
    return _$registerUserAsyncAction
        .run(() => super.registerUser(emailId, password));
  }

  final _$_LoginControllerActionController =
      ActionController(name: '_LoginController');

  @override
  void validate(String email, String password) {
    final _$actionInfo = _$_LoginControllerActionController.startAction(
        name: '_LoginController.validate');
    try {
      return super.validate(email, password);
    } finally {
      _$_LoginControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
prefs: ${prefs},
isLoading: ${isLoading},
showEmailError: ${showEmailError},
showPasswordError: ${showPasswordError}
    ''';
  }
}
