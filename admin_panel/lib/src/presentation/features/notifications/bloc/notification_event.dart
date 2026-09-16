import '../../../../domain/models/notification_model.dart';

sealed class NotificationEvent {
  const NotificationEvent();
}

class FetchNotifications extends NotificationEvent {
  const FetchNotifications();
}

class SendNotification extends NotificationEvent {
  const SendNotification({
    required this.title,
    required this.message,
    required this.targetAudience,
  });

  final String title;
  final String message;
  final NotificationAudience targetAudience;
}

class ResendNotification extends NotificationEvent {
  const ResendNotification(this.notificationId);
  final String notificationId;
}

class FilterNotifications extends NotificationEvent {
  const FilterNotifications({this.query, this.audience, this.status});

  final String? query;
  final NotificationAudience? audience;
  final NotificationStatus? status;
}
