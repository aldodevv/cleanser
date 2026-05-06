import 'package:cleanser/infrastructure/l10n/translations/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app.dart';
import 'infrastructure/di/di_setup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies('prod');

  // Load environment variables
  await dotenv.load(fileName: ".env.prod");

  LocaleSettings.useDeviceLocale();

  runApp(TranslationProvider(child: const MainApp()));
}
