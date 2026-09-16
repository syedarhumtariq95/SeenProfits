enum NotificationAudience { allUsers, investors, businessOwners }

enum NotificationStatus { sent, pending, failed }

class NotificationModel {
  const NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.targetAudience,
    required this.sentAt,
    required this.status,
    required this.totalRecipients,
  });

  final String id;
  final String title;
  final String message;
  final NotificationAudience targetAudience;
  final DateTime sentAt;
  final NotificationStatus status;
  final int totalRecipients;
}
