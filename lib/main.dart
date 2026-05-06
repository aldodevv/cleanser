import 'package:cleanser/infrastructure/l10n/translations/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app.dart';
import 'flavors.dart';
import 'infrastructure/di/di_setup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Determine flavor (fallback to dev if not specified)
  F.appFlavor = Flavor.values.firstWhere(
    (element) => element.name == appFlavor,
    orElse: () => Flavor.dev,
  );

  // Setup DI for current environment
  configureDependencies(F.appFlavor.name);

  // Load environment variables
  await dotenv.load(fileName: ".env.${F.appFlavor.name}");

  // Initialize Slang Localization
  LocaleSettings.useDeviceLocale();

  runApp(TranslationProvider(child: const MainApp()));
}
