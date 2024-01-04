import 'package:flutter/material.dart';
import '../models/task.dart';

final List<TaskModel> _tasks = <TaskModel>[
  TaskModel('Buy milk', isCompleted: true),
  TaskModel('Drink coffee', description: "Sip energy, savor productive moments."),
  TaskModel('Build something amazing')
];

class TaskItem extends StatelessWidget {
  const TaskItem({super.key});

  @override
  Widget build(BuildContext context) {
    return _TaskItem();
  }
}

class _TaskItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const index = 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task List'),
      ),
      body: Center(
          child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextFormField(
                    style: _tasks[index].isCompleted == true
                        ? const TextStyle(fontSize: 32, decoration: TextDecoration.lineThrough)
                        : const TextStyle(fontSize: 32),
                    initialValue: _tasks[index].title,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                  TextFormField(
                    initialValue: _tasks[index].description,
                    decoration: const InputDecoration(
                      hintText: 'Add description',
                      border: InputBorder.none,
                    ),
                  ),
                ],
              )
          )
      ),
      bottomNavigationBar: BottomAppBar(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: GestureDetector(
              child: Container(
                alignment: Alignment.centerRight,
                child: _tasks[index].isCompleted == true
                    ? const Text('Mark uncompleted', style: TextStyle(fontWeight: FontWeight.bold,))
                    : const Text('Mark completed', style: TextStyle(fontWeight: FontWeight.bold,)),
              ),
              onTap: () {

                final task = _tasks[index];

                String snackBarMessage;
                if(task.isCompleted == true) {
                  task.isCompleted = !task.isCompleted;
                  snackBarMessage = 'Task marked uncompleted';
                } else {
                  task.isCompleted = !task.isCompleted;
                  snackBarMessage = 'Task marked completed';
                }

                // setState(() {});

                final snackBar = SnackBar(
                  content: Text(snackBarMessage),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      // _toggleCompleted(task, actionType: 'Undo');
                    },
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),
          )
      ),
    );
  }
}
