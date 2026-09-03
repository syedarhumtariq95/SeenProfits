import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      image: true,
      child: SvgPicture.asset(
        'assets/logo/seen_profits_mark.svg',
        width: size,
        height: size,
      ),
    );
  }
}
