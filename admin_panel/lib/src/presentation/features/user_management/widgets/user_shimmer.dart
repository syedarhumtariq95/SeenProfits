import 'package:flutter/material.dart';

class UserShimmer extends StatelessWidget {
  const UserShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.surfaceContainerHighest;
    return Card(
        child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: List.generate(
                  6,
                  (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: FractionallySizedBox(
                              widthFactor: index.isEven ? .9 : .65,
                              child: Container(
                                  height: 18,
                                  decoration: BoxDecoration(
                                      color: color,
                                      borderRadius: BorderRadius.circular(6))),
                            )),
                      )),
            )));
  }
}
