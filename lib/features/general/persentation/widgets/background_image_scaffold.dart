import 'package:cleanser/infrastructure/assets/assets.gen.dart';
import 'package:cleanser/infrastructure/assets/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A reusable scaffold widget that layers:
/// 1. Solid background color (default: [ColorName.primary])
/// 2. SVG background image (default: [Assets.icons.background])
/// 3. Child content on top
///
/// Use this widget on any page that needs the branded background pattern.
///
/// Example:
/// ```dart
/// BackgroundImageScaffold(
///   child: Column(
///     children: [
///       Text('Hello'),
///     ],
///   ),
/// )
/// ```
class BackgroundImageScaffold extends StatelessWidget {
  /// The content to display on top of the background layers.
  final Widget child;

  /// The solid background color behind the image.
  /// Defaults to [ColorName.primary].
  final Color backgroundColor;

  /// The SVG asset path used as the background image.
  /// Defaults to [Assets.icons.background].
  final String? backgroundAsset;

  /// How the background image should fit within the container.
  /// Defaults to [BoxFit.cover].
  final BoxFit backgroundFit;

  /// Alignment of the background image.
  /// Defaults to [Alignment.center].
  final Alignment backgroundAlignment;

  /// Opacity of the background image (0.0 - 1.0).
  /// Defaults to 1.0 (fully opaque).
  final double backgroundOpacity;

  /// Whether to use [SafeArea] around the child content.
  /// Defaults to true.
  final bool useSafeArea;

  const BackgroundImageScaffold({
    super.key,
    required this.child,
    this.backgroundColor = ColorName.primary,
    this.backgroundAsset,
    this.backgroundFit = BoxFit.cover,
    this.backgroundAlignment = Alignment.center,
    this.backgroundOpacity = 1.0,
    this.useSafeArea = true,
  });

  @override
  Widget build(BuildContext context) {
    final asset = backgroundAsset ?? Assets.icons.background;

    Widget content = child;
    if (useSafeArea) {
      content = SafeArea(child: content);
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Layer 2: Background image
          Positioned.fill(
            child: Opacity(
              opacity: backgroundOpacity,
              child: SvgPicture.asset(
                asset,
                fit: backgroundFit,
                alignment: backgroundAlignment,
              ),
            ),
          ),
          // Layer 3: Content on top
          content,
        ],
      ),
    );
  }
}
