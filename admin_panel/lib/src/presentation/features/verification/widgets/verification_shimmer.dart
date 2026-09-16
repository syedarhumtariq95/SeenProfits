import 'package:flutter/material.dart';

class VerificationShimmer extends StatelessWidget {
  const VerificationShimmer({super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: List.generate(
          2,
          (index) => const Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: Card(child: SizedBox(height: 156, child: _ShimmerBlock())),
          ),
        ),
      );
}

class _ShimmerBlock extends StatefulWidget {
  const _ShimmerBlock();

  @override
  State<_ShimmerBlock> createState() => _ShimmerBlockState();
}

class _ShimmerBlockState extends State<_ShimmerBlock>
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
        child: ColoredBox(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          child: const SizedBox.expand(),
        ),
      );
}
