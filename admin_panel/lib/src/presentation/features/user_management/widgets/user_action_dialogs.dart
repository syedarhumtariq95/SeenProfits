import 'package:flutter/material.dart';

import '../../../../configs/localization/localization_extensions.dart';
import '../../../../domain/models/user_model.dart';

Future<bool> confirmUserStatusChange(
    BuildContext context, UserModel user) async {
  final action = user.status == UserStatus.active
      ? context.l10n.suspend
      : context.l10n.activate;
  return await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(context.l10n.changeUserStatus),
          content:
              Text(context.l10n.changeUserStatusMessage(user.name, action)),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(context.l10n.cancel)),
            FilledButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text(action)),
          ],
        ),
      ) ??
      false;
}
