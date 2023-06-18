import 'package:flash_employee/models/notificationModel.dart';
import 'package:flash_employee/services/notifications_service.dart';
import 'package:flash_employee/utils/enum/statuses.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationsProvider extends ChangeNotifier {
  final NotificationsService notificationsService = NotificationsService();
  List<NotificationData>? notifications;
  bool loadingNotifications = true;

  Future getNotifications() async {
    loadingNotifications = true;
    notifyListeners();
    await notificationsService.getNotifications().then((value) {
      loadingNotifications = false;
      if (value.status == Status.success) {
        notifications = value.data as List<NotificationData>?;
      }
    });
    notifyListeners();
  }
}
