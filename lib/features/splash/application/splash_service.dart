import 'package:cleanser/infrastructure/routing/app_router.dart';
import 'package:cleanser/infrastructure/routing/app_router.gr.dart';
import 'package:cleanser/infrastructure/storage/secure_storage_service.dart';
import 'package:injectable/injectable.dart';

@injectable
class SplashService {
  final SecureStorageService _storageService;
  final AppRouter _appRouter;

  SplashService(this._storageService, this._appRouter);

  /// Menjalankan inisialisasi awal aplikasi dan menentukan halaman mana yang harus dibuka.
  Future<void> initAppAndNavigate() async {
    // 1. Simulasi proses loading / fetching konfigurasi global awal
    await Future.delayed(const Duration(seconds: 2));

    // 2. Ambil semua flag dari local storage
    final isOnboardedStr = await _storageService.read(key: SecureStorageKeys.isOnboarded);
    final isFirstTimeOpenStr = await _storageService.read(key: SecureStorageKeys.isFirstTimeOpen);
    final token = await _storageService.read(key: SecureStorageKeys.accessToken);

    bool isOnboarded = isOnboardedStr == 'true';
    // Default true jika nilai storage masih null
    bool isFirstTimeOpen = isFirstTimeOpenStr == null || isFirstTimeOpenStr == 'true';
    // Dummy JWT check (Jika butuh cek expired berdasarkan Date, bisa pakai package jwt_decoder)
    bool isTokenExpired = token == null || token.isEmpty; 

    // 3. Routing Logic berdasarkan State Aplikasi
    if (isOnboarded) {
      if (isTokenExpired) {
        _appRouter.replace(const SignInRoute());
      } else {
        _appRouter.replace(const HomeRoute());
      }
    } else {
      if (isFirstTimeOpen) {
        // Tandai bahwa user sudah tidak pertama kali membuka app
        await _storageService.write(key: SecureStorageKeys.isFirstTimeOpen, value: 'false');
        
        _appRouter.replace(const OnboardRoute());
      } else {
        _appRouter.replace(const SignUpRoute());
      }
    }
  }
}
