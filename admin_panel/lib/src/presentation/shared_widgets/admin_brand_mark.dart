import 'package:flutter/material.dart';

import '../../configs/localization/localization_extensions.dart';
import '../../configs/theme/admin_theme_colors.dart';

class AdminBrandMark extends StatelessWidget {
  const AdminBrandMark({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            gradient: AdminThemeColors.brandGradient,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.trending_up_rounded, color: Colors.white),
        ),
        if (!compact) ...[
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              context.l10n.appName,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
      ],
    );
  }
}
