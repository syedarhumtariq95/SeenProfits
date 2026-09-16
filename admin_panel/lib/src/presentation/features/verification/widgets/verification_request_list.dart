import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../configs/localization/localization_extensions.dart';
import '../bloc/verification_bloc.dart';
import '../bloc/verification_event.dart';
import '../bloc/verification_state.dart';
import 'verification_request_card.dart';
import 'verification_shimmer.dart';

class VerificationRequestList extends StatelessWidget {
  const VerificationRequestList({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<VerificationBloc, VerificationState>(
        builder: (context, state) {
          if (state.loadStatus == VerificationLoadStatus.initial ||
              state.loadStatus == VerificationLoadStatus.loading) {
            return const VerificationShimmer();
          }
          if (state.loadStatus == VerificationLoadStatus.failure) {
            return Center(
              child: OutlinedButton.icon(
                onPressed: () => context
                    .read<VerificationBloc>()
                    .add(const FetchPendingVerifications()),
                icon: const Icon(Icons.refresh),
                label: Text(context.l10n.retry),
              ),
            );
          }
          if (state.requests.isEmpty) {
            return Center(child: Text(context.l10n.noPendingVerifications));
          }
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.requests.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) => VerificationRequestCard(
              request: state.requests[index],
              isLoading: state.processingId == state.requests[index].id,
            ),
          );
        },
      );
}
