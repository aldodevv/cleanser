import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:cleanser/infrastructure/assets/colors.gen.dart';
import 'package:cleanser/infrastructure/di/di_setup.dart';
import 'package:cleanser/features/splash/application/splash_service.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Memulai proses pengecekan logic (onboard, token, delay) melalui Service (Application level)
    getIt<SplashService>().initAppAndNavigate();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ColorName.primary,
      body: Center(
        child: CircularProgressIndicator(
          color: ColorName.textInverse,
        ),
      ),
    );
  }
}
