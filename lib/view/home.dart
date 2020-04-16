import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedDrawerItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My App"),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              ListTile(
                  leading: Icon(Icons.person),
                  title: Text("Zaloguj"),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed("/login");
                  })
            ],
          ),
        ),
      ),
    );
  }
}
