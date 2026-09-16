import 'package:flutter/material.dart';

class NotificationShimmer extends StatelessWidget {
  const NotificationShimmer({super.key});

  @override
  Widget build(BuildContext context) => Column(children: [
        for (var index = 0; index < 4; index++)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: 18, width: 220, color: Colors.white12),
                    const SizedBox(height: 12),
                    Container(
                        height: 12,
                        width: double.infinity,
                        color: Colors.white12),
                    const SizedBox(height: 8),
                    Container(height: 12, width: 180, color: Colors.white12),
                  ]),
            ),
          ),
      ]);
}
