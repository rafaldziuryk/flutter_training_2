import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertrainer2/logic/add_post/add_post_bloc.dart';
import 'package:fluttertrainer2/logic/auth/auth_bloc.dart';
import 'package:fluttertrainer2/view/home.dart';
import 'package:fluttertrainer2/view/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AddPostBloc(),
      child: BlocProvider(
        create: (BuildContext context) => AuthBloc(),
        child: MaterialApp(
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
        ),
      ),
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
