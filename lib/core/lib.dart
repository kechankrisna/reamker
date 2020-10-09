import 'package:dio/dio.dart';
import 'app.dart';

Dio getDio() {
  Dio dio = new Dio();
  // Set default configs
  dio.options.baseUrl = "$app_url/wp-json/wp/v2";
  dio.options.connectTimeout = 60 * 1000; //60 seconds
  dio.options.receiveTimeout = 60 * 1000; //60 seconds
  dio.options.followRedirects = false;
  dio.options.validateStatus = (status) => status <= 500;

  dio.interceptors.add(InterceptorsWrapper(onRequest: (Options options) async {
    // options.headers["Content-Type"] = "application/x-www-form-urlencoded";
    options.headers['Accept'] = "application/json";
  }));

  //print every request
  // dio.interceptors.add(LogInterceptor(responseBody: false));
  return dio;
}
