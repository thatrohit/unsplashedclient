import 'package:mobx/mobx.dart';
import 'package:unsplashed_client/modules/search/repositories/api_client_search.dart';

import '../../models/search.dart';

part 'search_controller.g.dart';

class SearchController = _SearchController with _$SearchController;

abstract class _SearchController with Store {
  SearchApiClient apiClient = SearchApiClient();

  @observable
  bool isLoading = false;

  @observable
  SearchResult? wallpapers;

  int getGridViewColumns(final double width) {
    int columns = 1;
    columns = width ~/ 200.0;
    return columns;
  }

  @action
  Future<SearchResult?> searchWallpapers(String query) async {
    print("call made to search $query");
    isLoading = true;
    wallpapers = await apiClient.searchWallpapers(query);
    isLoading = false;
    print("$query count -> ${wallpapers?.results?.length ?? 0}");
    return wallpapers;
  }
}
