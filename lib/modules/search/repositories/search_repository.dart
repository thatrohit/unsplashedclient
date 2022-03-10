import 'package:unsplashed_client/models/search.dart';

import '../../../utils/api_helper.dart';

mixin SearchRepository on UnsplashedApi {
  Future<SearchResult> searchWallpapers(String query, int page);
}
