import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'completed_tasks_screen.dart';
import 'favorite_tasks_screen.dart';
import 'my_drawer.dart';
import 'pending_screen.dart';

import 'add_task_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);
  static const id = 'tabs_screen';

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, dynamic>> _pageDetails = [
    {'pageName': const PendingTasksScreen(), 'title': 'Tasks Waiting For You'},
    {'pageName': const CompletedTasksScreen(), 'title': 'Completed Tasks'},
    {'pageName': const FavoriteTasksScreen(), 'title': 'Favorite Tasks'},
  ];

  var _selectedPageIndex = 0;

  void _addTask(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: const AddTaskScreen(),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageDetails[_selectedPageIndex]['title'],
            style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
        elevation: 15,
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: const Icon(Icons.menu_open_outlined),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            onPressed: () => _addTask(context),
            icon: const Icon(Icons.add_task, color: Colors.white),
          )
        ],
      ),
      drawerScrimColor: Colors.indigo.withOpacity(0.3),
      drawer: const MyDrawer(),

      drawerEnableOpenDragGesture: true,
      body: _pageDetails[_selectedPageIndex]['pageName'],
      floatingActionButton: _selectedPageIndex == 0
          ? FloatingActionButton(
              onPressed: () => _addTask(context),
              tooltip: 'Add Task',
              child: const Icon(Icons.add_box_rounded),
        backgroundColor: Colors.indigo,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
           top: Radius.circular(18),
            bottom: Radius.circular(10),
          ),
        ),
            elevation: 15,
          )
          : null,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        shadow: const BoxShadow(
          color: Colors.indigo,
          blurRadius: 15,
        ),
        backgroundColor: Colors.indigo,
        activeColor: Colors.white,
        splashColor: Colors.white,
        inactiveColor: Colors.white.withOpacity(0.5),
        activeIndex: _selectedPageIndex,
        onTap: (index) {
          setState(() {
            _selectedPageIndex = index;
          });
        },
        gapWidth: 1,
        icons: const [
          Icons.pending_actions,
          Icons.done_all,
          Icons.favorite,
        ],
      ),
    );
  }
}
