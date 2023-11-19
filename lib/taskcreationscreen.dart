import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class TaskCreationScreen extends StatefulWidget {
  const TaskCreationScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TaskCreationScreenState createState() => _TaskCreationScreenState();
}

class _TaskCreationScreenState extends State<TaskCreationScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Task'),
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
            const SizedBox(height: 16.0),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                await _saveTask();
              },
              child: const Text('Save Task'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveTask() async {
    final ParseObject task = ParseObject('Task')
      ..set<String>('title', titleController.text)
      ..set<String>('description', descriptionController.text);

    final ParseResponse apiResponse = await task.save();

    if (apiResponse.success) {
      Navigator.pop(context); // Navigate back to the task list screen
    } else {
      // Handle error
      print(apiResponse.error!.message);
    }
  }
}
