import 'package:equatable/equatable.dart';

abstract class AddPostEvent extends Equatable {
  const AddPostEvent();
}

class TryAddNewPost extends AddPostEvent {

  final String title;
  final String body;

  TryAddNewPost(this.title, this.body);

  @override
  List<Object> get props => [title, body];
}

class SyncAllPosts extends AddPostEvent {
  @override
  List<Object> get props => [];
}
