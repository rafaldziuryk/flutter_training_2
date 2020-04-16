import 'package:equatable/equatable.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();
}

class RefreshEvent extends PostsEvent {
  @override
  List<Object> get props => [];
}
