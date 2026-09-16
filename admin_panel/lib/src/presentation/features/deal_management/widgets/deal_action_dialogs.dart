import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../configs/localization/localization_extensions.dart';
import '../../../../domain/models/deal_model.dart';
import '../bloc/deal_bloc.dart';
import '../bloc/deal_event.dart';

Future<void> showDealActionDialog(
    BuildContext context, DealModel deal, bool approve) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(approve
          ? context.l10n.approveProposalTitle
          : context.l10n.rejectProposalTitle),
      content: Text(approve
          ? context.l10n.approveProposalMessage(deal.businessName)
          : context.l10n.rejectProposalMessage(deal.businessName)),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(context.l10n.cancel)),
        FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(approve ? context.l10n.approve : context.l10n.reject)),
      ],
    ),
  );
  if (confirmed == true && context.mounted) {
    context
        .read<DealBloc>()
        .add(approve ? ApproveProposal(deal.id) : RejectProposal(deal.id));
  }
}
