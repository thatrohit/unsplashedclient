import 'dart:convert';

import 'package:unsplashed_client/modules/details/repositories/details_repository.dart';
import 'package:unsplashed_client/utils/api_helper.dart';
import 'package:http/http.dart' as http;

import '../../../models/details.dart';

class DetailsApiClient implements DetailsRepository {
  @override
  Future<DetailsResult> getPhotoDetails(String id) async {
    final apiRequest =
        Uri.parse(UnsplashedApi.baseUrl + UnsplashedApi.getEndpointDetails(id));
    final apiResponse =
        await http.get(apiRequest, headers: UnsplashedApi.apiHeaders);
    if (apiResponse.statusCode != 200) {
      throw Exception(
          "The network returned a failure. Please try again after some time");
    }
    final Map<String, dynamic> parsedJson = jsonDecode(apiResponse.body);
    final DetailsResult result = DetailsResult.fromJson(parsedJson);
    return result;
  }
}
