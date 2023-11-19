import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class TaskEditScreen extends StatefulWidget {
  final ParseObject task;

  const TaskEditScreen({super.key, required this.task});

  @override
  // ignore: library_private_types_in_public_api
  _TaskEditScreenState createState() => _TaskEditScreenState();
}

class _TaskEditScreenState extends State<TaskEditScreen> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.task['title']);
    descriptionController =
        TextEditingController(text: widget.task['description']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await _updateTask();
                Navigator.pop(context);
              },
              child: const Text('Update Task'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateTask() async {
    widget.task
      ..set('title', titleController.text)
      ..set('description', descriptionController.text);

    final ParseResponse apiResponse = await widget.task.save();

    if (!apiResponse.success) {
      // Handle error
      print(apiResponse.error);
    }
  }
}
