import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/repositories/notification_repository.dart';
import 'notification_event.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc(this._repository) : super(const NotificationState()) {
    on<FetchNotifications>(_onFetch);
    on<SendNotification>(_onSend);
    on<ResendNotification>(_onResend);
    on<FilterNotifications>(_onFilter);
  }

  final NotificationRepository _repository;

  Future<void> _onFetch(
    FetchNotifications event,
    Emitter<NotificationState> emit,
  ) async {
    emit(state.copyWith(loadStatus: NotificationLoadStatus.loading));
    try {
      emit(state.copyWith(
        loadStatus: NotificationLoadStatus.success,
        notifications: await _repository.fetchSentNotifications(),
      ));
    } catch (_) {
      emit(state.copyWith(loadStatus: NotificationLoadStatus.failure));
    }
  }

  Future<void> _onSend(
    SendNotification event,
    Emitter<NotificationState> emit,
  ) async {
    emit(state.copyWith(actionStatus: NotificationActionStatus.loading));
    try {
      final sent = await _repository.sendBroadcastNotification(
        title: event.title,
        message: event.message,
        targetAudience: event.targetAudience,
      );
      emit(state.copyWith(
        actionStatus: NotificationActionStatus.success,
        notifications: [sent, ...state.notifications],
      ));
    } catch (_) {
      emit(state.copyWith(actionStatus: NotificationActionStatus.failure));
    }
  }

  Future<void> _onResend(
    ResendNotification event,
    Emitter<NotificationState> emit,
  ) async {
    emit(state.copyWith(actionStatus: NotificationActionStatus.loading));
    try {
      final resent = await _repository.resendNotification(event.notificationId);
      emit(state.copyWith(
        actionStatus: NotificationActionStatus.success,
        notifications: [resent, ...state.notifications],
      ));
    } catch (_) {
      emit(state.copyWith(actionStatus: NotificationActionStatus.failure));
    }
  }

  void _onFilter(
    FilterNotifications event,
    Emitter<NotificationState> emit,
  ) {
    emit(state.copyWith(
      query: event.query,
      audience: event.audience,
      status: event.status,
      clearAudience: event.audience == null,
      clearStatus: event.status == null,
    ));
  }
}
