import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertrainer2/logic/auth/auth_bloc.dart';
import 'package:fluttertrainer2/logic/auth/auth_event.dart';
import 'package:fluttertrainer2/logic/auth/auth_state.dart';
import 'package:fluttertrainer2/view/add_post.dart';
import 'package:fluttertrainer2/view/posts.dart';

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
      body: body(),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              BlocBuilder<AuthBloc, AuthState>(
                builder: (BuildContext context, AuthState state) {
                  if (state is LoggedInAuthState) {
                    return ListTile(
                        leading: Icon(Icons.person),
                        title: Text("Zalogowano: ${state.user.firstName}"),
                        subtitle: Text("Kliknij, aby wylogować"),
                        onTap: () {
                          BlocProvider.of<AuthBloc>(context)
                              .add(LogOutAuthEvent());
                        });
                  } else if (state is LoggedOutAuthState) {
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
              ),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (BuildContext context, AuthState state) {
                  bool enabled = false;
                  if (state is LoggedInAuthState) {
                    enabled = state.user.hasRole("posts");
                  }
                  return ListTile(
                      enabled: enabled,
                      leading: Icon(Icons.insert_drive_file),
                      title: Text("Posty"),
                      onTap: () {
                        Navigator.of(context).pop();
                        setState(() {
                          selectedDrawerItem = 1;
                        });
                      });
                },
              ),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (BuildContext context, AuthState state) {
                  bool enabled = false;
                  if (state is LoggedInAuthState) {
                    enabled = state.user.hasRole("add_post");
                  }
                  return ListTile(
                      enabled: enabled,
                      leading: Icon(Icons.note_add),
                      title: Text("Dodaj Posta"),
                      onTap: () {
                        Navigator.of(context).pop();
                        setState(() {
                          selectedDrawerItem = 2;
                        });
                      });
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget body() {
    switch (selectedDrawerItem) {
      case 1: return PostPage();
      case 2: return AddPostPage();
      default: return Container();
    }
  }
}
