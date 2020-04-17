import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:fluttertrainer2/logic/add_post/add_post.dart';
import 'package:fluttertrainer2/logic/db/database.dart';

import './bloc.dart';

class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
  @override
  AddPostState get initialState => InitialAddPostState();

  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  Dio dio;
  MyDatabase database = MyDatabase();

  AddPostBloc() {
    BaseOptions options = new BaseOptions(
      baseUrl: "https://gorest.co.in/public-api",
      contentType: "application/json",
      connectTimeout: 5000,
      receiveTimeout: 3000,
      followRedirects: false,
      validateStatus: (status) {
        return status < 500;
      },
      headers: {
        "Authorization": "Bearer -EjGASQM2qGy6US3fO11r8eQJ9-Fnr1u2o0P",
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
    );
    dio = new Dio(options);
    dio.interceptors.add(LogInterceptor(responseBody: true));

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult data) {
      if (state is NeedToSync) {
        if ([ConnectivityResult.mobile, ConnectivityResult.wifi]
            .contains(data)) {
          add(RefreshSyncNeedState());
        }
      }
    });
  }

  @override
  Stream<AddPostState> mapEventToState(
    AddPostEvent event,
  ) async* {
    if (event is TryAddNewPost) {
      yield* addPost(event.title, event.body);
    } else if (event is SyncAllPosts) {
      yield AddingNewPost();
      List<AddPost> allPosts = await database.getPosts();
      yield await Future.delayed(Duration(seconds: 1), () => AllSynced());
    } else if (event is RefreshSyncNeedState) {
      yield await syncIfNeed();
    }
  }

  Future<AddPostState> syncIfNeed() {
    return _connectivity.checkConnectivity().then((value) {
      if (state is NeedToSync) {
        return NeedToSync([ConnectivityResult.mobile, ConnectivityResult.wifi]
            .contains(value));
      } else {
        return AllSynced();
      }
    });
  }

  Future<AddPostState> needSync() {
    return _connectivity.checkConnectivity().then((value) {
        return NeedToSync([ConnectivityResult.mobile, ConnectivityResult.wifi]
            .contains(value));
    });
  }

  Stream<AddPostState> addPost(String title, String body) async* {
    yield AddingNewPost();
    AddPost postToAdd = AddPost("1636", title, body);
    String data = json.encode(postToAdd.toJson());
    try {
      Response response = await dio.post("/posts", data: data);
      if (response.data["_meta"]["success"] == true) {
        yield AllSynced();
      } else {
        await database.createPost(postToAdd);
        yield await needSync();
      }
    } catch (e) {
      await database.createPost(postToAdd);
      yield await needSync();
    }
  }
}
