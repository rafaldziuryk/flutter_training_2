import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:fluttertrainer2/logic/add_post/add_post.dart';

import './bloc.dart';

class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
  @override
  AddPostState get initialState => InitialAddPostState();

  Dio dio;

  AddPostBloc() {
    BaseOptions options = new BaseOptions(
      baseUrl: "https://gorest.co.in/public-api",
      contentType: "application/json",
      connectTimeout: 5000,
      receiveTimeout: 3000,
      followRedirects: false,
      validateStatus: (status) { return status < 500; },
      headers: {
        "Authorization": "Bearer -EjGASQM2qGy6US3fO11r8eQJ9-Fnr1u2o0P",
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
    );
    dio = new Dio(options);
    dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  @override
  Stream<AddPostState> mapEventToState(
    AddPostEvent event,
  ) async* {
    if (event is TryAddNewPost) {
      yield* addPost(event.title, event.body);
    }
  }

  Stream<AddPostState> addPost(String title, String body) async* {
    yield AddingNewPost();
    AddPost postToAdd = AddPost("1636", title, body);
    String data = json.encode(postToAdd.toJson());
    Response response = await dio.post("/posts", data: data);
    if (response.data["_meta"]["success"] == true) {
      yield AllSynced();
    } else {
      yield NeedToSync(true);
    }
  }
}
