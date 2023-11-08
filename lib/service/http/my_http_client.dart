import 'package:bidbay_mobile/service/http/authenticated_interceptor.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

class MyHttpClient {
  static Client? _client;
  static void _initClient() {
    _client ??= InterceptedClient.build(interceptors: [AuthenticatedInterceptor()]);
  }
  static Client getClient() {
    if(_client == null){
      _initClient();
    }
    return _client!;
  }
}