import 'package:equatable/equatable.dart';

import 'bloc.dart';

abstract class PostsState extends Equatable {
  const PostsState();
}

class InitialPostsState extends PostsState {
  @override
  List<Object> get props => [];
}

class DownloadingPostsState extends PostsState {
  @override
  List<Object> get props =>[];
}

class DataObtainedPostsState extends PostsState {
  final List<Post> posts;

  DataObtainedPostsState(this.posts);

  @override
  List<Object> get props => [posts.length];
}

class DownloadingErrorPostsState extends PostsState {

  final String errorMessage;

  DownloadingErrorPostsState(this.errorMessage);

  @override
  List<Object> get props =>[];
}

class EmptyDataPostsState extends PostsState {
  @override
  List<Object> get props =>[];
}
