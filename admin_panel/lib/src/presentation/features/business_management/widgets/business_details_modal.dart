import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../l10n/app_localizations.dart';
import '../../../../configs/localization/localization_extensions.dart';
import '../../../../core/responsive/admin_breakpoints.dart';
import '../../../../domain/models/business_details.dart';
import '../bloc/business_bloc.dart';
import '../bloc/business_event.dart';
import '../bloc/business_state.dart';

/// Opens a dialog on larger displays and a full-width bottom sheet on mobile.
Future<void> showBusinessDetailsModal({
  required BuildContext context,
  required BusinessDetails details,
  required bool isEditing,
}) {
  final bloc = context.read<BusinessBloc>();
  final child = BlocProvider.value(
    value: bloc,
    child: BusinessDetailsForm(details: details, isEditing: isEditing),
  );

  if (MediaQuery.sizeOf(context).width >= AdminBreakpoints.tablet) {
    return showDialog<void>(
      context: context,
      builder: (_) => Dialog(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: child,
        ),
      ),
    );
  }

  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (_) => Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: child,
    ),
  );
}

class BusinessDetailsForm extends StatefulWidget {
  const BusinessDetailsForm(
      {super.key, required this.details, required this.isEditing});

  final BusinessDetails details;
  final bool isEditing;

  @override
  State<BusinessDetailsForm> createState() => _BusinessDetailsFormState();
}

class _BusinessDetailsFormState extends State<BusinessDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late BusinessStatus _status;
  late String _tier;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.details.name);
    _emailController = TextEditingController(text: widget.details.email);
    _status = widget.details.status;
    _tier = widget.details.tier;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    context.read<BusinessBloc>().add(UpdateBusiness(BusinessDetails(
          id: widget.details.id,
          name: _nameController.text.trim(),
          owner: widget.details.owner,
          category: widget.details.category,
          email: _emailController.text.trim(),
          status: _status,
          tier: _tier,
        )));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocListener<BusinessBloc, BusinessState>(
      listenWhen: (previous, current) =>
          previous.updateStatus != current.updateStatus,
      listener: (context, state) {
        if (state.updateStatus == BusinessUpdateStatus.success) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.businessUpdated)),
          );
        } else if (state.updateStatus == BusinessUpdateStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.businessUpdateFailed)),
          );
        }
      },
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(children: [
                  Expanded(
                      child: Text(
                          widget.isEditing
                              ? l10n.editBusiness
                              : l10n.businessDetails,
                          style: Theme.of(context).textTheme.headlineSmall)),
                  IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      tooltip: l10n.close,
                      icon: const Icon(Icons.close)),
                ]),
                const SizedBox(height: 20),
                TextFormField(
                    controller: _nameController,
                    enabled: widget.isEditing,
                    decoration: InputDecoration(labelText: l10n.businessName),
                    validator: (value) => value == null || value.trim().isEmpty
                        ? l10n.requiredField
                        : null),
                const SizedBox(height: 16),
                TextFormField(
                    controller: _emailController,
                    enabled: widget.isEditing,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: l10n.email),
                    validator: (value) => value == null ||
                            !RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                                .hasMatch(value.trim())
                        ? l10n.invalidEmail
                        : null),
                const SizedBox(height: 16),
                DropdownButtonFormField<BusinessStatus>(
                    initialValue: _status,
                    decoration: InputDecoration(labelText: l10n.businessStatus),
                    items: BusinessStatus.values
                        .map((status) => DropdownMenuItem(
                            value: status,
                            child: Text(_statusLabel(l10n, status))))
                        .toList(),
                    onChanged: widget.isEditing
                        ? (value) => setState(() => _status = value!)
                        : null),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                    initialValue: _tier,
                    decoration: InputDecoration(labelText: l10n.assignedPlan),
                    items: ['starter', 'growth', 'enterprise']
                        .map((tier) => DropdownMenuItem(
                            value: tier, child: Text(_tierLabel(l10n, tier))))
                        .toList(),
                    onChanged: widget.isEditing
                        ? (value) => setState(() => _tier = value!)
                        : null),
                if (widget.isEditing) ...[
                  const SizedBox(height: 24),
                  BlocBuilder<BusinessBloc, BusinessState>(
                    buildWhen: (previous, current) =>
                        previous.updateStatus != current.updateStatus,
                    builder: (context, state) => FilledButton(
                      onPressed:
                          state.updateStatus == BusinessUpdateStatus.loading
                              ? null
                              : _save,
                      child: state.updateStatus == BusinessUpdateStatus.loading
                          ? const SizedBox.square(
                              dimension: 20,
                              child: CircularProgressIndicator(strokeWidth: 2))
                          : Text(l10n.saveChanges),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String _statusLabel(AppLocalizations l10n, BusinessStatus status) =>
    switch (status) {
      BusinessStatus.active => l10n.active,
      BusinessStatus.suspended => l10n.suspended,
      BusinessStatus.pending => l10n.pending,
    };

String _tierLabel(AppLocalizations l10n, String tier) => switch (tier) {
      'starter' => l10n.starterPlan,
      'growth' => l10n.growthPlan,
      'enterprise' => l10n.enterprisePlan,
      _ => tier,
    };
