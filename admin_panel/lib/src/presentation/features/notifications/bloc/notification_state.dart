import '../../../../domain/models/notification_model.dart';

enum NotificationLoadStatus { initial, loading, success, failure }

enum NotificationActionStatus { idle, loading, success, failure }

class NotificationState {
  const NotificationState({
    this.loadStatus = NotificationLoadStatus.initial,
    this.actionStatus = NotificationActionStatus.idle,
    this.notifications = const [],
    this.query = '',
    this.audience,
    this.status,
  });

  final NotificationLoadStatus loadStatus;
  final NotificationActionStatus actionStatus;
  final List<NotificationModel> notifications;
  final String query;
  final NotificationAudience? audience;
  final NotificationStatus? status;

  List<NotificationModel> get visibleNotifications {
    final normalized = query.trim().toLowerCase();
    return notifications.where((notification) {
      final matchesQuery = normalized.isEmpty ||
          notification.title.toLowerCase().contains(normalized) ||
          notification.message.toLowerCase().contains(normalized);
      return matchesQuery &&
          (audience == null || notification.targetAudience == audience) &&
          (status == null || notification.status == status);
    }).toList(growable: false);
  }

  int get totalRecipients =>
      notifications.fold(0, (total, item) => total + item.totalRecipients);

  int get sentCount => notifications
      .where((item) => item.status == NotificationStatus.sent)
      .length;

  NotificationState copyWith({
    NotificationLoadStatus? loadStatus,
    NotificationActionStatus? actionStatus,
    List<NotificationModel>? notifications,
    String? query,
    NotificationAudience? audience,
    NotificationStatus? status,
    bool clearAudience = false,
    bool clearStatus = false,
  }) =>
      NotificationState(
        loadStatus: loadStatus ?? this.loadStatus,
        actionStatus: actionStatus ?? this.actionStatus,
        notifications: notifications ?? this.notifications,
        query: query ?? this.query,
        audience: clearAudience ? null : audience ?? this.audience,
        status: clearStatus ? null : status ?? this.status,
      );
}
