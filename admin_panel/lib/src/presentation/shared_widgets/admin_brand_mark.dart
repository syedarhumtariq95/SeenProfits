import 'package:flutter/material.dart';

import '../../configs/localization/localization_extensions.dart';

class AdminBrandMark extends StatelessWidget {
  const AdminBrandMark({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/logo/seen_profit_logo.png',
          width: 38,
          height: 38,
          fit: BoxFit.contain,
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
