import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:katim_app/data/constant/remote_api_constant.dart';

class ApiInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String basicAuth =
        'Basic ${base64.encode(utf8.encode('${RemoteApiConstant.clientId}:${RemoteApiConstant.secreteId}'))}';

    options.headers.putIfAbsent('authorization', () => basicAuth);

    super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    super.onResponse(response, handler);
  }
}
