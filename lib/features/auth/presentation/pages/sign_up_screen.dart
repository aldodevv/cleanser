import 'package:auto_route/auto_route.dart';
import 'package:cleanser/infrastructure/assets/colors.gen.dart';
import 'package:flutter/material.dart';

class FeatureData {
  final String title;
  final int crossAxisCellCount;
  final double height;
  final Color? color;

  FeatureData({
    required this.title,
    this.crossAxisCellCount = 1,
    required this.height,
    this.color,
  });
}

@RoutePage()
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.primary,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [const SizedBox(height: 24)],
        ),
      ),
    );
  }
}
