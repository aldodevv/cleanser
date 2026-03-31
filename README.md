# Cleanser 🌍♻️

A clean, modular, and scalable Flutter project.

---

## 🚀 Getting Started

This project uses **Flutter** starting with SDK version **^3.11** and relies heavily on code generation for Routing, Dependency Injection (DI), Asset Management, Localization, and Data Models.

### Prerequisites

- Flutter SDK (latest stable recommended)
- Dart SDK
- IDE (VS Code / Android Studio / IntelliJ)

### Initial Setup

After cloning this repository, fetch the packages and regenerate necessary files:

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

---

## 🛠️ Code Generation

This project uses various generators to reduce boilerplate. Below are the commands to generate them.

### Generate All Code (Recommended)
Since we use multiple generators (Freezed, Injectable, AutoRoute, Slang, FlutterGen, Retrofit), you can generate **everything** using a single command:

```bash
dart run build_runner build --delete-conflicting-outputs
```
*(Tip: If you saw `Could not find bin/build.dart in package build` error previously, make sure to use `build_runner` instead of `build runner`)*

### Watch Mode
If you are actively developing and modifying files that require generation (like routes, DI, models, or translations), run the watcher:

```bash
dart run build_runner watch --delete-conflicting-outputs
```

### 1. Localization / Language (Slang)
We use `slang` for type-safe i18n. Translations are located in `lib/infrastructure/l10n/translations/`.
If you only want to generate strings (without running the full build_runner), you can run:
```bash
dart run slang
```

### 2. Assets (FlutterGen)
We use `flutter_gen` to generate type-safe asset paths (images, icons, colors).
It generates `Assets` classes so you don't have to hardcode string paths. It runs automatically with `build_runner`.

---

## 🏃‍♂️ Running the App (Environments)

This project separates environments (DEV, UAT, PROD) using different entry points:
- `lib/main_dev.dart`
- `lib/main_uat.dart`
- `lib/main_prod.dart`

To run the application via terminal:

**DEV:**
```bash
flutter run -t lib/main_dev.dart
```

**UAT:**
```bash
flutter run -t lib/main_uat.dart
```

**PROD:**
```bash
flutter run -t lib/main_prod.dart
```
> **Note on Flavors:** If you have configured native Android Flavors or Xcode Schemes, you can append `--flavor dev`, `--flavor uat`, atau `--flavor prod` to the commands above. *If Xcode/Android flavors are not yet configured natively, simply omit the `--flavor` argument to avoid build errors.*

Alternatively, if you are using **VS Code**, you can go to the **Run and Debug** tab (`Cmd+Shift+D` / `Ctrl+Shift+D`) and choose the predefined launch configurations (`launch.json` is already set up).

---

## 📦 Building Releases (APK / AAB / IPA)

When you are ready to build the app for testing or production distribution.

### Build APK (for Android manual testing)

```bash
# DEV
flutter build apk -t lib/main_dev.dart

# UAT
flutter build apk -t lib/main_uat.dart

# PROD
flutter build apk -t lib/main_prod.dart
```
*(The output will be in `build/app/outputs/flutter-apk/app-release.apk`)*

### Build Appbundle (AAB) (for Google Play Store)

```bash
flutter build appbundle -t lib/main_prod.dart
```

### Build IPA (for iOS / App Store / TestFlight)

*(Requires macOS with Xcode installed)*

```bash
flutter build ipa -t lib/main_prod.dart --export-method app-store
```
If you need ad-hoc distribution, change `--export-method` to `ad-hoc` or omit it to specify later through Xcode Organizer.

---

## 🏗️ Architecture Overview

The app implements *Clean Architecture* and modular structures to keep things maintainable:

- **DI (Dependency Injection):** `get_it` + `injectable`
- **Routing:** `auto_route`
- **Network / API:** `dio` + `retrofit`
- **Models:** `freezed` + `json_serializable`
- **Localization:** `slang`
- **Sockets:** `web_socket_channel`
- **Security:** `flutter_secure_storage` + `encrypt`

---

## 📝 Tips & Troubleshooting

- **Build Runner Errors:** If `build_runner` throws conflicts, always append `--delete-conflicting-outputs`.
- **VS Code Errors on Launch:** We have configured `launch.json` properly. Just select your flavor on the Run tab.
- **Missing `.g.dart` or `.freezed.dart` files:** Always run `dart run build_runner build -d` when pulling new changes from Git.
