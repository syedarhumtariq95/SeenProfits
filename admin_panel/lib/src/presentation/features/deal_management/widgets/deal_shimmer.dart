import 'package:flutter/material.dart';

class DealShimmer extends StatelessWidget {
  const DealShimmer({super.key});
  @override
  Widget build(BuildContext context) => Column(
        children: List.generate(
            4,
            (index) => Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(children: [
                      const CircleAvatar(
                          radius: 24, backgroundColor: Colors.white12),
                      const SizedBox(width: 16),
                      Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Container(
                                height: 16, width: 180, color: Colors.white12),
                            const SizedBox(height: 10),
                            Container(
                                height: 12, width: 260, color: Colors.white12),
                          ])),
                    ]),
                  ),
                )),
      );
}
