import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@injectable
class HeaderInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Add common headers, e.g., Accept, Content-Type
    options.headers['Accept'] = 'application/json';
    options.headers['Content-Type'] = 'application/json';
    
    // TODO: Add Token dynamically from SecureStorage
    // final token = await storage.read(key: 'token');
    // if (token != null) {
    //   options.headers['Authorization'] = 'Bearer $token';
    // }
    
    options.headers['x-flavor'] = const String.fromEnvironment('FLAVOR');

    super.onRequest(options, handler);
  }
}
