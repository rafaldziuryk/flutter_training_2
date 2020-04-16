import 'package:flutter/material.dart';
import 'package:fluttertrainer2/view/home.dart';
import 'package:fluttertrainer2/view/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (settings) {
        switch(settings.name) {
          case "/login" : return MaterialPageRoute(builder: (BuildContext context) => LoginPage());
          default: return MaterialPageRoute(builder: (BuildContext context) => HomePage());
        }
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Column()));
  }
}
