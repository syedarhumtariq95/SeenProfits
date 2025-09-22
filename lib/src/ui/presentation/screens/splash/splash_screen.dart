import 'package:flutter/material.dart';

import '../../../../configs/app/fonts_configs.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Splash Screen', style: FontTheme().textTheme.displayLarge),
          ],
        ),
      ),
    );
  }
}
