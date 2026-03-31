// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../network/dio_provider.dart' as _i651;
import '../network/interceptors/encryption_interceptor.dart' as _i550;
import '../network/interceptors/error_interceptor.dart' as _i511;
import '../network/interceptors/header_interceptor.dart' as _i463;
import '../network/interceptors/ssl_pinning_interceptor.dart' as _i162;
import '../routing/app_router.dart' as _i282;
import '../socket/socket_manager.dart' as _i1044;
import '../storage/secure_storage_service.dart' as _i666;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dioProvider = _$DioProvider();
    gh.factory<_i550.EncryptionInterceptor>(
      () => _i550.EncryptionInterceptor(),
    );
    gh.factory<_i511.ErrorInterceptor>(() => _i511.ErrorInterceptor());
    gh.factory<_i463.HeaderInterceptor>(() => _i463.HeaderInterceptor());
    gh.factory<_i162.SslPinningInterceptor>(
      () => _i162.SslPinningInterceptor(),
    );
    gh.lazySingleton<_i282.AppRouter>(() => _i282.AppRouter());
    gh.lazySingleton<_i1044.SocketManager>(() => _i1044.SocketManager());
    gh.lazySingleton<_i666.SecureStorageService>(
      () => _i666.SecureStorageService(),
    );
    gh.lazySingleton<_i361.Dio>(
      () => dioProvider.dio(
        gh<_i463.HeaderInterceptor>(),
        gh<_i511.ErrorInterceptor>(),
        gh<_i550.EncryptionInterceptor>(),
        gh<_i162.SslPinningInterceptor>(),
      ),
    );
    return this;
  }
}

class _$DioProvider extends _i651.DioProvider {}
