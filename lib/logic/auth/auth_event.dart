import 'package:equatable/equatable.dart';

import 'bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class LogInAuthEvent extends AuthEvent {

  final User user;

  LogInAuthEvent(this.user);

  @override
  List<Object> get props => [user];
}

class LogOutAuthEvent extends AuthEvent {
  @override
  List<Object> get props => [];

}

class LoginFromCacheAuthEvent extends AuthEvent {

  @override
  List<Object> get props => [];
}
