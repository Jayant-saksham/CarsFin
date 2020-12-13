import 'package:flutter/material.dart';
import 'Dashboard.dart';
import 'Users.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            backgroundColor: Colors.indigo,
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.dashboard),
                  text: "Dashboard",
                ),
                Tab(
                  text: "Users",
                  icon: Icon(Icons.person),
                ),
              ],
            ),
            title: Text("Admin Panel"),
            centerTitle: true,
          ),
          body: TabBarView(
            children: [
              dashboard(),
              Icon(Icons.dashboard),
            ],
          ),
        ),
      ),
    );
  }
}
