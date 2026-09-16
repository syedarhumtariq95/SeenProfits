import 'package:flutter/material.dart';

import '../../../../configs/localization/localization_extensions.dart';

class CategoryStatusChip extends StatelessWidget {
  const CategoryStatusChip({super.key, required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) => Chip(
        avatar: Icon(
          isActive ? Icons.check_circle : Icons.pause_circle,
          size: 16,
          color: isActive ? Colors.green : Colors.orange,
        ),
        label: Text(isActive ? context.l10n.active : context.l10n.inactive),
        visualDensity: VisualDensity.compact,
      );
}
