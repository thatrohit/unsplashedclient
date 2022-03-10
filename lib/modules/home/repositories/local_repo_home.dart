import 'dart:convert';

import 'package:unsplashed_client/models/search.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:unsplashed_client/modules/home/repositories/home_repository.dart';
import 'package:unsplashed_client/utils/api_helper.dart';

class HomeLocalRepository implements HomeRepository {
  @override
  Future<SearchResult> getDesktopWallpapers() async {
    String data = "{}";
    try {
      data = await rootBundle
          .loadString(UnsplashedApi.endpointLocalDesktopWallpapers);
    } catch (e) {
      print(e);
    }
    final Map<String, dynamic> parsedJson = jsonDecode(data);
    final SearchResult result = SearchResult.fromJson(parsedJson);
    return result;
  }

  @override
  Future<SearchResult> getMobileWallpapers() async {
    String data = await rootBundle
        .loadString(UnsplashedApi.endpointLocalMobileWallpapers);
    final Map<String, dynamic> parsedJson = jsonDecode(data);
    final SearchResult result = SearchResult.fromJson(parsedJson);
    return result;
  }
}
