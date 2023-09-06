import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:todoey_flutter/screens/show_reminder.dart';
import 'package:todoey_flutter/screens/taskScreen.dart';
import 'package:todoey_flutter/models/task_data.dart';
import 'package:calendar_builder/calendar_builder.dart';
import 'package:todoey_flutter/widgets/calender.dart';

void main() {
  CalendarGlobals.showLogs = true;

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    pNotify();

    var initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = const IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: onSelectNotification,
    );
  }

  Future<void> pNotify() async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'reminder_channel',
      'Reminder Channel',
      // 'Channel for reminders',
      importance: Importance.max,
      priority: Priority.high,
    );
    // var record = ;
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.periodicallyShow(
        0,
        'Your tasks for today',
        'Check how many tasks you have left',
        RepeatInterval.hourly,
        platformChannelSpecifics,
        payload: 'You have to finish it',
        androidAllowWhileIdle: true);
  }

  Future<void> onSelectNotification(String? payload) async {
    if (payload != null) {
      // print('Notification tapped! Payload: $payload');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskData(),
      child: MaterialApp(
        initialRoute: '/task_screen',
        routes: {
          '/month_builder': (context) => MonthBuilderScreen(),
          '/task_screen': (context) => const TasksScreen(),
          // '/reminder_screen': (context) => SQLiteExample(),
          '/show_screen': (context) => const ShowReminder(),
        },
      ),
    );
  }
}
