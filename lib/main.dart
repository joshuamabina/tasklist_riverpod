import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task List - BLoC',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(primary: Colors.black),
        useMaterial3: true,
      ),
      home: const Tasks(title: 'Tasks'),
    );
  }
}

class Tasks extends StatefulWidget {
  const Tasks({super.key, required this.title});
  final String title;

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  final List<Task> _tasks = <Task>[Task('Buy milk', isCompleted: true), Task('Drink coffee'), Task('Build something amazing')];

  void _createTask(newTask) {
    setState(() {
      _tasks.add(Task(newTask));
    });
  }

  void _toggleCompleted(Task item, { String? actionType }) {
    final index = _tasks.indexWhere((element) => element.title == item.title);
    _tasks[index].isCompleted = !item.isCompleted;

    setState(() {});

    if(actionType == 'Undo' || item.isCompleted == false) return;

    const snackBarMessage = 'Task completed';
    final snackBar = SnackBar(
      content: const Text(snackBarMessage),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          _toggleCompleted(item, actionType: 'Undo');
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
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
                  ? Text(_tasks[index].title, style: const TextStyle(decoration: TextDecoration.lineThrough),)
                  : Text(_tasks[index].title,),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) {
                        return Scaffold(
                          appBar: AppBar(
                            title: const Text('Tasks'),
                          ),
                          body: const Center(
                            child: Text('Task details go here!'),
                          ),
                        );
                      }
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
}

class Task {
  final String title;
  final String? description;
  bool isCompleted = false;

  Task(this.title, { this.description, this.isCompleted = false });
}
