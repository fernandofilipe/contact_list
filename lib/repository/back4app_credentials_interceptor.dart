import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Back4AppDioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['X-Parse-Application-Id'] =
        dotenv.get('BACK4APP_VIACEP_APP_ID');
    options.headers['X-Parse-REST-API-Key'] =
        dotenv.get('BACK4APP_VIACEP_API_KEY');
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Do something with response data.
    // If you want to reject the request with a error message,
    // you can reject a `DioException` object using `handler.reject(dioError)`.
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Do something with response error.
    // If you want to resolve the request with some custom data,
    // you can resolve a `Response` object using `handler.resolve(response)`.
    return handler.next(err);
  }
}
