import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'details_controller.g.dart';

class DetailsController = _DetailsController with _$DetailsController;

abstract class _DetailsController with Store {
  @observable
  bool isLiked = false;

  @action
  Future<bool> isLikedImage(String imageId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString('uid') ?? "";
    CollectionReference favorites =
        FirebaseFirestore.instance.collection('favorites');
    QuerySnapshot<Object?> favs = await favorites.get();
    Map<dynamic, dynamic> favList = {};
    int index = favs.docs.indexWhere((e) => e.id == uid);
    if (index != -1) {
      dynamic snapshot = favs.docs[index];
      favList = (snapshot.data() as Map)['favorite_ids'];
      isLiked = favList.keys.contains(imageId);
    } else {
      isLiked = false;
    }
    return isLiked;
  }

  @action
  Future<bool> saveToFavorite(String imageId, String thumb) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString('uid') ?? "";
    CollectionReference favorites =
        FirebaseFirestore.instance.collection('favorites');
    QuerySnapshot<Object?> favs = await favorites.get();
    Map<dynamic, dynamic> favList = {};
    int index = favs.docs.indexWhere((e) => e.id == uid);
    if (index != -1) {
      dynamic snapshot = favs.docs[index];
      favList = (snapshot.data() as Map)['favorite_ids'];
      if (favList.keys.contains(imageId)) {
        favList.remove(imageId);
        isLiked = false;
      } else {
        favList[imageId] = thumb;
        isLiked = true;
      }
    } else {
      favList[imageId] = thumb;
      isLiked = true;
    }
    favorites.doc(uid).set({"favorite_ids": favList});
    return isLiked;
  }
}
