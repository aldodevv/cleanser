import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ForgetAccountScreen extends StatelessWidget {
  const ForgetAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forget Account')),
      body: const Center(
        child: Text('Forget Account Screen'),
      ),
    );
  }
}
