import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/setting/daily_reminder_provider.dart';

class NotificationSetting extends StatelessWidget {
  const NotificationSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DailyReminderProvider>(
      builder: (context, dailyReminderProvider, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Daily Lunch Reminder',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SwitchListTile(
                title: const Text('Enable Daily Reminder'),
                value: dailyReminderProvider.isReminderActive,
                onChanged: (bool value) async {
                  await dailyReminderProvider.setReminder(value);
                },
                subtitle: const Text('Get notified at 11:00 AM every day'),
              ),
            ],
          ),
        );
      },
    );
  }
}
