import 'package:mobx/mobx.dart';
import 'package:unsplashed_client/models/search.dart';
import 'package:unsplashed_client/modules/home/repositories/api_client_home.dart';

part 'home_controller.g.dart';

class HomeController = _HomeController with _$HomeController;

abstract class _HomeController with Store {
  HomeApiClient apiClient = HomeApiClient();

  @observable
  bool isLoading = false;

  @observable
  SearchResult? wallpapers;

  @action
  Future<SearchResult?> getWallpapers() async {
    isLoading = true;
    wallpapers = await apiClient.getWallpapers();
    print("TOTAL WALLPAPAERS -> ${wallpapers?.results?.length ?? '0'}");
    isLoading = false;
    return wallpapers;
  }
}
