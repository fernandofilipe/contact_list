import 'package:contact_list/repository/back4app_credentials_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Back4AppCustomDio {
  final _dio = Dio();

  Back4AppCustomDio() {
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.options.baseUrl = dotenv.get('BACK4APP_BASEURL');
    _dio.interceptors.add(Back4AppDioInterceptor());
  }

  Dio get dio => _dio;
}
