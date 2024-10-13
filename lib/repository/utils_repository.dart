import 'package:dio/dio.dart';

import 'package:pixabay_image_setu/model/api/api.dart';
import 'package:pixabay_image_setu/network/service/utils_api_client.dart';
import 'package:pixabay_image_setu/network/utils/api_constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class UtilsRepository {
  late Dio _dio;
  late UtilsApiClient _utilsApiClient;

  UtilsRepository() {
    _dio = Dio();
    _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        compact: false));
    _utilsApiClient =
        UtilsApiClient(_dio, baseUrl: '${ApiConstants.baseApiUrl}/');
  }

  Future<ImageMainModel> fetchPixabayImages(
      String imageType, int page) async {
    String apiKey = ApiConstants.apiKey;
    return _utilsApiClient.fetchPixabayImages(apiKey, imageType, page);
  }
}
