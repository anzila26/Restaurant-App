import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/setting/daily_reminder_provider.dart';
import 'package:restaurant_app/screen/setting/notification_setting.dart';
import 'package:restaurant_app/screen/setting/theme_setting.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    super.initState();

    context.read<DailyReminderProvider>().loadReminderSetting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ThemeSetting(),
              SizedBox(height: 10),
              NotificationSetting(),
            ],
          ),
        ),
      ),
    );
  }
}
