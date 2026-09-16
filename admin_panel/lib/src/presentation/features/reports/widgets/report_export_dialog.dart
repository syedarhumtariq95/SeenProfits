import 'package:flutter/material.dart';

import '../../../../configs/localization/localization_extensions.dart';

Future<String?> showReportExportDialog(BuildContext context) =>
    showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.exportReport),
        content: Text(context.l10n.chooseExportFormat),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, 'csv'),
              child: const Text('CSV')),
          FilledButton(
              onPressed: () => Navigator.pop(context, 'pdf'),
              child: const Text('PDF')),
        ],
      ),
    );
