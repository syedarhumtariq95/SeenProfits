import 'package:flutter/material.dart';

class CategoryShimmer extends StatelessWidget {
  const CategoryShimmer({super.key});

  @override
  Widget build(BuildContext context) => GridView.builder(
        itemCount: 4,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 360,
          mainAxisExtent: 270,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemBuilder: (_, __) => Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(height: 28, width: 180, color: Colors.white12),
              const SizedBox(height: 22),
              Container(
                  height: 14, width: double.infinity, color: Colors.white12),
              const SizedBox(height: 10),
              Container(height: 14, width: 220, color: Colors.white12),
            ]),
          ),
        ),
      );
}
