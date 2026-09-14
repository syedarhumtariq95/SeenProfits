import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../configs/dependency_injection/dependency_injection.dart';
import '../../../configs/localization/localization_extensions.dart';
import '../../../domain/models/verification_request.dart';
import '../../shared_widgets/admin_page_header.dart';
import 'bloc/verification_bloc.dart';
import 'bloc/verification_event.dart';
import 'bloc/verification_state.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => AdminDependencyInjection.get<VerificationBloc>()
          ..add(const FetchPendingVerifications()),
        child: const _VerificationView(),
      );
}

class _VerificationView extends StatelessWidget {
  const _VerificationView();

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AdminPageHeader(title: context.l10n.verificationQueue),
            const SizedBox(height: 24),
            const Expanded(child: _VerificationList()),
          ],
        ),
      );
}

class _VerificationList extends StatelessWidget {
  const _VerificationList();

  @override
  Widget build(BuildContext context) => BlocBuilder<VerificationBloc, VerificationState>(
        builder: (context, state) {
          if (state.loadStatus == VerificationLoadStatus.initial ||
              state.loadStatus == VerificationLoadStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.loadStatus == VerificationLoadStatus.failure) {
            return Center(
              child: OutlinedButton.icon(
                onPressed: () => context.read<VerificationBloc>().add(const FetchPendingVerifications()),
                icon: const Icon(Icons.refresh),
                label: Text(context.l10n.retry),
              ),
            );
          }
          if (state.requests.isEmpty) {
            return const Center(child: Text('No pending verification requests.'));
          }
          return ListView.separated(
            itemCount: state.requests.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final request = state.requests[index];
              return _VerificationCard(request: request, isLoading: state.processingId == request.id);
            },
          );
        },
      );
}

class _VerificationCard extends StatelessWidget {
  const _VerificationCard({required this.request, required this.isLoading});

  final VerificationRequest request;
  final bool isLoading;

  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(request.businessName, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Text('CNIC: ${request.cnic}'),
              const SizedBox(height: 8),
              Text('Documents: ${request.documents.join(', ')}'),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 8,
                children: [
                  FilledButton.icon(
                    onPressed: isLoading ? null : () => _confirmApproval(context, request),
                    icon: isLoading ? const SizedBox.square(dimension: 16, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.check),
                    label: const Text('Approve'),
                  ),
                  OutlinedButton.icon(
                    onPressed: isLoading ? null : () => _showRejectDialog(context, request),
                    icon: const Icon(Icons.close),
                    label: const Text('Reject'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  Future<void> _confirmApproval(BuildContext context, VerificationRequest request) async {
    final approved = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Approve business?'),
        content: Text('Approve ${request.businessName} for verification?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext, false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(dialogContext, true), child: const Text('Approve')),
        ],
      ),
    );
    if (approved == true && context.mounted) {
      context.read<VerificationBloc>().add(ApproveBusiness(request.id));
    }
  }

  Future<void> _showRejectDialog(BuildContext context, VerificationRequest request) async {
    final controller = TextEditingController();
    final reason = await showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Reject business?'),
        content: TextField(
          controller: controller,
          autofocus: true,
          minLines: 2,
          maxLines: 4,
          decoration: const InputDecoration(labelText: 'Rejection reason'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              final value = controller.text.trim();
              if (value.isNotEmpty) Navigator.pop(dialogContext, value);
            },
            child: const Text('Reject'),
          ),
        ],
      ),
    );
    controller.dispose();
    if (reason != null && context.mounted) {
      context.read<VerificationBloc>().add(RejectBusiness(request.id, reason));
    }
  }
}
