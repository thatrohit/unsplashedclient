import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'favorites_controller.g.dart';

class FavoritesController = _FavoritesController with _$FavoritesController;

abstract class _FavoritesController with Store {
  @observable
  Map<String, dynamic> userFavorites = {};

  @observable
  bool isLoading = false;

  @action
  Future<Map<dynamic, dynamic>?> getFavorites() async {
    isLoading = true;
    userFavorites = {};
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString('uid') ?? "";
    CollectionReference favorites =
        FirebaseFirestore.instance.collection('favorites');
    QuerySnapshot<Object?> favs = await favorites.get();
    int index = favs.docs.indexWhere((e) => e.id == uid);
    if (index != -1) {
      dynamic snapshot = favs.docs[index];
      userFavorites = (snapshot.data() as Map)['favorite_ids'];
    } else {
      userFavorites = {};
    }
    isLoading = false;
    return userFavorites;
  }
}
