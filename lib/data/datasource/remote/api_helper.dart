import 'package:dio/dio.dart';
import 'package:katim_app/data/constant/remote_api_constant.dart';
import 'package:katim_app/data/datasource/remote/api_interceptor.dart';

class ApiHelper {
  static Dio _createDioRequest() {
    // Dio dio = Dio();
    Dio dio = Dio(BaseOptions(baseUrl: RemoteApiConstant.host));
    dio.interceptors.add(
      ApiInterceptor(),
    );
    return dio;
  }

  static Future<Response> createDioGetRequest(
    String endpoint,
  ) {
    return _createDioRequest().get(endpoint);
  }
}
