import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unsplashed_client/models/search.dart';
import 'package:unsplashed_client/modules/home/repositories/api_client_home.dart';
import 'package:unsplashed_client/modules/home/repositories/local_repo_home.dart';
import 'package:unsplashed_client/utils/helpers.dart';

part 'home_controller.g.dart';

class HomeController = _HomeController with _$HomeController;

abstract class _HomeController with Store {
  HomeApiClient apiClient = HomeApiClient();
  HomeLocalRepository localClient = HomeLocalRepository();

  @observable
  String headerText = "You don't have any liked images yet";

  @observable
  bool isLoadingDesktopWallpapers = false;

  @observable
  bool isLoadingMobileWallpapers = false;

  @observable
  SearchResult? desktopWallpapers;

  @observable
  SearchResult? mobileWallpapers;

  @observable
  SharedPreferences? prefs;

  @action
  Future<SharedPreferences?> initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  @action
  Future<SearchResult?> getDesktopWallpapers({
    ResponseRepository repository = ResponseRepository.web,
  }) async {
    isLoadingDesktopWallpapers = true;
    if (repository == ResponseRepository.web) {
      desktopWallpapers = await apiClient.getDesktopWallpapers();
      print("called remote - desktop wall");
    } else {
      desktopWallpapers = await localClient.getDesktopWallpapers();
      print("called local - desktop wall");
    }
    isLoadingDesktopWallpapers = false;
    return desktopWallpapers;
  }

  @action
  Future<SearchResult?> getMobileWallpapers({
    ResponseRepository repository = ResponseRepository.web,
  }) async {
    isLoadingMobileWallpapers = true;
    if (repository == ResponseRepository.web) {
      mobileWallpapers = await apiClient.getMobileWallpapers();
    } else {
      mobileWallpapers = await localClient.getMobileWallpapers();
    }
    isLoadingMobileWallpapers = false;
    return mobileWallpapers;
  }

  @action
  Future<String> updateHeaderText() async {
    Map userFavorites = {};
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
    if (userFavorites.entries.length == 1) {
      headerText = "You have 1 liked image";
    } else if (userFavorites.entries.length > 1) {
      headerText = "You have ${userFavorites.entries.length} liked images";
    }
    return headerText;
  }
}
