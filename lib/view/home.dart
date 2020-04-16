import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertrainer2/logic/auth/auth_bloc.dart';
import 'package:fluttertrainer2/logic/auth/auth_event.dart';
import 'package:fluttertrainer2/logic/auth/auth_state.dart';

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
              BlocBuilder<AuthBloc, AuthState>(
                builder: (BuildContext context, AuthState state) {
                  if (state is LoggedInAuthState) {
                    return ListTile(
                        leading: Icon(Icons.person),
                        title: Text("Wyloguj"),
                        onTap: () {
                          BlocProvider.of<AuthBloc>(context).add(LogOutAuthEvent());
                        });
                  } else if (state is LoggedOutAuthState){
                    return ListTile(
                        leading: Icon(Icons.person),
                        title: Text("Zaloguj"),
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pushNamed("/login");
                        });
                  } else {
                    return Container(
                      width: 0.0,
                      height: 0.0,
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
