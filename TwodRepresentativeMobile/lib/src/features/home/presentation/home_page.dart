import 'package:flutter/material.dart';

import 'package:auto_route/annotations.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Twod (2D)'),
      ),
    );
  }
}
