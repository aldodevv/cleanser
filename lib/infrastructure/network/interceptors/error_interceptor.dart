import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@injectable
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Handle specific status codes or error formats across the app here
    if (err.response?.statusCode == 401) {
      // e.g. Handle token expiration and refresh automatically
    } else if (err.response?.statusCode == 500) {
      // handle server down
    }
    
    // You can also format error messages from backend wrapper DTOs
    // final String? message = err.response?.data['message'];
    
    super.onError(err, handler);
  }
}
