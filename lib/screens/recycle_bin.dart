import 'package:flutter/material.dart';

import '../blocs/bloc_exports.dart';
import '../widgets/tasks_list.dart';
import 'my_drawer.dart';

class RecycleBin extends StatelessWidget {
  const RecycleBin({Key? key}) : super(key: key);

  static const id = 'recycle_bin_screen';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.indigo,
            title: const Text('Recycle Bin',
                style: TextStyle(color: Colors.white)),
            leading: Builder(
              builder: (context) => IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: const Icon(Icons.menu_open_outlined),
              ),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            actions: [
              PopupMenuButton(
                color: Colors.white,
                  itemBuilder: (context) => [
                        PopupMenuItem(
                            child: TextButton.icon(
                              onPressed: null,
                              icon: const Icon(Icons.delete_forever,
                                  color: Colors.red),
                              label: const Text('Delete all tasks'),
                            ),
                            onTap: () => context
                                .read<TasksBloc>()
                                .add(DeleteAllTasks())),
                      ])
            ],
          ),
          drawer: const MyDrawer(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Chip(
                  label: Text(
                    '${state.removedTasks.length} Tasks',
                  ),
                ),
              ),
              TasksList(tasksList: state.removedTasks)
            ],
          ),
        );
      },
    );
  }
}
