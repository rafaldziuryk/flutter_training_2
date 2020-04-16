import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import './bloc.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  @override
  PostsState get initialState => InitialPostsState();

  Dio dio;

  PostsBloc(){
    BaseOptions options = new BaseOptions(
      baseUrl: "https://gorest.co.in/public-api",
      connectTimeout: 5000,
      receiveTimeout: 3000,
      headers: {
        "Authorization" : "Bearer -EjGASQM2qGy6US3fO11r8eQJ9-Fnr1u2o0P"
      },
    );
    dio = new Dio(options);
    dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  @override
  Stream<PostsState> mapEventToState(
    PostsEvent event,
  ) async* {
    if (event is RefreshEvent) {
      yield* refreshData();
    }
  }

  Stream<PostsState> refreshData() async* {
    yield DownloadingPostsState();
    Response response = await dio.get("/posts");
    if (response.data["_meta"]["success"] == true) {
      if (response.data["result"].isNotEmpty) {
        List rawPosts = response.data["result"];
        List<Post> posts = rawPosts.map((element) => Post.fromJson(element)).toList();
        yield DataObtainedPostsState(posts);
      } else {
        yield EmptyDataPostsState();
      }
    } else {
      yield DownloadingErrorPostsState("Błędny request");
    }
  }
}
