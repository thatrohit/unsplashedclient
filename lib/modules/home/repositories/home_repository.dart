import 'package:unsplashed_client/models/search.dart';

import '../../../utils/api_helper.dart';

mixin HomeRepository on UnsplashedApi {
  Future<SearchResult> getDesktopWallpapers();
  Future<SearchResult> getMobileWallpapers();
}
