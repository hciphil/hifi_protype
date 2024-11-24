import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Task {
  late String   taskName;
  late DateTime taskTime;
  late int      taskLoad;
  Task(this.taskName, this.taskTime, this.taskLoad);
}

class TasksView extends StatefulWidget {
  TasksView({super.key});
  

@override
  State<TasksView> createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  Task? selectedTask; // Holds the currently selected task

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
      ),
      body: selectedTask == null
          ? ScrollableList(
              onTaskSelected: showTaskDetails, // Pass the callback to show details
            )
          : TaskDetailView(
              task: selectedTask!,
              onBack: showTaskList, // Pass the callback to go back to the list
            ),
    );
  }

  // Method to show the list view
  void showTaskList() {
    setState(() {
      selectedTask = null;
    });
  }
  // Method to show task details
  void showTaskDetails(Task task) {
    setState(() {
      selectedTask = task;
    });
  }
}

class ScrollableList extends StatefulWidget {
  ScrollableList({required this.onTaskSelected});
  final Function(Task) onTaskSelected;
  @override
  _ScrollableListState createState() => _ScrollableListState();
}


class _ScrollableListState extends State<ScrollableList> {
List<Task> items = [  Task('dishes',DateTime.now(), 5),
                      Task('vacuum',DateTime.now(), 3),
                      Task('put kids to bed',DateTime.now(), 10),
];
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(items[index].taskName),
          onTap: () => widget.onTaskSelected(items[index]), // Notify parent when clicked
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }
}

class TaskDetailView extends StatelessWidget {
  final Task task;
  final VoidCallback onBack;

  TaskDetailView({required this.task, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: onBack, // Call the back callback
          child: Text('Back to Tasks'),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Task Name: ${task.taskName}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text('Task Time: ${task.taskTime}'),
              SizedBox(height: 16),
              Text('Task Load: ${task.taskLoad}'),
            ],
          ),
        ),
      ],
    );
  }
}

class TaskAdd extends StatelessWidget {
  late Task task;
  final VoidCallback onBack;

  TaskAdd(this.task, this.onBack);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: onBack, // Call the back callback
          child: Text('Back to Tasks'),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Task Name: ${task.taskName}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text('Task Time: ${task.taskTime}'),
              SizedBox(height: 16),
              Text('Task Load: ${task.taskLoad}'),
            ],
          ),
        ),
      ],
    );
  }
}