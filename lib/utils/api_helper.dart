import 'package:unsplashed_client/utils/unsplashed_keys.dart';

mixin UnsplashedApi {
  static const baseUrl = "https://api.unsplash.com";
  static const Map<String, String> apiHeaders = {
    "Authorization": "Client-ID ${UnsplashedKeys.unsplashedApiKey}",
    "Accept": "application/json",
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept",
  };

  static const endpointDesktopWallpapers =
      "/search/photos/?query=desktop-wallpaper&order_by=latest&orientation=landscape";

  static const endpointLocalDesktopWallpapers =
      'assets/mock/desktop_wallpapers.json';

  static const endpointMobileWallpapers =
      "/search/photos/?query=mobile-wallpaper&order_by=latest&orientation=portrait";

  static const endpointLocalMobileWallpapers =
      'assets/mock/mobile_wallpapers.json';

  static String getEndpointDetails(String id) => "/photos/$id";

  static String getEndpointSearch(String query, int page) =>
      "/search/photos/?query=$query&order_by=latest&page=$page";
}
