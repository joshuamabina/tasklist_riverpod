import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/task.dart';
import 'screens/tasklist.dart';
import 'screens/task.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task List - Provider',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(primary: Colors.black),
        useMaterial3: true,
      ),
      home: const TaskList(),
    );
  }
}