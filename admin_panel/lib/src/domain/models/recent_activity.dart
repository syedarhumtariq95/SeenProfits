enum RecentActivityType {
  businessApproved,
  businessSubmitted,
  businessSuspended,
  revenueReceived
}

class RecentActivity {
  const RecentActivity({
    required this.id,
    required this.type,
    required this.subject,
    required this.occurredAt,
  });

  final String id;
  final RecentActivityType type;
  final String subject;
  final DateTime occurredAt;
}
