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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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
  final List<String> _tasks = ['Buy milk', 'Drink coffee', 'Build something amazing'];

  void _createTask() {
    setState(() {
      String newTask = 'New random task ${_tasks.length + 1}';
      _tasks.add(newTask);
    });
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
            return ListTile(title: Text(_tasks[index]));
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
                return const SizedBox(
                  height: 100,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: TextField(
                            decoration: InputDecoration(
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
