// Ignore this if not strictly pinning certificates, but here's a placeholder
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@injectable
class SslPinningInterceptor extends Interceptor {
  // If using native SSL pinning, you might not intercept it here.
  // Instead, you'd configure dio.httpClientAdapter (IOHttpClientAdapter)
  // to validate the badCertificateCallback or use fingerprinting.
  // This interceptor acts as a place-holder for any manual validation.
  
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
  }
}
