import 'package:flutter/material.dart';

import '../../../../configs/localization/localization_extensions.dart';

Future<bool?> showApproveBusinessDialog(
        BuildContext context, String businessName) =>
    showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(context.l10n.approveBusinessTitle),
        content: Text(context.l10n.approveBusinessMessage(businessName)),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: Text(context.l10n.cancel)),
          FilledButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: Text(context.l10n.approve)),
        ],
      ),
    );

Future<String?> showRejectBusinessDialog(BuildContext context) async {
  final controller = TextEditingController();
  final reason = await showDialog<String>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(context.l10n.rejectBusinessTitle),
      content: TextField(
        controller: controller,
        autofocus: true,
        minLines: 2,
        maxLines: 4,
        decoration: InputDecoration(labelText: context.l10n.rejectionReason),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(context.l10n.cancel)),
        FilledButton(
          onPressed: () {
            final value = controller.text.trim();
            if (value.isNotEmpty) Navigator.pop(dialogContext, value);
          },
          child: Text(context.l10n.reject),
        ),
      ],
    ),
  );
  controller.dispose();
  return reason;
}
