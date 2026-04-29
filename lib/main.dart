import 'package:cleanser/infrastructure/l10n/translations/strings.g.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'infrastructure/di/di_setup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Setup DI for default environment (dev)
  configureDependencies('prod');

  // Initialize Slang Localization
  LocaleSettings.useDeviceLocale();

  runApp(TranslationProvider(child: const MainApp()));
}
