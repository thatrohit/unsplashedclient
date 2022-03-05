import 'package:mobx/mobx.dart';
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
  bool isLoadingDesktopWallpapers = false;

  @observable
  bool isLoadingMobileWallpapers = false;

  @observable
  SearchResult? desktopWallpapers;

  @observable
  SearchResult? mobileWallpapers;

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
}
