import 'package:flutter/material.dart';

import '../blocs/bloc_exports.dart';
import '../models/task.dart';
import '../services/guid_gen.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          const Text(
            'Add Task',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: TextFormField(
              autofocus: true,
              controller: titleController,
              decoration: const InputDecoration(
                label: Text('Title', style: TextStyle(color: Colors.indigo)),
                border: OutlineInputBorder(),
                icon: Icon(Icons.title, color: Colors.indigo),
                helperText: 'Enter the title of the task',
                helperStyle: TextStyle(color: Colors.indigo),
                fillColor: Colors.indigo,
                hoverColor: Colors.indigo,
                focusColor: Colors.indigo,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.indigo),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.indigo),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.indigo),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
          ),
          TextFormField(
            autofocus: true,
            controller: descriptionController,
            minLines: 3,
            maxLines: 5,
            decoration: const InputDecoration(
              label: Text('Description', style: TextStyle(color: Colors.indigo)),
              border: OutlineInputBorder(),
              icon: Icon(Icons.description, color: Colors.indigo),
              helperText: 'Enter the description of the task',
              helperStyle: TextStyle(color: Colors.indigo),
              fillColor: Colors.indigo,
              hoverColor: Colors.indigo,
              focusColor: Colors.indigo,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.indigo),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.indigo),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.indigo),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a description';
              }
              return null;
            },
          ),
          const Divider(
            height: 30,
            color: Colors.indigo,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel', style: TextStyle(color: Colors.white)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.indigo,
                ),
                onPressed: () {
                  var task = Task(
                    title: titleController.text,
                    description: descriptionController.text,
                    id: GUIDGen.generate(),
                    date: DateTime.now().toString(),
                  );
                  context.read<TasksBloc>().add(AddTask(task: task));
                  Navigator.pop(context);
                },
                child: const Text('Add Task', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
