import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';

import 'app_router.gr.dart';

@LazySingleton()
@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    // Splash Routes
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: OnboardRoute.page),

    // Auth Routes
    AutoRoute(page: SignInRoute.page),
    AutoRoute(page: SignUpRoute.page),
    AutoRoute(page: ForgetPasswordRoute.page),
    AutoRoute(page: TermsConditionRoute.page),
    AutoRoute(page: VerifyOtpRoute.page),

    // Used for deep UI link configuration
    AutoRoute(page: ChangePasswordRoute.page, path: '/change-password'),
    AutoRoute(page: ForgetAccountRoute.page),

    // Main Routes
    AutoRoute(page: HomeRoute.page),
    AutoRoute(page: ServicesRoute.page),
    AutoRoute(page: SubscribePlanRoute.page),
    AutoRoute(page: ProfileRoute.page),
  ];
}
