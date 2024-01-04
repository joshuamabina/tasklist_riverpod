import 'package:flutter/material.dart';

import '../models/task.dart';
import '../screens/task.dart';

final List<TaskModel> _tasks = <TaskModel>[
  TaskModel('Buy milk', isCompleted: true),
  TaskModel('Drink coffee', description: "Sip energy, savor productive moments."),
  TaskModel('Build something amazing')
];


class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: const Text("Task List"),
      ),
      body: _tasks.isNotEmpty
          ? ListView.builder(
          itemCount: _tasks.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Checkbox(
                value: _tasks[index].isCompleted,
                onChanged: (item) => _toggleCompleted(_tasks[index]),
              ),
              title: _tasks[index].isCompleted == true
                  ? Text(_tasks[index].title,
                style: const TextStyle(decoration: TextDecoration.lineThrough),)
                  : Text(_tasks[index].title,),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TaskItem()
                  ),
                );
              },
            );
          })
          : const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'No tasks yet!',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return SizedBox(
                  height: 100,
                  child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: TextField(
                                onSubmitted: (value) {
                                  _createTask(value);
                                  Navigator.of(context).pop();
                                },
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'New task',
                                ),
                              ),
                            )
                          ]
                      )
                  ),
                );
              }
          );
        },
        tooltip: 'New task',
        label: const Text('New task'),
        icon: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _toggleCompleted(TaskModel task) {}

  void _createTask(String value) {}
}