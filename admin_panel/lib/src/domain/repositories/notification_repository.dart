import '../models/notification_model.dart';

abstract class NotificationRepository {
  Future<List<NotificationModel>> fetchSentNotifications();

  Future<NotificationModel> sendBroadcastNotification({
    required String title,
    required String message,
    required NotificationAudience targetAudience,
  });

  Future<NotificationModel> resendNotification(String notificationId);
}
