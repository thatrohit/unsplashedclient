import 'dart:convert';

import 'package:unsplashed_client/utils/api_helper.dart';
import 'package:http/http.dart' as http;

import '../../../models/search.dart';

class HomeApiClient with UnsplashedApi {
  Future<SearchResult> getWallpapers() async {
    final apiRequest =
        Uri.parse(UnsplashedApi.baseUrl + UnsplashedApi.endpointWallpapers);
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
