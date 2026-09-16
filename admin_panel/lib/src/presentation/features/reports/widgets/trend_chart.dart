import 'package:flutter/material.dart';

import '../../../../domain/models/analytics_report_model.dart';

class TrendChart extends StatelessWidget {
  const TrendChart(
      {super.key,
      required this.title,
      required this.points,
      required this.valueSuffix});

  final String title;
  final List<AnalyticsTrendPoint> points;
  final String valueSuffix;

  @override
  Widget build(BuildContext context) {
    final maximum = points.fold<double>(
        0, (max, point) => point.value > max ? point.value : max);
    return Card(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 20),
              SizedBox(
                  height: 170,
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        for (final point in points)
                          Expanded(
                              child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                            '${point.value.toStringAsFixed(1)}$valueSuffix',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall),
                                        const SizedBox(height: 6),
                                        AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 400),
                                            height: maximum == 0
                                                ? 0
                                                : 105 * point.value / maximum,
                                            decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                borderRadius: const BorderRadius
                                                    .vertical(
                                                    top: Radius.circular(6)))),
                                        const SizedBox(height: 6),
                                        Text(point.label,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall),
                                      ]))),
                      ])),
            ])));
  }
}
