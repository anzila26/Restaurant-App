import 'package:flutter/material.dart';
import 'package:restaurant_app/services/notification_Services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DailyReminderProvider extends ChangeNotifier {
  final NotificationService _notificationService;

  DailyReminderProvider(this._notificationService);

  int _notificationId = 0;
  bool? _permission = false;
  bool? get permission => _permission;

  bool _isReminderActive = false;
  bool get isReminderActive => _isReminderActive;

  Future<void> requestPermissions() async {
    _permission = await _notificationService.requestPermissions();
    notifyListeners();
  }

  Future<void> loadReminderSetting() async {
    final prefs = await SharedPreferences.getInstance();
    _isReminderActive = prefs.getBool('isReminderActive') ?? false;
    notifyListeners();
  }

  Future<void> setReminder(bool value) async {
    _isReminderActive = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isReminderActive', value);

    if (value) {
      _notificationId += 1;
      _notificationService.scheduleDailyElevenAMNotification(
        id: _notificationId,
      );
    } else {
      await _notificationService.cancelNotification(_notificationId);
    }
    notifyListeners();
  }
}
