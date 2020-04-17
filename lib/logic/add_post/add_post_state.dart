import 'package:equatable/equatable.dart';

abstract class AddPostState extends Equatable {
  const AddPostState();
}

class InitialAddPostState extends AddPostState {
  @override
  List<Object> get props => [];
}

class AddingNewPost extends AddPostState {
  @override
  List<Object> get props => [];
}

class NeedToSync extends AddPostState {

  final bool canSync;

  NeedToSync(this.canSync);

  @override
  List<Object> get props => [canSync];
}

  class AllSynced extends AddPostState {

  @override
  List<Object> get props => [];
}
