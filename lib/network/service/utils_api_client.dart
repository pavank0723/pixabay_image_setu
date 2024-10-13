import 'package:dio/dio.dart';
import 'package:pixabay_image_setu/model/api/api.dart';
import 'package:retrofit/retrofit.dart';
part 'utils_api_client.g.dart';

@RestApi()
abstract class UtilsApiClient {
  factory UtilsApiClient(Dio dio, {String baseUrl}) = _UtilsApiClient;

  @GET("/")
  Future<ImageMainModel> fetchPixabayImages(
      @Query('key') String apiKey,
      @Query('image_type') String imageType,
      @Query('page') int page,);
}