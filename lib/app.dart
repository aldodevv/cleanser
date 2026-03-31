import 'package:cleanser/infrastructure/l10n/translations/strings.g.dart';
import 'package:flutter/material.dart';

import 'infrastructure/routing/app_router.dart';
import 'infrastructure/theme/app_theme.dart';
import 'infrastructure/di/di_setup.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    debugPrint('--- APP WIDGET: initState ---');
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint('--- APP WIDGET: didChangeDependencies ---');
  }

  @override
  void didUpdateWidget(MainApp oldWidget) {
    super.didUpdateWidget(oldWidget);
    debugPrint('--- APP WIDGET: didUpdateWidget ---');
  }

  @override
  void deactivate() {
    debugPrint('--- APP WIDGET: deactivate ---');
    super.deactivate();
  }

  @override
  void dispose() {
    debugPrint('--- APP WIDGET: dispose ---');
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    debugPrint('AppLifecycleState changed to: $state');

    switch (state) {
      case AppLifecycleState.resumed:
        // TODO: App is visible and responding to user input.
        // Initialize services or resume background tasks here.
        debugPrint('--- APP RESUMED ---');
        break;
      case AppLifecycleState.inactive:
        // TODO: App is in an inactive state and not receiving user input.
        debugPrint('--- APP INACTIVE ---');
        break;
      case AppLifecycleState.paused:
        // TODO: App is running in the background, not visible to the user.
        // Pause services or save state here.
        debugPrint('--- APP PAUSED ---');
        break;
      case AppLifecycleState.detached:
        // TODO: App is detached from any host views.
        // Clean up resources here.
        debugPrint('--- APP DETACHED ---');
        break;
      case AppLifecycleState.hidden:
        // TODO: App is not visible to the user (Flutter 3.13+).
        debugPrint('--- APP HIDDEN ---');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final appRouter = getIt<AppRouter>();

    return MaterialApp.router(
      title: 'Cleanser',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: appRouter.config(),
      locale: TranslationProvider.of(context).flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
    );
  }
}
