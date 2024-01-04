import 'package:flutter/foundation.dart';

class TaskModel extends ChangeNotifier {
  TaskModel(this.title, { this.description, this.isCompleted = false });

  final String title;
  final String? description;
  bool isCompleted = false;

  String get task => title;
}
