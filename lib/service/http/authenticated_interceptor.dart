import 'dart:convert';

import 'package:bidbay_mobile/common/values.dart';
import 'package:http_interceptor/http_interceptor.dart';

class AuthenticatedInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    data.headers["Authorization"] = "Bearer $JWT_TOKEN_VALUE";
    return data;
  }
  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    data.body = utf8.decode(data.bodyBytes);
    return data;
  }
}