import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SubscribePlanScreen extends StatelessWidget {
  const SubscribePlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Subscribe Plan')),
      body: const Center(
        child: Text('Subscribe Plan Screen'),
      ),
    );
  }
}
