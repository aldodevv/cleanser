import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

@injectable
class EncryptionInterceptor extends Interceptor {
  // Use a proper key management system instead of hardcoded strings
  final _key = encrypt.Key.fromUtf8('my32lengthsupersecretnooneknows1');
  final _iv = encrypt.IV.fromLength(16);
  
  late final _encrypter = encrypt.Encrypter(encrypt.AES(_key));

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Example: Encrypt payload when it's a map
    if (options.data != null && options.data is Map<String, dynamic>) {
      final jsonString = jsonEncode(options.data);
      final encrypted = _encrypter.encrypt(jsonString, iv: _iv);
      
      options.data = {
        'payload': encrypted.base64,
      };
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Example: Decrypt response when backend sends encrypted payload
    if (response.data != null && response.data is Map && response.data.containsKey('payload')) {
      final encryptedData = response.data['payload'];
      try {
        final decryptedString = _encrypter.decrypt64(encryptedData, iv: _iv);
        response.data = jsonDecode(decryptedString);
      } catch (e) {
        // Handle decryption failure
      }
    }
    super.onResponse(response, handler);
  }
}
