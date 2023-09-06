import 'package:flutter/material.dart';

import 'package:todoey_flutter/widgets/task_tile.dart';
import 'package:todoey_flutter/models/task_data.dart';
import 'package:provider/provider.dart';
// import 'package:todoey_flutter/models/delete_pop.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            // final taskIndex = taskData.tasks;
            final taskIndex = taskData.tasks[index];
            return TaskTile(
              isChecked: taskIndex.isDone,
              taskTitle: taskIndex.name,
              callBack: (bool? isChecked) {
                taskData.checkTask(taskIndex);
              },
              longPressCallBack: () {
                taskData.deleteTask(taskIndex);
              },
            );
          },
          itemCount: taskData.taskCount,
        );
      },
    );
  }
}
