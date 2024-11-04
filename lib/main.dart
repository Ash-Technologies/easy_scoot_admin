import 'package:flutter/material.dart';
import 'package:easy_scoot_admin/pages/users/usersPage.dart';
import 'package:easy_scoot_admin/pages/ev/evpage.dart';
import 'package:easy_scoot_admin/pages/logs/logspage.dart';

void main() {
  runApp(const BottomTabBar());
}

class BottomTabBar extends StatelessWidget {
  const BottomTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.person),
                  onPressed: () {},
                ),
                const Text('EasyScoot Admin'),
                Spacer(),
                IconButton(
                  icon: const Icon(Icons.notifications),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [UsersPage(), EVPage(), LogsPage()],
          ),
          bottomNavigationBar: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.people)),
              Tab(icon: Icon(Icons.electric_scooter)),
              Tab(icon: Icon(Icons.article)),
            ],
          ),
        ),
      ),
    );
  }
}
