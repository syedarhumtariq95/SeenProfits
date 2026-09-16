import '../../domain/models/notification_model.dart';
import '../../domain/repositories/notification_repository.dart';

class MockNotificationRepositoryImpl implements NotificationRepository {
  MockNotificationRepositoryImpl({
    this.networkLatency = const Duration(milliseconds: 450),
  });

  final Duration networkLatency;

  final List<NotificationModel> _notifications = [
    NotificationModel(
      id: 'notification-1',
      title: 'New investment opportunities',
      message:
          'Explore the latest businesses seeking investment on Seen Profits.',
      targetAudience: NotificationAudience.investors,
      sentAt: DateTime(2026, 9, 15, 10, 30),
      status: NotificationStatus.sent,
      totalRecipients: 12680,
    ),
    NotificationModel(
      id: 'notification-2',
      title: 'Complete your business profile',
      message:
          'Add the remaining details to help investors discover your business.',
      targetAudience: NotificationAudience.businessOwners,
      sentAt: DateTime(2026, 9, 12, 14, 15),
      status: NotificationStatus.sent,
      totalRecipients: 5840,
    ),
    NotificationModel(
      id: 'notification-3',
      title: 'Platform maintenance update',
      message: 'Scheduled maintenance will take place this weekend.',
      targetAudience: NotificationAudience.allUsers,
      sentAt: DateTime(2026, 9, 9, 9),
      status: NotificationStatus.failed,
      totalRecipients: 18420,
    ),
  ];

  @override
  Future<List<NotificationModel>> fetchSentNotifications() async {
    await _wait();
    return List.unmodifiable(_notifications);
  }

  @override
  Future<NotificationModel> sendBroadcastNotification({
    required String title,
    required String message,
    required NotificationAudience targetAudience,
  }) async {
    await _wait();
    final notification = NotificationModel(
      id: 'notification-${DateTime.now().microsecondsSinceEpoch}',
      title: title,
      message: message,
      targetAudience: targetAudience,
      sentAt: DateTime.now(),
      status: NotificationStatus.sent,
      totalRecipients: _recipientCount(targetAudience),
    );
    _notifications.insert(0, notification);
    return notification;
  }

  @override
  Future<NotificationModel> resendNotification(String notificationId) async {
    await _wait();
    final index =
        _notifications.indexWhere((item) => item.id == notificationId);
    if (index < 0) throw StateError('Notification not found');
    final existing = _notifications[index];
    final resent = NotificationModel(
      id: 'notification-${DateTime.now().microsecondsSinceEpoch}',
      title: existing.title,
      message: existing.message,
      targetAudience: existing.targetAudience,
      sentAt: DateTime.now(),
      status: NotificationStatus.sent,
      totalRecipients: _recipientCount(existing.targetAudience),
    );
    _notifications.insert(0, resent);
    return resent;
  }

  int _recipientCount(NotificationAudience audience) => switch (audience) {
        NotificationAudience.allUsers => 18420,
        NotificationAudience.investors => 12680,
        NotificationAudience.businessOwners => 5840,
      };

  Future<void> _wait() => Future<void>.delayed(networkLatency);
}
