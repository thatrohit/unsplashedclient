import 'package:unsplashed_client/utils/unsplashed_keys.dart';

mixin UnsplashedApi {
  static const baseUrl = "https://api.unsplash.com";
  static const Map<String, String> apiHeaders = {
    "Authorization": "Client-ID ${UnsplashedKeys.unsplashedApiKey}",
    "Accept": "application/json",
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept",
  };

  static const endpointWallpapers = "/search/photos/?query=wallpaper";

  static String getEndpointDetails(String id) => "/photos/$id";
}
