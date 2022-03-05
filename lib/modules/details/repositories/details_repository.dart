import 'package:unsplashed_client/models/details.dart';

import '../../../utils/api_helper.dart';

mixin DetailsRepository on UnsplashedApi {
  Future<DetailsResult> getPhotoDetails(String id);
}
