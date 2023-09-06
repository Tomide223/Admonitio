import 'package:flutter/material.dart';

import 'package:todoey_flutter/models/task_data.dart';
import 'package:todoey_flutter/screens/addTaskScreen.dart';
import 'package:todoey_flutter/widgets/task_list.dart';
import 'package:provider/provider.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  var scoreA = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<TaskData>(context, listen: false).loadData();

    super.initState();
  }

  Future<void> bNotify() async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'reminder_channel',
      'Reminder Channel',
      // 'Channel for reminders',
      importance: Importance.max,
      priority: Priority.high,
    );

    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      2,
      'Your tasks for today',
      'You have ${Provider.of<TaskData>(context, listen: false).taskCount}  tasks left',
      platformChannelSpecifics,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.lightBlueAccent,
          child: const Icon(
            Icons.add,
          ),
          tooltip: "Add task",
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => AddTaskScreen(),
            );
          }),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 70.0,
              right: 15.0,
              left: 15.0,
              bottom: 30.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/month_builder');
                      },
                      child: CircleAvatar(
                        child: Icon(
                          Icons.calendar_today,
                          size: 30.0,
                          color: Colors.lightBlueAccent.shade400,
                        ),
                        backgroundColor: Colors.white,
                        radius: 25.0,
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/show_screen');
                      },
                      child: CircleAvatar(
                        child: Icon(
                          Icons.assignment_sharp,
                          size: 30.0,
                          color: Colors.lightBlueAccent.shade400,
                        ),
                        backgroundColor: Colors.white,
                        radius: 20.0,
                      ),
                    ),
                    // ElevatedButton(
                    //   onPressed: bNotify,
                    //   child: const Text('Send P'),
                    // ),
                    // ElevatedButton(
                    //   onPressed: () => rNotify,
                    //   child: const Text('Send Re'),
                    // ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text(
                  'Admonitio',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 50.0,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic),
                ),
                const SizedBox(
                  height: 7.0,
                ),
                Text(
                  scoreA.day.toString() +
                      "-" +
                      scoreA.month.toString() +
                      "-" +
                      scoreA.year.toString(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 7.0,
                ),
                Text(
                  ' ${Provider.of<TaskData>(context).taskCount} Tasks',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(80.0),
                  topLeft: Radius.circular(80.0),
                ),
              ),
              child: TaskList(),
            ),
          ),
        ],
      ),
    );
  }
}

// class NotificationManager {
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//
//
//
//
//   Future<void> initialize() async {
//     final initializationSettingsAndroid =
//         AndroidInitializationSettings('app_icon');
//     final initializationSettingsIOS = IOSInitializationSettings();
//     final initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//     );
//
//     flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onSelectNotification: onSelectNotification, // Add this line
//     );
//
//
//   Future<void> showNotification({
//     required int id,
//     required String title,
//     required String body,
//   }) async {
//     // ...
//   }
//
//   Future<void> onSelectNotification(String? payload) async {
//     if (payload != null) {
//       // Handle notification tap while the app is in the background
//       print('Notification tapped! Payload: $payload');
//     }
//   }
// }

// class MyApp extends StatelessWidget {
//   final NotificationManager notificationManager = NotificationManager();
//
//   @override
//   Widget build(BuildContext context) {
//     notificationManager.initialize();
//
//     return MaterialApp(
//       home: NotificationExample(notificationManager: notificationManager),
//     );
//   }
// }

// class NotificationExample extends StatefulWidget {
//   final NotificationManager notificationManager;
//
//   NotificationExample({required this.notificationManager});
//
//   @override
//   _NotificationExampleState createState() => _NotificationExampleState();
// }
//
// class _NotificationExampleState extends State<NotificationExample> {
//   @override
//   void initState() {
//     super.initState();
//
//     // Set up callback to handle notifications while app is in the foreground
//     widget.notificationManager.flutterLocalNotificationsPlugin
//         .setMethodCallHandler((call) async {
//       if (call.method == 'onDidReceiveLocalNotification') {
//         final payload = call.arguments['payload'];
//         if (payload != null) {
//           // Handle notification while the app is in the foreground
//           print('Notification received while app is in use! Payload: $payload');
//         }
//       }
//     });
//   }
//
//   void _sendNotification() {
//     widget.notificationManager.showNotification(
//       id: 1,
//       title: 'Notification Title',
//       body: 'This is the notification body.',
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Notification Example')),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: _sendNotification,
//           child: Text('Send Notification'),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// class TasksScreen extends StatefulWidget {
//   @override
//   _TasksScreenState createState() => _TasksScreenState();
// }
//
// class _TasksScreenState extends State<TasksScreen> {
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   @override
//   void initState() {
//     super.initState();
//
//     var initializationSettingsAndroid =
//     AndroidInitializationSettings('app_icon');
//     var initializationSettingsIOS = IOSInitializationSettings();
//     var initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//     );
//
//     flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onSelectNotification: onSelectNotification,
//     );
//   }
//
//   Future<void> pNotify() async {
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       'reminder_channel',
//       'Reminder Channel',
//       'Channel for reminders',
//       importance: Importance.max,
//       priority: Priority.high,
//     );
//
//     var platformChannelSpecifics =
//     NotificationDetails(android: androidPlatformChannelSpecifics);
//
//     await flutterLocalNotificationsPlugin.show(
//       0,
//       'Your tasks for today',
//       'You have tasks left',
//       platformChannelSpecifics,
//     );
//   }
//
//   Future<void> rNotify(DateTime dateTime) async {
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       'reminder_channel',
//       'Reminder Channel',
//       'Channel for reminders',
//       importance: Importance.max,
//       priority: Priority.high,
//     );
//
//     var platformChannelSpecifics =
//     NotificationDetails(android: androidPlatformChannelSpecifics);
//
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       1,
//       'You have this on your reminder',
//       'This is a reminder message',
//       tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
//       platformChannelSpecifics,
//       uiLocalNotificationDateInterpretation:
//       UILocalNotificationDateInterpretation.absoluteTime,
//     );
//   }
//
//   Future<void> onSelectNotification(String? payload) async {
//     if (payload != null) {
//       print('Notification tapped! Payload: $payload');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // ... Your existing code ...
//       ElevatedButton(
//         onPressed: pNotify,
//         child: const Text('Send Periodic Notification'),
//       ),
//       ElevatedButton(
//         onPressed: () => rNotify(DateTime.now()),
//         child: const Text('Send Reminder Notification'),
//       ),
//       // ... Rest of your code ...
//     );
//   }
// }
