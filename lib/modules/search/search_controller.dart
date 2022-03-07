import 'package:flutter/rendering.dart';
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

  @observable
  bool hasNextPage = true;

  @observable
  bool hasPrevPage = false;

  int getGridViewColumns(final double width) {
    int columns = 1;
    columns = width ~/ 200.0;
    return columns;
  }

  @action
  Future<SearchResult?> searchWallpapers(String query, int page) async {
    isLoading = true;
    wallpapers = await apiClient.searchWallpapers(query, page);
    hasPrevPage = !(page == 1);
    hasNextPage = (page * 10) < (wallpapers?.total ?? 1);
    isLoading = false;
    return wallpapers;
  }

  @action
  SearchResult? clearSearch() {
    wallpapers = null;
    hasNextPage = false;
    hasPrevPage = false;
    return wallpapers;
  }
}
