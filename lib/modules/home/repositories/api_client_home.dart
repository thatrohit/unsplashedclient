import 'dart:convert';

import 'package:unsplashed_client/utils/api_helper.dart';
import 'package:http/http.dart' as http;

import '../../../models/search.dart';
import 'home_repository.dart';

class HomeApiClient implements HomeRepository {
  @override
  Future<SearchResult> getDesktopWallpapers() async {
    final apiRequest = Uri.parse(
        UnsplashedApi.baseUrl + UnsplashedApi.endpointDesktopWallpapers);
    final apiResponse =
        await http.get(apiRequest, headers: UnsplashedApi.apiHeaders);
    if (apiResponse.statusCode != 200) {
      throw Exception(
          "The network returned a failure. Please try again after some time");
    }
    final Map<String, dynamic> parsedJson = jsonDecode(apiResponse.body);
    final SearchResult result = SearchResult.fromJson(parsedJson);
    return result;
  }

  @override
  Future<SearchResult> getMobileWallpapers() async {
    final apiRequest = Uri.parse(
        UnsplashedApi.baseUrl + UnsplashedApi.endpointMobileWallpapers);
    final apiResponse =
        await http.get(apiRequest, headers: UnsplashedApi.apiHeaders);
    if (apiResponse.statusCode != 200) {
      throw Exception(
          "The network returned a failure. Please try again after some time");
    }
    final Map<String, dynamic> parsedJson = jsonDecode(apiResponse.body);
    final SearchResult result = SearchResult.fromJson(parsedJson);
    return result;
  }
}
