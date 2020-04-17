import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertrainer2/logic/add_post/add_post_bloc.dart';
import 'package:fluttertrainer2/logic/add_post/add_post_event.dart';
import 'package:fluttertrainer2/logic/add_post/add_post_state.dart';
import 'package:fluttertrainer2/logic/auth/auth_bloc.dart';
import 'package:fluttertrainer2/logic/login/bloc.dart';
import 'package:fluttertrainer2/logic/posts/bloc.dart';

class AddPostPage extends StatefulWidget {
  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  AddPostBloc addPostBloc;

  @override
  void initState() {
    addPostBloc = AddPostBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => addPostBloc,
      child: Scaffold(
        body: BlocListener<AddPostBloc, AddPostState>(
          listener: (BuildContext context, AddPostState state) {
            if (state is AllSynced) {
              Scaffold.of(context).showSnackBar(SnackBar(content: Text("Dane zsynchronizowane"),));
            } else if (state is NeedToSync) {
              Scaffold.of(context).showSnackBar(SnackBar(content: Text("Dane zapisane do późniejszej synchronizacji"),));
            }
          },
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "Dodaj Post",
                      style: Theme.of(context).textTheme.headline,
                    ),
                    Container(
                      height: 16.0,
                    ),
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                          labelText: "Title",
                          border: OutlineInputBorder(),
                          hintText: 'Add title'),
                    ),
                    Container(
                      height: 16.0,
                    ),
                    TextField(
                      controller: bodyController,
                      decoration: InputDecoration(
                          labelText: "Body",
                          border: OutlineInputBorder(),
                          hintText: 'Put some body'),
                    ),
                    Container(
                      height: 16.0,
                    ),
                    BlocBuilder<AddPostBloc, AddPostState>(
                      builder: (BuildContext context, AddPostState state) {
                        if (state is InitialAddPostState || state is AllSynced || state is NeedToSync) {
                          return Container(
                            height: 50.0,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                child: Center(
                                  child: Text("Dodaj"),
                                ),
                                onTap: () {
                                  BlocProvider.of<AddPostBloc>(context).add(
                                      TryAddNewPost(titleController.text,
                                          bodyController.text));
                                },
                              ),
                            ),
                          );
                        } else if (state is AddingNewPost) {
                          return Container(
                              height: 50.0, child: Center(child: CircularProgressIndicator()));
                        } else {
                          return Container();
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    addPostBloc.close();
    super.dispose();
  }
}
