import 'package:flutter/material.dart';
import 'package:todoey_flutter/models/database.dart';

class SQLiteExample extends StatefulWidget {
  const SQLiteExample({required this.date});

  final String? date;

  @override
  _SQLiteExampleState createState() => _SQLiteExampleState();
}

class _SQLiteExampleState extends State<SQLiteExample> {
  String? dateA;

  final TextEditingController _eventController = TextEditingController();

  void _saveData() async {
    String name = dateA.toString();
    String age = _eventController.text;
    await DatabaseHelper.insertData(name, age);

    _eventController.clear();
  }

  @override
  void initState() {
    super.initState();
    constants(
      widget.date,
    );
  }

  void constants(
    String? date,
  ) {
    dateA = date;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: Colors.lightBlue,
          title: const Text(
            'Set Reminder',
            style: TextStyle(
                fontStyle: FontStyle.normal,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          )),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 16, top: 40, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Set for $dateA'.toString(),
                style:
                    const TextStyle(fontStyle: FontStyle.italic, fontSize: 20),
              ),
              TextField(
                controller: _eventController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(labelText: 'Event'),
              ),
              const SizedBox(height: 20),
              MaterialButton(
                  height: 40,
                  color: Colors.lightBlue,
                  child: const Text('Save Event'),
                  onPressed: () {
                    setState(() {
                      _saveData();
                      Navigator.pushNamed(context, '/show_screen');
                    });
                  }),
              const SizedBox(height: 20),
              MaterialButton(
                height: 40,
                color: Colors.lightBlue,
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),

              const SizedBox(height: 23),
              // FutureBuilder<List<Map<String, dynamic>>>(
              //   future: DatabaseHelper.queryAllData(),
              //   builder: (context, snapshot) {
              //     if (snapshot.hasData) {
              //       List<Map<String, dynamic>> data = snapshot.data!;
              //       return ListView.builder(
              //         shrinkWrap: true,
              //         itemCount: data.length,
              //         itemBuilder: (context, index) {
              //           return ListTile(
              //             title: Text(data[index]['name']),
              //             subtitle: Text(data[index]['age'].toString()),
              //           );
              //         },
              //       );
              //     } else if (snapshot.hasError) {
              //       return Text('Error: ${snapshot.error}');
              //     }
              //     return const CircularProgressIndicator();
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
