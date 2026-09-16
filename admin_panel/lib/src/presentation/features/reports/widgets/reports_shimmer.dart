import 'package:flutter/material.dart';

class ReportsShimmer extends StatefulWidget {
  const ReportsShimmer({super.key});

  @override
  State<ReportsShimmer> createState() => _ReportsShimmerState();
}

class _ReportsShimmerState extends State<ReportsShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 900))
    ..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FadeTransition(
        opacity: Tween<double>(begin: .35, end: .8).animate(_controller),
        child: Column(children: [
          GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(6, (_) => const _Block(height: 96))),
          const SizedBox(height: 16),
          const _Block(height: 250),
        ]),
      );
}

class _Block extends StatelessWidget {
  const _Block({required this.height});
  final double height;
  @override
  Widget build(BuildContext context) => Container(
      height: height,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12)));
}
