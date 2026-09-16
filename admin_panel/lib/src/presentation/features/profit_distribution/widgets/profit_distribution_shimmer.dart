import 'package:flutter/material.dart';

class ProfitDistributionShimmer extends StatefulWidget {
  const ProfitDistributionShimmer({super.key});

  @override
  State<ProfitDistributionShimmer> createState() =>
      _ProfitDistributionShimmerState();
}

class _ProfitDistributionShimmerState extends State<ProfitDistributionShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FadeTransition(
        opacity: Tween<double>(begin: .35, end: .8).animate(_controller),
        child: Column(
          children: List.generate(
            4,
            (_) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: ColoredBox(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: const SizedBox(height: 72, width: double.infinity),
              ),
            ),
          ),
        ),
      );
}
