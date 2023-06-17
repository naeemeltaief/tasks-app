import 'package:flutter/material.dart';
import 'recycle_bin.dart';
import 'tabs_screen.dart';

import '../blocs/bloc_exports.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SafeArea(
            child: Container(
              height: 150,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              color: Colors.transparent,
              child: Center(
                child: isDarkTheme(context)
                    ? Image.asset(
                        'assets/images/logo_d.png',
                        fit: BoxFit.contain,
                      )
                    : Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.contain,
                      ),
              ),
            ),
          ),
          BlocBuilder<TasksBloc, TasksState>(
            builder: (context, state) {
              return GestureDetector(
                onTap: () => Navigator.of(context).pushReplacementNamed(
                  TabsScreen.id,
                ),
                child: ListTile(
                  leading: const Icon(Icons.pending_actions),
                  title: const Text('Tasks'),
                  trailing: Text(
                      '${state.pendingTasks.length} | ${state.completedTasks.length}'),
                ),
              );
            },
          ),
          const Divider(),
          BlocBuilder<TasksBloc, TasksState>(
            builder: (context, state) {
              return GestureDetector(
                onTap: () => Navigator.of(context).pushReplacementNamed(
                  RecycleBin.id,
                ),
                child: ListTile(
                  selected: true,
                  selectedColor: Colors.red,
                  leading: const Icon(Icons.delete),
                  title: const Text('Recycle Bin'),
                  trailing: Text('${state.removedTasks.length}'),
                ),
              );
            },
          ),
          const Divider(),
          BlocBuilder<SwitchBloc, SwitchState>(
            builder: (context, state) {
              return ListTile(
                leading: isDarkTheme(context)
                    ? const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.dark_mode),
                          SizedBox(width: 32),
                          Text('Dark Theme'),
                        ],
                      )
                    : const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.light_mode),
                          SizedBox(width: 32),
                          Text('Light Theme'),
                        ],
                      ),
                trailing: Switch(
                  activeColor: Colors.indigo,
                  value: state.switchValue,
                  onChanged: (newValue) {
                    newValue
                        ? context.read<SwitchBloc>().add(SwitchOnEvent())
                        : context.read<SwitchBloc>().add(SwitchOffEvent());
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

isDarkTheme(BuildContext context) {
  if (Theme.of(context).brightness == Brightness.dark) {
    return true;
  } else {
    return false;
  }
}
