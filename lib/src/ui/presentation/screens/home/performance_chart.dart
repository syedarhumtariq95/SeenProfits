import 'package:flutter/material.dart';

class PerformancePoint {
  const PerformancePoint(this.month, this.revenue, this.expenses);
  final String month;
  final double revenue;
  final double expenses;
  double get profit => revenue - expenses;
}

/// Shared, deliberately labelled mock-performance visualization.
class PerformanceChart extends StatelessWidget {
  const PerformanceChart(
      {super.key,
      required this.data,
      this.verified = false,
      this.height = 190});
  final List<PerformancePoint> data;
  final bool verified;
  final double height;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Card(
        child: Padding(
            padding: const EdgeInsets.all(16),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                const Icon(Icons.insights_outlined),
                const SizedBox(width: 8),
                Text('Performance',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700)),
                const Spacer(),
                Chip(label: Text(verified ? 'Verified' : 'Self-reported'))
              ]),
              const SizedBox(height: 8),
              Wrap(spacing: 12, children: [
                _legend(Colors.teal, 'Revenue'),
                _legend(Colors.orange, 'Expenses'),
                _legend(colors.primary, 'Profit')
              ]),
              SizedBox(
                  height: height,
                  child: CustomPaint(
                      painter: _PerformancePainter(data, colors.primary))),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: data
                      .map((e) => Text(e.month,
                          style: Theme.of(context).textTheme.labelSmall))
                      .toList()),
              const SizedBox(height: 6),
              Text(
                  'Growth trend: +${((data.last.profit / data.first.profit - 1) * 100).round()}% profit over this period',
                  style: Theme.of(context).textTheme.bodySmall),
            ])));
  }

  Widget _legend(Color color, String text) =>
      Row(mainAxisSize: MainAxisSize.min, children: [
        Container(
            width: 9,
            height: 9,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 4),
        Text(text)
      ]);
}

class _PerformancePainter extends CustomPainter {
  const _PerformancePainter(this.data, this.primary);
  final List<PerformancePoint> data;
  final Color primary;
  @override
  void paint(Canvas canvas, Size size) {
    const pad = 8.0;
    final max = data.fold<double>(
        0,
        (v, e) => [v, e.revenue, e.expenses, e.profit]
            .reduce((a, b) => a > b ? a : b));
    final grid = Paint()
      ..color = primary.withOpacity(.12)
      ..strokeWidth = 1;
    for (var i = 1; i < 4; i++)
      canvas.drawLine(Offset(pad, size.height * i / 4),
          Offset(size.width - pad, size.height * i / 4), grid);
    void line(Color color, double Function(PerformancePoint) value) {
      final p = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..strokeCap = StrokeCap.round;
      final path = Path();
      for (var i = 0; i < data.length; i++) {
        final x = pad + (size.width - pad * 2) * i / (data.length - 1);
        final y =
            size.height - pad - (size.height - pad * 2) * value(data[i]) / max;
        i == 0 ? path.moveTo(x, y) : path.lineTo(x, y);
      }
      canvas.drawPath(path, p);
    }

    line(Colors.teal, (e) => e.revenue);
    line(Colors.orange, (e) => e.expenses);
    line(primary, (e) => e.profit);
  }

  @override
  bool shouldRepaint(covariant _PerformancePainter old) =>
      old.primary != primary || old.data != data;
}

const demoPerformance = [
  PerformancePoint('Apr', 170, 82),
  PerformancePoint('May', 185, 86),
  PerformancePoint('Jun', 178, 88),
  PerformancePoint('Jul', 205, 92),
  PerformancePoint('Aug', 222, 95),
  PerformancePoint('Sep', 240, 98)
];
