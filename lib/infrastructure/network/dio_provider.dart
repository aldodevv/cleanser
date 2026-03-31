import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'interceptors/encryption_interceptor.dart';
import 'interceptors/error_interceptor.dart';
import 'interceptors/header_interceptor.dart';
import 'interceptors/ssl_pinning_interceptor.dart';

@module
abstract class DioProvider {
  @lazySingleton
  Dio dio(
    HeaderInterceptor headerInterceptor,
    ErrorInterceptor errorInterceptor,
    EncryptionInterceptor encryptionInterceptor,
    SslPinningInterceptor sslPinningInterceptor,
  ) {
    final dio = Dio();

    // Base URL configuration can be tied to Flavors dynamically
    // final flavor = const String.fromEnvironment('FLAVOR');

    dio.options = BaseOptions(
      // baseUrl: baseUrl, // Set via Flavors
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
    );

    // Order matters
    dio.interceptors.addAll([
      headerInterceptor,
      encryptionInterceptor,
      errorInterceptor,
      sslPinningInterceptor,
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (obj) => print(obj.toString()),
      ),
    ]);

    return dio;
  }
}
