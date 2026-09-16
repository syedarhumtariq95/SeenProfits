import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../configs/localization/localization_extensions.dart';
import '../../../../domain/models/verification_request.dart';
import '../bloc/verification_bloc.dart';
import '../bloc/verification_event.dart';
import 'verification_action_dialogs.dart';

class VerificationRequestCard extends StatelessWidget {
  const VerificationRequestCard(
      {super.key, required this.request, required this.isLoading});

  final VerificationRequest request;
  final bool isLoading;

  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(request.businessName,
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text('${context.l10n.cnicLabel}: ${request.cnic}'),
            const SizedBox(height: 8),
            Text(
                '${context.l10n.documentsLabel}: ${request.documents.join(', ')}'),
            const SizedBox(height: 16),
            Wrap(spacing: 12, runSpacing: 8, children: [
              FilledButton.icon(
                onPressed: isLoading ? null : () => _approve(context),
                icon: isLoading
                    ? const SizedBox.square(
                        dimension: 16,
                        child: CircularProgressIndicator(strokeWidth: 2))
                    : const Icon(Icons.check),
                label: Text(context.l10n.approve),
              ),
              OutlinedButton.icon(
                onPressed: isLoading ? null : () => _reject(context),
                icon: const Icon(Icons.close),
                label: Text(context.l10n.reject),
              ),
            ]),
          ]),
        ),
      );

  Future<void> _approve(BuildContext context) async {
    if (await showApproveBusinessDialog(context, request.businessName) ==
            true &&
        context.mounted) {
      context.read<VerificationBloc>().add(ApproveBusiness(request.id));
    }
  }

  Future<void> _reject(BuildContext context) async {
    final reason = await showRejectBusinessDialog(context);
    if (reason != null && context.mounted) {
      context.read<VerificationBloc>().add(RejectBusiness(request.id, reason));
    }
  }
}
