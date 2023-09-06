import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../models/database.dart';

class ShowReminder extends StatefulWidget {
  const ShowReminder({Key? key}) : super(key: key);

  @override
  _ShowReminderState createState() => _ShowReminderState();
}

class _ShowReminderState extends State<ShowReminder> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  var scoreA = DateTime.now();

  List<Item> _items = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      bNotify();
    });

    _loadData();
  }

  Future<void> bNotify() async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'reminder_channel',
      'Reminder Channel',
      // 'Channel for reminders',
      importance: Importance.max,
      priority: Priority.high,
    );
    var nDate = scoreA.day.toString() +
        "-" +
        scoreA.month.toString() +
        "-" +
        scoreA.year.toString();
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    for (var name in _items) {
      if (nDate == name.name) {
        await flutterLocalNotificationsPlugin.show(
          0,
          'Reminder',
          name.description,
          platformChannelSpecifics,
        );
      }
    }
  }

  void _loadData() async {
    List<Item> items = await DatabaseHelper().getItems();
    setState(() {
      _items = items;
    });
  }

  void _deleteItem(int id) async {
    await DatabaseHelper().deleteItem(id);
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      bNotify();
    });
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          centerTitle: true,
          title: const Text(
            'Reminders',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return ListTile(
            tileColor: Colors.white12,
            contentPadding:
                const EdgeInsets.only(left: 13, right: 8, top: 7, bottom: 10),
            title: Text(
              _items[index].name,
              style: const TextStyle(
                  fontStyle: FontStyle.normal,
                  fontSize: 18,
                  color: Colors.lightBlue),
            ),
            subtitle: Text(
              _items[index].description,
              style: const TextStyle(
                  fontStyle: FontStyle.normal,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _deleteItem(_items[index].id),
            ),
          );
        },
      ),
    );
  }
}

//

//         child: Column(
//           children: [
//             FutureBuilder<List<Map<String, dynamic>>>(
//               future: DatabaseHelper.queryAllData(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   List<Map<String, dynamic>> data = snapshot.data!;
//                   return ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: data.length,
//                     itemBuilder: (context, index) {
//                       return ListTile(
//                         title: Text(
//                           data[index]['name'],

//                         ),
//                         subtitle: Text(
//                           data[index]['age'].toString(),

//                         ),
//                       );
//                     },
//                   );
//                 } else if (snapshot.hasError) {
//                   return Text('Error: ${snapshot.error}');
//                 }
//                 return const CircularProgressIndicator();
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// Text(_items[index].name),
