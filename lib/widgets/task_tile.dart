import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final bool? isChecked;
  late bool decCheck;
  final String taskTitle;
  final void Function(bool?) callBack;
  final void Function() longPressCallBack;
  TaskTile(
      {Key? key,
      this.isChecked,
      required this.taskTitle,
      required this.callBack,
      required this.longPressCallBack})
      : super(key: key);
  bool decorationCheck() {
    if (isChecked == true) {
      decCheck = true;
    } else {
      decCheck = false;
    }
    return decCheck;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: longPressCallBack,
      title: Text(
        taskTitle,
        style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            decoration: decorationCheck() ? TextDecoration.lineThrough : null,
            color: Colors.blue),
      ),
      trailing: Checkbox(
        value: isChecked,
        activeColor: Colors.lightBlueAccent,
        onChanged: callBack,
      ),
    );
  }
}
