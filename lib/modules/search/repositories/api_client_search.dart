import 'dart:convert';

import 'package:unsplashed_client/models/search.dart';
import 'package:unsplashed_client/modules/search/repositories/search_repository.dart';
import 'package:unsplashed_client/utils/api_helper.dart';
import 'package:http/http.dart' as http;

class SearchApiClient implements SearchRepository {
  @override
  Future<SearchResult> searchWallpapers(String query, int page) async {
    final apiRequest = Uri.parse(
        UnsplashedApi.baseUrl + UnsplashedApi.getEndpointSearch(query, page));
    final apiResponse =
        await http.get(apiRequest, headers: UnsplashedApi.apiHeaders);
    final Map<String, dynamic> parsedJson = jsonDecode(apiResponse.body);
    final SearchResult result = SearchResult.fromJson(parsedJson);
    return result;
  }
}
