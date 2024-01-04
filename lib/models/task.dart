class Task {
  Task(this.title, { this.description, this.isCompleted = false });

  final String title;
  final String? description;
  bool isCompleted = false;

  String getTask() => 'Task: $title';
}
