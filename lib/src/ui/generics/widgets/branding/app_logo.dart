import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      image: true,
      child: Image.asset(
        'assets/images/logo/seen_profit_logo.png',
        // The source logo is intentionally wide; give it enough horizontal
        // space so its full branding reads clearly while BoxFit.contain
        // preserves the original aspect ratio.
        width: size * 2.8,
        height: size,
        fit: BoxFit.contain,
      ),
    );
  }
}
